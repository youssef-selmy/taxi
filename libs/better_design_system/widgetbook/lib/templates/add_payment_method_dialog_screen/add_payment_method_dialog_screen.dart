import 'package:api_response/api_response.dart';
import 'package:better_design_system/entities/payment_processor.entity.dart';
import 'package:better_design_system/entities/payment_processor_link_intent_result.entity.dart';
import 'package:better_design_system/templates/add_payment_method_dialog_template/add_payment_method_dialog_template.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppAddPaymentMethodDialogTemplate)
Widget defaultAddPaymentMethodDialogScreen(BuildContext context) {
  final isLoading = context.knobs.boolean(
    label: 'Is Loading',
    description: 'Indicates if the screen is loading',
    initialValue: false,
  );
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: AppAddPaymentMethodDialogTemplate(
      onMobileBackPressed: () {},
      paymentProcessorsResponse:
          isLoading
              ? ApiResponse.loading()
              : ApiResponse.loaded([mockPaymentProcessor1]),
      paymentProcessorsCallback: (value) async {
        return ApiResponse.loaded(
          PaymentProcessorLinkIntentResultEntity(
            state: PaymentProcessorLinkIntentResultState.redirect,
            url: 'https://example.com',
          ),
        );
      },
    ),
  );
}
