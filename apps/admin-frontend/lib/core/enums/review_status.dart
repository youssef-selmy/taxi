import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

import 'package:admin_frontend/core/components/molecules/dropdown_status/item.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension ReviewStatusX on Enum$ReviewStatus {
  String title(BuildContext context) => switch (this) {
    Enum$ReviewStatus.Approved => context.tr.approved,
    Enum$ReviewStatus.ApprovedUnpublished => context.tr.unpublished,
    Enum$ReviewStatus.Overridden => context.tr.overridden,
    Enum$ReviewStatus.Pending => context.tr.pending,
    Enum$ReviewStatus.Rejected => context.tr.rejected,
    _ => context.tr.unknown,
  };

  SemanticColor get chipType => switch (this) {
    Enum$ReviewStatus.Approved => SemanticColor.info,
    Enum$ReviewStatus.Overridden => SemanticColor.error,
    Enum$ReviewStatus.Rejected => SemanticColor.error,
    Enum$ReviewStatus.Pending => SemanticColor.warning,
    Enum$ReviewStatus.ApprovedUnpublished => SemanticColor.warning,
    _ => SemanticColor.neutral,
  };

  IconData get icon => switch (this) {
    Enum$ReviewStatus.Approved => BetterIcons.loading03Outline,
    Enum$ReviewStatus.Overridden => BetterIcons.cancelCircleFilled,
    Enum$ReviewStatus.Rejected => BetterIcons.cancelCircleFilled,
    Enum$ReviewStatus.Pending => BetterIcons.loading03Outline,
    Enum$ReviewStatus.ApprovedUnpublished => BetterIcons.loading03Outline,
    _ => Icons.help,
  };

  Widget chip(BuildContext context) =>
      AppTag(prefixIcon: icon, text: title(context), color: chipType);
}

extension ReviewStatusListX on List<Enum$ReviewStatus> {
  List<FilterItem<Enum$ReviewStatus>> toFilterItems(BuildContext context) =>
      where((item) => item != Enum$ReviewStatus.$unknown)
          .map(
            (status) => FilterItem(label: status.title(context), value: status),
          )
          .toList();

  List<DropDownStatusItem<Enum$ReviewStatus>> toDropDownItems(
    BuildContext context,
  ) => where((item) => item != Enum$ReviewStatus.$unknown)
      .map(
        (status) => DropDownStatusItem(
          text: status.title(context),
          value: status,
          chipType: status.chipType,
        ),
      )
      .toList();
}
