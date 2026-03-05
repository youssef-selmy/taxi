part of 'notifications.cubit.dart';

@freezed
sealed class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default(ApiResponseInitial())
    ApiResponse<List<Fragment$notification>> notifications,
    @Default(0) int selectedTab,
  }) = _NotificationsState;

  const NotificationsState._();

  List<Fragment$notification> get selectedTabNotifications =>
      switch (selectedTab) {
        0 => notifications.data ?? [],
        1 => supportRequestNotifications,
        2 => pendingVerificationNotifications,
        3 => reviewPendingApprovalNotifications,
        _ => [],
      };

  int? get allNotificationsCount => notifications.data?.isNotEmpty ?? false
      ? notifications.data?.length
      : null;

  List<Fragment$notification> get supportRequestNotifications =>
      notifications.data
          ?.where(
            (element) => element.maybeWhen(
              taxiSupportRequestNotification: (_) => true,
              shopSupportRequestNotification: (_) => true,
              parkingSupportRequestNotification: (_) => true,
              orElse: () => false,
            ),
          )
          .toList() ??
      [];

  List<Fragment$notification> get pendingVerificationNotifications =>
      notifications.data
          ?.where(
            (element) => element.maybeWhen(
              driverPendingVerificationNotification: (_) => true,
              shopPendingVerificationNotification: (_) => true,
              parkSpotPendingVerificationNotification: (_) => true,
              orElse: () => false,
            ),
          )
          .toList() ??
      [];

  List<Fragment$notification> get reviewPendingApprovalNotifications =>
      notifications.data
          ?.where(
            (element) => element.maybeWhen(
              shopReviewPendingApprovalNotification: (_) => true,
              parkingReviewPendingApprovalNotification: (_) => true,
              orElse: () {
                return false;
              },
            ),
          )
          .toList() ??
      [];
}
