import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:gql_dio_link/gql_dio_link.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/graphql/app_socket_link.dart';
import 'package:admin_frontend/core/locator/locator.config.dart';
import 'package:admin_frontend/build_info.dart';
import 'package:sentry_link/sentry_link.dart';
import 'package:sentry_dio/sentry_dio.dart';

final locator = GetIt.instance;

@InjectableInit()
void configureDependencies() =>
    locator.init(environment: Env.useMockApi ? dev.name : prod.name);

@module
abstract class ServiceModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @factoryMethod
  GraphQLClient create() {
    final gqlUrl = Uri.parse(
      Env.apiBaseUrl,
    ).replace(path: '${Uri.parse(Env.apiBaseUrl).path}/graphql').toString();

    final authLink = AuthLink(
      getToken: () async {
        final authBloc = locator<AuthBloc>();
        final token = authBloc.state.accessToken;

        // Check if token needs refresh
        if (token != null && _shouldRefreshToken(authBloc.state)) {
          final newToken = await authBloc.refreshToken();
          return newToken != null ? 'Bearer $newToken' : null;
        }

        return token == null ? null : 'Bearer $token';
      },
      headerKey: 'Authorization',
    );

    final httpLink = DioLink(
      gqlUrl,
      client: Dio()..addSentry(),
      serializer: SentryRequestSerializer(),
      parser: SentryResponseParser(),
      defaultHeaders: {
        'X-client-version': appVersion,
        'X-client-platform': kIsWeb ? 'web' : Platform.operatingSystem,
      },
    );

    final httpLinkWithAuth = authLink.concat(httpLink);

    final subscriptionUrl = gqlUrl.replaceAll('http', 'ws');
    final websocketLink = AppSocketLink(subscriptionUrl);

    final link = Link.from([DedupeLink()]).split(
      (request) => request.isSubscription,
      websocketLink,
      httpLinkWithAuth,
    );

    return GraphQLClient(
      link: link,
      queryRequestTimeout: const Duration(seconds: 10),
      defaultPolicies: DefaultPolicies(
        query: Policies(fetch: FetchPolicy.noCache),
        mutate: Policies(fetch: FetchPolicy.noCache),
        subscribe: Policies(fetch: FetchPolicy.noCache),
      ),
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }

  bool _shouldRefreshToken(AuthState state) {
    if (state.refreshToken?.isEmpty ?? true) return false;

    // Refresh if token expires within 5 minutes
    final now = DateTime.now();
    final expiryBuffer = DateTime.fromMillisecondsSinceEpoch(
      JWT.decode(state.accessToken!).payload['exp'] * 1000,
    ).subtract(const Duration(minutes: 5));

    return now.isAfter(expiryBuffer);
  }
}
