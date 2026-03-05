import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import 'package:admin_frontend/core/graphql/fragments/notifications.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/notifications.mock.dart';
import 'package:admin_frontend/core/repositories/notifications_repository.dart';

@dev
@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryMock implements NotificationsRepository {
  @override
  Stream<ApiResponse<List<Fragment$notification>>> get notifications =>
      _notifications.stream;

  final _notifications =
      BehaviorSubject<ApiResponse<List<Fragment$notification>>>();

  @override
  Future<ApiResponse<List<Fragment$notification>>> getNotifications() {
    return Future.value(ApiResponse.loaded(mockNotifications));
  }
}
