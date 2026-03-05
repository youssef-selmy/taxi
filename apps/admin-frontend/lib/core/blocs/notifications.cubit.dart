import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/notifications.fragment.graphql.dart';
import 'package:admin_frontend/core/repositories/notifications_repository.dart';

part 'notifications.state.dart';
part 'notifications.cubit.freezed.dart';

@lazySingleton
class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository _notificationsRepository;

  NotificationsCubit(this._notificationsRepository)
    : super(const NotificationsState());

  void onStarted() {
    _fetchAllNotifications();
  }

  Future<void> _fetchAllNotifications() async {
    emit(state.copyWith(notifications: ApiResponse.loading()));
    final notificationsResponse = await _notificationsRepository
        .getNotifications();
    emit(state.copyWith(notifications: notificationsResponse));
  }

  void onTabChanged(int index) => emit(state.copyWith(selectedTab: index));
}
