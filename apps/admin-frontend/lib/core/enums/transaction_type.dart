import 'package:flutter/material.dart';

import 'package:better_design_system/molecules/filter_dropdown/filter_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension TransactionActionX on Enum$TransactionType {
  String name(BuildContext context) => switch (this) {
    Enum$TransactionType.Credit => context.tr.credit,
    Enum$TransactionType.Debit => context.tr.debit,
    Enum$TransactionType.$unknown => context.tr.unknown,
  };

  Widget icon(BuildContext context) => switch (this) {
    Enum$TransactionType.Credit => Icon(
      BetterIcons.arrowUpRight01Outline,
      color: context.colors.success,
      size: 16,
    ),
    Enum$TransactionType.Debit => Icon(
      BetterIcons.arrowDownLeft01Outline,
      color: context.colors.error,
      size: 16,
    ),
    Enum$TransactionType.$unknown => const Icon(
      Icons.error,
      color: Colors.grey,
      size: 16,
    ),
  };
}

extension TransactionTypeListX on List<Enum$TransactionType> {
  List<FilterItem<Enum$TransactionType>> toFilterItems(BuildContext context) =>
      where(
        (transactionType) => transactionType != Enum$TransactionType.$unknown,
      ).map((e) => FilterItem(label: e.name(context), value: e)).toList();
}
