import 'package:better_design_system/organisms/profile_button/profile_button.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_status/item.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ShopStatusX on Enum$ShopStatus {
  String name(BuildContext context) {
    return switch (this) {
      Enum$ShopStatus.PendingSubmission => context.tr.pendingSubmission,
      Enum$ShopStatus.PendingApproval => context.tr.pendingApproval,
      Enum$ShopStatus.Active => context.tr.active,
      Enum$ShopStatus.Inactive => context.tr.inactive,
      Enum$ShopStatus.Deleted => context.tr.accountDeleted,
      Enum$ShopStatus.Blocked => context.tr.blocked,
      Enum$ShopStatus.$unknown => context.tr.unknown,
    };
  }

  SemanticColor get chipType => switch (this) {
    Enum$ShopStatus.PendingApproval => SemanticColor.warning,
    Enum$ShopStatus.PendingSubmission => SemanticColor.warning,
    Enum$ShopStatus.Active => SemanticColor.success,
    Enum$ShopStatus.Inactive => SemanticColor.error,
    Enum$ShopStatus.Deleted => SemanticColor.error,
    Enum$ShopStatus.Blocked => SemanticColor.error,
    Enum$ShopStatus.$unknown => SemanticColor.error,
  };

  StatusBadgeType get statusBadgeType => switch (this) {
    Enum$ShopStatus.PendingApproval => StatusBadgeType.busy,
    Enum$ShopStatus.PendingSubmission => StatusBadgeType.none,
    Enum$ShopStatus.Active => StatusBadgeType.online,
    Enum$ShopStatus.Inactive => StatusBadgeType.offline,
    Enum$ShopStatus.Deleted => StatusBadgeType.none,
    Enum$ShopStatus.Blocked => StatusBadgeType.none,
    Enum$ShopStatus.$unknown => StatusBadgeType.none,
  };

  IconData get icon => switch (this) {
    Enum$ShopStatus.PendingApproval => BetterIcons.loading03Outline,
    Enum$ShopStatus.PendingSubmission => BetterIcons.loading03Outline,
    Enum$ShopStatus.Active => BetterIcons.tick02Filled,
    Enum$ShopStatus.Inactive => BetterIcons.cancel01Outline,
    Enum$ShopStatus.Deleted => BetterIcons.cancel01Outline,
    Enum$ShopStatus.Blocked => BetterIcons.cancel01Outline,
    Enum$ShopStatus.$unknown => BetterIcons.cancel01Outline,
  };

  Widget chip(BuildContext context) {
    return AppTag(text: name(context), color: chipType, prefixIcon: icon);
  }
}

extension ShopStatusListX on List<Enum$ShopStatus> {
  List<DropDownStatusItem<Enum$ShopStatus>> toDropdownStatusItems(
    BuildContext context,
  ) => where((status) => status != Enum$ShopStatus.$unknown)
      .map(
        (status) => DropDownStatusItem(
          value: status,
          text: status.name(context),
          icon: status.icon,
          chipType: status.chipType,
        ),
      )
      .toList();
}
