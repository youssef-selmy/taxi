import 'dart:async';

import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/notifications.fragment.graphql.dart';
import 'package:admin_frontend/core/repositories/notifications_repository.dart';
import 'package:admin_frontend/features/notifications/data/graphql/notifications.graphql.dart';

@prod
@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  @override
  Stream<ApiResponse<List<Fragment$notification>>> get notifications =>
      _notifications.stream;

  final _notifications =
      BehaviorSubject<ApiResponse<List<Fragment$notification>>>();

  final GraphqlDatasource graphQLDatasource;

  NotificationsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<List<Fragment$notification>>> getNotifications() async {
    final result = await graphQLDatasource.query(Options$Query$notifications());
    _notifications.add(result.mapData((data) => data.notifications));
    return result.mapData((data) => data.notifications);
  }
}
