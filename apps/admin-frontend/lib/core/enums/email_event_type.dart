import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/schema.graphql.dart';

extension EmailEventTypeGqlX on Enum$EmailEventType {
  String name(BuildContext context) {
    return switch (this) {
      Enum$EmailEventType.DRIVER_APPROVED => 'Driver Approved',
      Enum$EmailEventType.DRIVER_REJECTED => 'Driver Rejected',
      Enum$EmailEventType.DRIVER_DOCUMENTS_PENDING =>
        'Driver Documents Pending',
      Enum$EmailEventType.DRIVER_SUSPENDED => 'Driver Suspended',
      Enum$EmailEventType.DRIVER_REGISTRATION_SUBMITTED =>
        'Driver Registration Submitted',
      Enum$EmailEventType.ORDER_CONFIRMED => 'Order Confirmed',
      Enum$EmailEventType.ORDER_COMPLETED => 'Order Completed',
      Enum$EmailEventType.ORDER_CANCELLED => 'Order Cancelled',
      Enum$EmailEventType.ORDER_REFUNDED => 'Order Refunded',
      Enum$EmailEventType.AUTH_WELCOME => 'Welcome Email',
      Enum$EmailEventType.AUTH_PASSWORD_RESET => 'Password Reset',
      Enum$EmailEventType.AUTH_VERIFICATION => 'Email Verification',
      Enum$EmailEventType.EXPIRING_KYC_30_DAY_REMINDER =>
        'KYC Expiring - 30 Day Reminder',
      Enum$EmailEventType.EXPIRING_KYC_14_DAY_REMINDER =>
        'KYC Expiring - 14 Day Reminder',
      Enum$EmailEventType.EXPIRING_KYC_7_DAY_REMINDER =>
        'KYC Expiring - 7 Day Reminder',
      Enum$EmailEventType.EXPIRING_KYC_3_DAY_REMINDER =>
        'KYC Expiring - 3 Day Reminder',
      Enum$EmailEventType.EXPIRING_KYC_2_DAY_REMINDER =>
        'KYC Expiring - 2 Day Reminder',
      Enum$EmailEventType.EXPIRING_KYC_1_DAY_REMINDER =>
        'KYC Expiring - 1 Day Reminder',
      Enum$EmailEventType.$unknown => context.tr.unknown,
    };
  }

  String get category {
    return switch (this) {
      Enum$EmailEventType.DRIVER_APPROVED ||
      Enum$EmailEventType.DRIVER_REJECTED ||
      Enum$EmailEventType.DRIVER_DOCUMENTS_PENDING ||
      Enum$EmailEventType.DRIVER_SUSPENDED ||
      Enum$EmailEventType.DRIVER_REGISTRATION_SUBMITTED => 'Driver Lifecycle',
      Enum$EmailEventType.ORDER_CONFIRMED ||
      Enum$EmailEventType.ORDER_COMPLETED ||
      Enum$EmailEventType.ORDER_CANCELLED ||
      Enum$EmailEventType.ORDER_REFUNDED => 'Order Lifecycle',
      Enum$EmailEventType.AUTH_WELCOME ||
      Enum$EmailEventType.AUTH_PASSWORD_RESET ||
      Enum$EmailEventType.AUTH_VERIFICATION => 'Authentication',
      Enum$EmailEventType.EXPIRING_KYC_30_DAY_REMINDER ||
      Enum$EmailEventType.EXPIRING_KYC_14_DAY_REMINDER ||
      Enum$EmailEventType.EXPIRING_KYC_7_DAY_REMINDER ||
      Enum$EmailEventType.EXPIRING_KYC_3_DAY_REMINDER ||
      Enum$EmailEventType.EXPIRING_KYC_2_DAY_REMINDER ||
      Enum$EmailEventType.EXPIRING_KYC_1_DAY_REMINDER => 'KYC Expiration',
      Enum$EmailEventType.$unknown => 'Unknown',
    };
  }
}
