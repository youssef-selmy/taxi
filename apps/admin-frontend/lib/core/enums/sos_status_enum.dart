import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';

import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension SosStatusX on Enum$SOSStatus {
  String name(BuildContext context) {
    return switch (this) {
      Enum$SOSStatus.FalseAlarm => context.tr.falseStatement,
      Enum$SOSStatus.Resolved => context.tr.resolved,
      Enum$SOSStatus.Submitted => context.tr.newText,
      Enum$SOSStatus.UnderReview => context.tr.pending,
      Enum$SOSStatus.$unknown => context.tr.unknown,
    };
  }

  SemanticColor get chipType {
    return switch (this) {
      Enum$SOSStatus.FalseAlarm => SemanticColor.neutral,
      Enum$SOSStatus.Resolved => SemanticColor.success,
      Enum$SOSStatus.Submitted => SemanticColor.warning,
      Enum$SOSStatus.UnderReview => SemanticColor.info,
      Enum$SOSStatus.$unknown => SemanticColor.error,
    };
  }

  IconData get icon {
    return switch (this) {
      Enum$SOSStatus.FalseAlarm => BetterIcons.cancelCircleFilled,
      Enum$SOSStatus.Resolved => BetterIcons.checkmarkCircle02Filled,
      Enum$SOSStatus.Submitted => BetterIcons.loading03Outline,
      Enum$SOSStatus.UnderReview => BetterIcons.loading03Outline,
      Enum$SOSStatus.$unknown => BetterIcons.cancelCircleFilled,
    };
  }

  Widget chip(BuildContext context) {
    return AppTag(text: name(context), color: chipType, prefixIcon: icon);
  }
}
