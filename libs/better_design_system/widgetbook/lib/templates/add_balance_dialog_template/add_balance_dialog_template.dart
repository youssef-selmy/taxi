import 'package:api_response/api_response.dart';
import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/templates/add_balance_dialog_template/add_balance_dialog_template.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppAddBalanceDialogTemplate)
Widget defaultAddBalanceDialogTemplate(BuildContext context) {
  final bool isLoading = context.knobs.boolean(
    label: 'isLoading',
    description: 'Indicates if the dialog is in a loading state',
    initialValue: false,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: AppAddBalanceDialogTemplate(
      currency: context.knobs.object.dropdown(
        label: 'Select Currency',
        options: ['USD', 'EUR'],
        initialOption: 'USD',
      ),
      presetAmounts: [5, 10, 50],
      minimumAmount: 5,
      maximumAmount: 100,
      onAddPaymentMethodPressed: () {},
      paymentMethods:
          isLoading
              ? ApiResponse.loading()
              : ApiResponse.loaded(mockPaymentMethods),
    ),
  );
}
