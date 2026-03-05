import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_status/item.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ComplaintStatusX on Enum$ComplaintStatus {
  String title(BuildContext context) => switch (this) {
    Enum$ComplaintStatus.Resolved => context.tr.resolved,
    Enum$ComplaintStatus.Submitted => context.tr.pending,
    Enum$ComplaintStatus.UnderInvestigation => context.tr.underInvestigation,
    _ => context.tr.unknown,
  };

  SemanticColor get chipType => switch (this) {
    Enum$ComplaintStatus.UnderInvestigation => SemanticColor.info,
    Enum$ComplaintStatus.Submitted => SemanticColor.warning,
    Enum$ComplaintStatus.Resolved => SemanticColor.success,
    _ => SemanticColor.neutral,
  };

  IconData get icon => switch (this) {
    Enum$ComplaintStatus.Submitted => BetterIcons.loading03Outline,
    Enum$ComplaintStatus.UnderInvestigation => BetterIcons.loading03Outline,
    Enum$ComplaintStatus.Resolved => BetterIcons.checkmarkCircle02Filled,
    _ => Icons.help,
  };

  Widget chip(BuildContext context) {
    return AppTag(prefixIcon: icon, text: title(context), color: chipType);
  }
}

extension ComplaintStatusListX on List<Enum$ComplaintStatus> {
  List<FilterItem<Enum$ComplaintStatus>> toFilterItems(BuildContext context) =>
      where((status) => status != Enum$ComplaintStatus.$unknown)
          .map(
            (status) => FilterItem(value: status, label: status.title(context)),
          )
          .toList();
  List<DropDownStatusItem<Enum$ComplaintStatus>> toDropdownStatusItems(
    BuildContext context,
  ) => where((status) => status != Enum$ComplaintStatus.$unknown)
      .map(
        (status) => DropDownStatusItem(
          value: status,
          text: status.title(context),
          chipType: status.chipType,
        ),
      )
      .toList();
}
