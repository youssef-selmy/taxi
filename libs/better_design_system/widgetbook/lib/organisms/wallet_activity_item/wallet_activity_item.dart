import 'package:better_design_system/organisms/wallet_activity_item/wallet_activity_item.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppWalletActivityItem)
Widget defaultWalletActivityItem(BuildContext context) {
  return SizedBox(
    width: 500,
    child: AppWalletActivityItem(
      title: 'Economy Ride',
      currency: 'USD',
      amount: 123.45555,
      date: DateTime.now(),
      icon: BetterIcons.car01Filled,
      iconColor: SemanticColor.primary,
      onPressed: () {},
    ),
  );
}
