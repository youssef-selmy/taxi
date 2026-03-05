import 'package:api_response/api_response.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/documents/profile.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/profile.fragment.graphql.dart';
import 'package:admin_frontend/core/repositories/profile_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:rxdart/rxdart.dart';
import 'package:admin_frontend/core/graphql/fragments/token.fragment.graphql.dart';

@prod
@LazySingleton(as: ProfileRepository)
class ProfileRepositoryProd implements ProfileRepository {
  final GraphqlDatasource graphqlDatasource;

  ProfileRepositoryProd(this.graphqlDatasource);

  @override
  Stream<ApiResponse<Fragment$profile>> get profileStream =>
      _profileStream.stream;

  final BehaviorSubject<ApiResponse<Fragment$profile>> _profileStream =
      BehaviorSubject<ApiResponse<Fragment$profile>>();

  @override
  Stream<ApiResponse<List<String>>> get supportedCurrenciesStream =>
      _supportedCurrenciesStream.stream;

  final BehaviorSubject<ApiResponse<List<String>>> _supportedCurrenciesStream =
      BehaviorSubject<ApiResponse<List<String>>>();

  @override
  Future<ApiResponse<Fragment$profile>> getProfile() async {
    _profileStream.add(ApiResponse.loading());
    final profile = await graphqlDatasource.query(
      Options$Query$Profile(fetchPolicy: FetchPolicy.noCache),
    );
    _profileStream.add(profile.mapData((r) => r.me));
    return profile.mapData((r) => r.me);
  }

  @override
  Future<ApiResponse<List<String>>> getSupportedCurrencies() async {
    final supportedCurrenciesOrError = await graphqlDatasource.query(
      Options$Query$supportedCurrencies(),
    );
    _supportedCurrenciesStream.add(
      supportedCurrenciesOrError.mapData((r) => r.supportedCurrencies),
    );
    return supportedCurrenciesOrError.mapData((r) => r.supportedCurrencies);
  }

  @override
  Future<ApiResponse<Fragment$profile>> updateProfile({
    required Input$UpdateProfileInput input,
  }) async {
    final profileOrError = await graphqlDatasource.mutate(
      Options$Mutation$updateProfile(
        variables: Variables$Mutation$updateProfile(input: input),
      ),
    );
    _profileStream.add(profileOrError.mapData((r) => r.updateProfile));
    return profileOrError.mapData((r) => r.updateProfile);
  }

  @override
  Future<ApiResponse<Fragment$token>> login({
    required String email,
    required String password,
  }) async {
    final result = await graphqlDatasource.query(
      Options$Query$Login(
        variables: Variables$Query$Login(email: email, password: password),
      ),
    );
    return result.mapData((r) => r.login2);
  }

  @override
  Future<ApiResponse<String>> refreshToken({
    required String refreshToken,
  }) async {
    final result = await graphqlDatasource.query(
      Options$Query$refreshToken(
        variables: Variables$Query$refreshToken(refreshToken: refreshToken),
      ),
    );
    return result.mapData((r) => r.refreshToken.accessToken);
  }
}
