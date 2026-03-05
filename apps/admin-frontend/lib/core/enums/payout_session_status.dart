import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_status/item.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension PayoutSessionStatusX on Enum$PayoutSessionStatus {
  String text(BuildContext context) {
    return switch (this) {
      Enum$PayoutSessionStatus.PAID => context.tr.paid,
      Enum$PayoutSessionStatus.PENDING => context.tr.pending,
      Enum$PayoutSessionStatus.FAILED => context.tr.paymentFailed,
      Enum$PayoutSessionStatus.CANCELLED => context.tr.canceled,
      Enum$PayoutSessionStatus.IN_PROGRESS => context.tr.inProgress,
      Enum$PayoutSessionStatus.$unknown => context.tr.unknown,
    };
  }

  SemanticColor get type {
    return switch (this) {
      Enum$PayoutSessionStatus.PAID => SemanticColor.success,
      Enum$PayoutSessionStatus.PENDING => SemanticColor.warning,
      Enum$PayoutSessionStatus.FAILED => SemanticColor.error,
      Enum$PayoutSessionStatus.CANCELLED => SemanticColor.neutral,
      Enum$PayoutSessionStatus.$unknown => SemanticColor.neutral,
      Enum$PayoutSessionStatus.IN_PROGRESS => SemanticColor.warning,
    };
  }

  IconData get icon {
    return switch (this) {
      Enum$PayoutSessionStatus.PAID => BetterIcons.checkmarkCircle02Filled,
      Enum$PayoutSessionStatus.PENDING => BetterIcons.loading03Outline,
      Enum$PayoutSessionStatus.IN_PROGRESS => BetterIcons.loading03Outline,
      Enum$PayoutSessionStatus.FAILED => BetterIcons.cancelCircleFilled,
      Enum$PayoutSessionStatus.CANCELLED => BetterIcons.cancelCircleFilled,
      Enum$PayoutSessionStatus.$unknown => Icons.help,
    };
  }

  AppTag toChip(BuildContext context) {
    return AppTag(text: text(context), color: type);
  }
}

extension PayoutSessionStatusListX on List<Enum$PayoutSessionStatus> {
  List<FilterItem<Enum$PayoutSessionStatus>> toFilterItems(
    BuildContext context,
  ) => where((status) => status != Enum$PayoutSessionStatus.$unknown)
      .map((status) => FilterItem(value: status, label: status.text(context)))
      .toList();

  List<DropDownStatusItem<Enum$PayoutSessionStatus>> toStatusDropdownItems(
    BuildContext context,
  ) => map(
    (status) => DropDownStatusItem(
      value: status,
      text: status.text(context),
      chipType: status.type,
      icon: status.icon,
    ),
  ).toList();
}
