import 'package:better_design_system/templates/select_payment_method_template/payment_methods_list.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';

typedef BetterSelectPaymentMethodTemplate = AppSelectPaymentMethodTemplate;

class AppSelectPaymentMethodTemplate extends StatefulWidget {
  final List<PaymentMethodEntity> paymentMethods;
  final PaymentMethodEntity? selectedPaymentMethod;
  final Function(PaymentMethodEntity) onPaymentMethodSelected;
  final Function()? onAddPaymentMethod;

  const AppSelectPaymentMethodTemplate({
    super.key,
    required this.paymentMethods,
    this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
    this.onAddPaymentMethod,
  });

  @override
  State<AppSelectPaymentMethodTemplate> createState() =>
      _AppSelectPaymentMethodTemplateState();
}

class _AppSelectPaymentMethodTemplateState
    extends State<AppSelectPaymentMethodTemplate> {
  PaymentMethodEntity? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _selectedPaymentMethod = widget.selectedPaymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      iconStyle: DialogHeaderIconStyle.simple,
      alignment: DialogHeaderAlignment.start,
      title: context.strings.selectPaymentMethod,
      onClosePressed: () => Navigator.of(context).pop(),
      primaryButton: AppFilledButton(
        onPressed: () {
          Navigator.of(context).pop(_selectedPaymentMethod);
        },
        child: Text(context.strings.confirm),
      ),
      child: AppPaymentMethodsList(
        paymentMethods: widget.paymentMethods,
        onPaymentMethodSelected: widget.onPaymentMethodSelected,
        onAddPaymentMethod: widget.onAddPaymentMethod,
        selectedPaymentMethod: widget.selectedPaymentMethod,
      ),
    );
  }
}
