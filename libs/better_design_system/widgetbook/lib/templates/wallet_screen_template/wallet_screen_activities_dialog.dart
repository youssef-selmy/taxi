import 'package:better_design_system/colors/semantic_color.dart';
import 'package:better_design_system/entities/wallet_activity_item.entity.dart';
import 'package:better_design_system/templates/wallet_screen_template/components/wallet_screen_activities_dialog.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppWalletScreenActivitiesDialog)
Widget defaultWalletScreenActivitiesDialog(BuildContext context) {
  return AppWalletScreenActivitiesDialog(
    activities: [
      WalletActivityItemEntity(
        title: 'Purchase at Store A',
        currency: 'USD',
        amount: 50.00,
        date: DateTime.now().subtract(Duration(days: 1)),
        iconColor: SemanticColor.primary,
        icon: Icons.shopping_cart,
      ),
      WalletActivityItemEntity(
        title: 'Refund from Store B',
        currency: 'USD',
        amount: -20.00,
        date: DateTime.now().subtract(Duration(days: 2)),
        iconColor: SemanticColor.primary,
        icon: Icons.monetization_on,
      ),
      WalletActivityItemEntity(
        title: 'Gift Card Redemption',
        currency: 'USD',
        amount: 100.00,
        date: DateTime.now().subtract(Duration(days: 3)),
        iconColor: SemanticColor.primary,
        icon: Icons.card_giftcard,
      ),
    ],
  );
}
