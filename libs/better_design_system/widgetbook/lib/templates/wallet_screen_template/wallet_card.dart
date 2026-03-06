import 'package:api_response/api_response.dart';
import 'package:better_design_system/entities/wallet_item.entity.dart';
import 'package:better_design_system/templates/wallet_screen_template/components/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppWalletCard)
Widget defaultWalletCard(BuildContext context) {
  return SizedBox(
    width: 600,
    child: AppWalletCard(
      walletItems: ApiResponse.loaded([
        WalletItemEntity(currency: 'USD', balance: 100.00),
        WalletItemEntity(currency: 'EUR', balance: 200.00),
      ]),
    ),
  );
}
