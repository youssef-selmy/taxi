import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension TransactionStatusX on Enum$TransactionStatus {
  String title(BuildContext context) => switch (this) {
    Enum$TransactionStatus.Processing => context.tr.processing,
    Enum$TransactionStatus.Canceled => context.tr.canceled,
    Enum$TransactionStatus.Done => context.tr.done,
    Enum$TransactionStatus.Rejected => context.tr.rejected,
    _ => context.tr.unknown,
  };

  SemanticColor get chipType => switch (this) {
    Enum$TransactionStatus.Processing => SemanticColor.info,
    Enum$TransactionStatus.Canceled => SemanticColor.error,
    Enum$TransactionStatus.Done => SemanticColor.success,
    Enum$TransactionStatus.Rejected => SemanticColor.error,
    _ => SemanticColor.neutral,
  };

  IconData get icon => switch (this) {
    Enum$TransactionStatus.Processing => BetterIcons.loading03Outline,
    Enum$TransactionStatus.Canceled => BetterIcons.cancelCircleFilled,
    Enum$TransactionStatus.Done => BetterIcons.checkmarkCircle02Filled,
    Enum$TransactionStatus.Rejected => BetterIcons.cancelCircleFilled,
    _ => Icons.help,
  };

  Widget chip(BuildContext context) {
    return AppTag(prefixIcon: icon, text: title(context), color: chipType);
  }
}

extension TransactionStatusListX on List<Enum$TransactionStatus> {
  List<FilterItem<Enum$TransactionStatus>> filterItems(BuildContext context) =>
      where((status) => status != Enum$TransactionStatus.$unknown)
          .map(
            (status) => FilterItem(value: status, label: status.title(context)),
          )
          .toList();
}
