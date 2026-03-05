import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ActivityLevelX on Enum$UserActivityLevel {
  String name(BuildContext context) {
    switch (this) {
      case Enum$UserActivityLevel.Inactive:
        return context.tr.inactive;
      case Enum$UserActivityLevel.Active:
        return context.tr.active;
      default:
        return '';
    }
  }
}
