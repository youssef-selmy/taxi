import 'package:time/time.dart';

import 'package:admin_frontend/core/graphql/fragments/notifications.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.mock.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockNotificationTaxiSupportRequest1 =
    Fragment$taxiSupportRequestNotification(
      createdAt: 2.minutes.ago,
      readAt: null,
      type: Enum$AdminNotificationType.SupportRequestSubmitted,
      taxiSupportRequest: mockcomplaintTaxiListItem1,
    );

final mockNotificationTaxiSupportRequest2 =
    Fragment$taxiSupportRequestNotification(
      createdAt: 3.minutes.ago,
      readAt: null,
      type: Enum$AdminNotificationType.SupportRequestSubmitted,
      taxiSupportRequest: mockcomplaintTaxiListItem2,
    );

final mockNotificationShopSupportRequest1 =
    Fragment$shopSupportRequestNotification(
      createdAt: 4.minutes.ago,
      readAt: null,
      type: Enum$AdminNotificationType.SupportRequestSubmitted,
      shopSupportRequest: mockShopSupportRequest1,
    );

final mockNotificationShopSupportRequest2 =
    Fragment$shopSupportRequestNotification(
      createdAt: 6.minutes.ago,
      readAt: null,
      type: Enum$AdminNotificationType.SupportRequestSubmitted,
      shopSupportRequest: mockShopSupportRequest2,
    );

final mockNotificationParkingSupportRequest1 =
    Fragment$parkingSupportRequestNotification(
      createdAt: 10.minutes.ago,
      readAt: null,
      type: Enum$AdminNotificationType.SupportRequestSubmitted,
      parkingSupportRequest: mockParkingOrderSupportRequest1,
    );

final mockNotificationParkingSupportRequest2 =
    Fragment$parkingSupportRequestNotification(
      createdAt: 14.minutes.ago,
      readAt: null,
      type: Enum$AdminNotificationType.SupportRequestSubmitted,
      parkingSupportRequest: mockParkingOrderSupportRequest2,
    );

final mockNotificationShopPendingVerification1 =
    Fragment$shopPendingVerificationNotification(
      createdAt: 15.minutes.ago,
      readAt: null,
      type: Enum$AdminNotificationType.UserPendingVerification,
      shopPendingVerification: mockShopListItem1,
    );

final mockNotificationShopPendingVerification2 =
    Fragment$shopPendingVerificationNotification(
      createdAt: 25.minutes.ago,
      readAt: null,
      type: Enum$AdminNotificationType.UserPendingVerification,
      shopPendingVerification: mockShopListItem2,
    );

final mockNotificationParkingPendingVerification1 =
    Fragment$parkSpotPendingVerificationNotification(
      createdAt: 32.minutes.ago,
      readAt: null,
      type: Enum$AdminNotificationType.UserPendingVerification,
      parkSpotPendingVerification: mockParkingListItem1,
    );

final mockNotificationShopReview1 =
    Fragment$shopReviewPendingApprovalNotification(
      createdAt: 42.minutes.ago,
      readAt: null,
      type: Enum$AdminNotificationType.ReviewPendingApproval,
      shopReviewPendingApproval: mockShopFeedback1,
    );

final mockNotificationParkingReview1 =
    Fragment$parkingReviewPendingApprovalNotification(
      createdAt: 49.minutes.ago,
      readAt: null,
      type: Enum$AdminNotificationType.ReviewPendingApproval,
      parkingReviewPendingApproval: mockParkingFeedback1,
    );

final List<Fragment$notification> mockNotifications = [
  Fragment$notification.fromJson(mockNotificationTaxiSupportRequest1.toJson()),
  Fragment$notification.fromJson(mockNotificationTaxiSupportRequest2.toJson()),
  Fragment$notification.fromJson(mockNotificationShopSupportRequest1.toJson()),
  Fragment$notification.fromJson(mockNotificationShopSupportRequest2.toJson()),
  Fragment$notification.fromJson(
    mockNotificationParkingSupportRequest1.toJson(),
  ),
  Fragment$notification.fromJson(
    mockNotificationParkingSupportRequest2.toJson(),
  ),
  Fragment$notification.fromJson(
    mockNotificationShopPendingVerification1.toJson(),
  ),
  Fragment$notification.fromJson(
    mockNotificationShopPendingVerification2.toJson(),
  ),
  Fragment$notification.fromJson(
    mockNotificationParkingPendingVerification1.toJson(),
  ),
  Fragment$notification.fromJson(mockNotificationShopReview1.toJson()),
  Fragment$notification.fromJson(mockNotificationParkingReview1.toJson()),
];
