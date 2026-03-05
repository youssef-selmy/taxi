import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension CustomerStatusEnumX on Enum$RiderStatus {
  String text(BuildContext context) {
    switch (this) {
      case Enum$RiderStatus.Enabled:
        return context.tr.enabled;
      case Enum$RiderStatus.Disabled:
        return context.tr.disabled;
      default:
        return context.tr.unknown;
    }
  }

  SemanticColor get chipType => switch (this) {
    Enum$RiderStatus.Enabled => SemanticColor.success,
    Enum$RiderStatus.Disabled => SemanticColor.error,
    _ => SemanticColor.neutral,
  };

  IconData icon() {
    switch (this) {
      case Enum$RiderStatus.Enabled:
        return BetterIcons.checkmarkCircle02Filled;
      case Enum$RiderStatus.Disabled:
        return BetterIcons.cancelCircleFilled;
      default:
        return Icons.help;
    }
  }

  Widget chip(BuildContext context) {
    return AppTag(prefixIcon: icon(), color: chipType, text: text(context));
  }
}
