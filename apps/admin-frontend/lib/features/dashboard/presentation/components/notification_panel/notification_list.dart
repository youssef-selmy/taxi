import 'package:flutter/material.dart';

import 'package:admin_frontend/core/graphql/fragments/notifications.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/notifications.fragment.graphql.dart';
import 'package:better_localization/localizations.dart';

class NotificationList extends StatelessWidget {
  final List<Fragment$notification> notifications;

  const NotificationList({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return notification.when(
          taxiSupportRequestNotification: (taxiNotification) =>
              taxiNotification.toNotificationItem(context),
          shopSupportRequestNotification: (shopNotification) =>
              shopNotification.toNotificationItem(context),
          parkingSupportRequestNotification: (parkingNotification) =>
              parkingNotification.toNotificationItem(context),
          driverPendingVerificationNotification: (driverPendingVerification) =>
              driverPendingVerification.toNotificationItem(context),
          shopPendingVerificationNotification: (shopPendingVerification) =>
              shopPendingVerification.toNotificationItem(context),
          parkSpotPendingVerificationNotification:
              (parkSpotPendingVerification) =>
                  parkSpotPendingVerification.toNotificationItem(context),
          shopReviewPendingApprovalNotification: (shopReviewPendingApproval) =>
              shopReviewPendingApproval.toNotificationItem(context),
          parkingReviewPendingApprovalNotification:
              (parkingReviewPendingApproval) =>
                  parkingReviewPendingApproval.toNotificationItem(context),
          orElse: () {
            return Text(context.tr.unknown);
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 32),
      itemCount: notifications.length,
    );
  }
}
