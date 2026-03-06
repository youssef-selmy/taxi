import 'package:api_response/api_response.dart';
import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/entities/wallet_activity_item.entity.dart';
import 'package:better_design_system/templates/payment_methods_screen_template/payment_methods_screen_template.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppPaymentMethodsScreenTemplate)
Widget defaultPaymentMethodsScreenTemplate(BuildContext context) {
  final isLoading = context.knobs.boolean(
    label: 'Is Loading',
    description: 'Indicates if the screen is loading',
    initialValue: false,
  );
  final bool isEmpty = context.knobs.boolean(
    label: 'Is Empty',
    description: 'Indicates if there is no payment method defined',
    initialValue: false,
  );
  return AppPaymentMethodsScreenTemplate(
    onMobileBackPressed: () {},
    onAddPaymentMethodPressed: () {},
    onPaymentMethodSelected: (paymentMethod) {},
    onDeletePaymentMethodPressed: (_) {},
    onMarkAsDefaultPressed: (_) {},
    paymentMethods:
        isLoading
            ? ApiResponse.loading()
            : ApiResponse.loaded(isEmpty ? [] : [mockPaymentMethodVisa]),
    walletActivities:
        isLoading
            ? ApiResponse.loading()
            : ApiResponse.loaded(mockWalletActivityItems),
  );
}
