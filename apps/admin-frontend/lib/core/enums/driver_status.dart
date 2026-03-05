import 'package:better_design_system/atoms/status_badge/status_badge_type.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_status/item.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension DriverStatusX on Enum$DriverStatus {
  String title(BuildContext context) => switch (this) {
    Enum$DriverStatus.Blocked => context.tr.blocked,
    Enum$DriverStatus.HardReject => context.tr.hardReject,
    Enum$DriverStatus.InService => context.tr.inService,
    Enum$DriverStatus.Offline => context.tr.offline,
    Enum$DriverStatus.Online => context.tr.online,
    Enum$DriverStatus.PendingApproval => context.tr.pendingApproval,
    Enum$DriverStatus.SoftReject => context.tr.softReject,
    Enum$DriverStatus.WaitingDocuments => context.tr.waitingDocuments,
    Enum$DriverStatus.$unknown => context.tr.unknown,
  };

  SemanticColor get chipType => switch (this) {
    Enum$DriverStatus.Blocked => SemanticColor.error,
    Enum$DriverStatus.HardReject => SemanticColor.error,
    Enum$DriverStatus.InService => SemanticColor.warning,
    Enum$DriverStatus.Offline => SemanticColor.neutral,
    Enum$DriverStatus.Online => SemanticColor.success,
    Enum$DriverStatus.PendingApproval => SemanticColor.warning,
    Enum$DriverStatus.SoftReject => SemanticColor.error,
    Enum$DriverStatus.WaitingDocuments => SemanticColor.warning,
    _ => SemanticColor.neutral,
  };

  StatusBadgeType get statusBadgeType => switch (this) {
    Enum$DriverStatus.Blocked => StatusBadgeType.busy,
    Enum$DriverStatus.HardReject => StatusBadgeType.busy,
    Enum$DriverStatus.InService => StatusBadgeType.away,
    Enum$DriverStatus.Offline => StatusBadgeType.offline,
    Enum$DriverStatus.Online => StatusBadgeType.online,
    Enum$DriverStatus.PendingApproval => StatusBadgeType.none,
    Enum$DriverStatus.SoftReject => StatusBadgeType.busy,
    Enum$DriverStatus.WaitingDocuments => StatusBadgeType.none,
    _ => StatusBadgeType.none,
  };

  IconData get icon => switch (this) {
    Enum$DriverStatus.PendingApproval => BetterIcons.loading03Outline,
    Enum$DriverStatus.WaitingDocuments => BetterIcons.loading03Outline,
    Enum$DriverStatus.Blocked => BetterIcons.cancelCircleFilled,
    Enum$DriverStatus.InService => BetterIcons.checkmarkCircle02Filled,
    Enum$DriverStatus.HardReject => BetterIcons.cancelCircleFilled,
    Enum$DriverStatus.SoftReject => BetterIcons.alert02Filled,
    Enum$DriverStatus.Online => BetterIcons.checkmarkCircle02Filled,
    Enum$DriverStatus.Offline => BetterIcons.cancelCircleFilled,
    Enum$DriverStatus.$unknown => BetterIcons.helpCircleFilled,
  };

  Widget chip(BuildContext context) {
    return AppTag(prefixIcon: icon, text: title(context), color: chipType);
  }
}

extension DriverStatusListX on List<Enum$DriverStatus> {
  List<FilterItem<Enum$DriverStatus>> toFilterItems(BuildContext context) {
    return where((e) => e != Enum$DriverStatus.$unknown)
        .map(
          (status) => FilterItem(label: status.title(context), value: status),
        )
        .toList();
  }

  List<DropDownStatusItem<Enum$DriverStatus>> toDropDownStatusItems(
    BuildContext context,
  ) {
    return where((e) => e != Enum$DriverStatus.$unknown)
        .map(
          (e) => DropDownStatusItem(
            value: e,
            text: e.title(context),
            chipType: e.chipType,
          ),
        )
        .toList();
  }
}
