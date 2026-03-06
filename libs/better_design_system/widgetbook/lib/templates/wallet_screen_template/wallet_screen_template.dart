import 'package:api_response/api_response.dart';
import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/entities/wallet_activity_item.entity.dart';
import 'package:better_design_system/entities/wallet_item.entity.dart';
import 'package:better_design_system/templates/wallet_screen_template/wallet_screen_template.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppWalletScreenTemplate)
Widget defaultWalletScreenTemplate(BuildContext context) {
  final isLoading = context.knobs.boolean(
    label: 'isLoading',
    initialValue: false,
  );
  return AppWalletScreenTemplate(
    onMobileBackPressed: () {},
    walletItems:
        isLoading ? ApiResponse.loading() : ApiResponse.loaded(mockWalletItems),
    walletActivityItems:
        isLoading
            ? ApiResponse.loading()
            : ApiResponse.loaded(mockWalletActivityItems),
    defaultPaymentMethod:
        isLoading
            ? ApiResponse.loading()
            : ApiResponse.loaded(mockSavedPaymentMethod),
    onRedeemGiftCardPressed: () {},
    onAddCreditPressed: () {},
    onSelectPaymentMethodPressed: () {},
  );
}
