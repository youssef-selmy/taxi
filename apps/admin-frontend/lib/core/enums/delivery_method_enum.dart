import 'package:better_localization/localizations.dart';
import 'package:flutter/cupertino.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension DeliveryMethodEnumExtension on Enum$DeliveryMethod {
  String name(BuildContext context) {
    switch (this) {
      case Enum$DeliveryMethod.BATCH:
        return context.tr.batch;
      case Enum$DeliveryMethod.SPLIT:
        return context.tr.split;
      case Enum$DeliveryMethod.SCHEDULED:
        return context.tr.scheduled;
      default:
        return '';
    }
  }

  String description(BuildContext context) {
    switch (this) {
      case Enum$DeliveryMethod.BATCH:
        return context.tr.batchDeliveryDescription;
      case Enum$DeliveryMethod.SPLIT:
        return context.tr.splitDeliveryDescription;
      case Enum$DeliveryMethod.SCHEDULED:
        return context.tr.scheduledDeliveryDescription;
      default:
        return '';
    }
  }
}
