import 'package:flutter/material.dart';
import 'package:better_localization/localizations.dart';
import 'package:admin_frontend/core/components/organisms/notification_item.dart';
import 'package:admin_frontend/core/graphql/fragments/notifications.fragment.graphql.dart';
import 'package:better_icons/better_icons.dart';

extension TaxiSupportRequestNotificationX
    on Fragment$taxiSupportRequestNotification {
  NotificationItem toNotificationItem(BuildContext context) {
    return NotificationItem(
      title: context.tr.taxiSupportRequest,
      description: context.tr.newTaxiSupportRequestHasBeenCreated,
      icon: BetterIcons.headphonesOutline,
      createdAt: createdAt,
      readAt: readAt,
    );
  }
}

extension ShopSupportRequestNotificationX
    on Fragment$shopSupportRequestNotification {
  NotificationItem toNotificationItem(BuildContext context) {
    return NotificationItem(
      title: context.tr.shopSupportRequest,
      description: context.tr.newShopSupportRequestHasBeenCreated,
      icon: BetterIcons.headphonesOutline,
      createdAt: createdAt,
      readAt: readAt,
    );
  }
}

extension ParkingSupportRequestNotificationX
    on Fragment$parkingSupportRequestNotification {
  NotificationItem toNotificationItem(BuildContext context) {
    return NotificationItem(
      title: context.tr.parkingSupportRequest,
      description: context.tr.newParkingSupportRequestHasBeenCreated,
      icon: BetterIcons.headphonesOutline,
      createdAt: createdAt,
      readAt: readAt,
    );
  }
}

extension DriverPendingVerificationNotificationX
    on Fragment$driverPendingVerificationNotification {
  NotificationItem toNotificationItem(BuildContext context) {
    return NotificationItem(
      title: context.tr.driverPendingVerification,
      description: context.tr.newDriverIsPendingVerification,
      imageUrl: driverPendingVerification.media?.address,
      createdAt: createdAt,
      readAt: readAt,
    );
  }
}

extension ShopPendingVerificationNotificationX
    on Fragment$shopPendingVerificationNotification {
  NotificationItem toNotificationItem(BuildContext context) {
    return NotificationItem(
      title: context.tr.shopPendingVerification,
      description: context.tr.newShopIsPendingVerification,
      imageUrl: shopPendingVerification.image?.address,
      createdAt: createdAt,
      readAt: readAt,
    );
  }
}

extension ParkingPendingVerificationNotificationX
    on Fragment$parkSpotPendingVerificationNotification {
  NotificationItem toNotificationItem(BuildContext context) {
    return NotificationItem(
      title: context.tr.parkingPendingVerification,
      description: context.tr.newParkingIsPendingVerification,
      imageUrl: parkSpotPendingVerification.mainImage?.address,
      createdAt: createdAt,
      readAt: readAt,
    );
  }
}

extension ShopReviewPendingApprovalNotificationX
    on Fragment$shopReviewPendingApprovalNotification {
  NotificationItem toNotificationItem(BuildContext context) {
    return NotificationItem(
      title: context.tr.shopReviewPendingApproval,
      description: context.tr.newShopReviewIsPendingApproval,
      icon: BetterIcons.shoppingBag02Outline,
      createdAt: createdAt,
      readAt: readAt,
    );
  }
}

extension ParkingReviewPendingApprovalNotificationX
    on Fragment$parkingReviewPendingApprovalNotification {
  NotificationItem toNotificationItem(BuildContext context) {
    return NotificationItem(
      title: context.tr.parkingReviewPendingApproval,
      description: context.tr.newParkingReviewIsPendingApproval,
      imageUrl: parkingReviewPendingApproval.order.parkSpot.mainImage?.address,
      createdAt: createdAt,
      readAt: readAt,
    );
  }
}
