import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/bordered_toggle_button.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/input_fields/counter_input/counter_input.dart';
import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_design_system/templates/add_balance_dialog_template/add_balance_dialog_result.dart';
import 'package:better_design_system/templates/select_payment_method_template/payment_methods_list.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

export 'package:better_design_system/templates/add_balance_dialog_template/add_balance_dialog_result.dart';

typedef BetterAddBalanceDialogTemplate = AppAddBalanceDialogTemplate;

class AppAddBalanceDialogTemplate extends StatefulWidget {
  final String currency;
  final List<double> presetAmounts;
  final double minimumAmount;
  final double maximumAmount;
  final ApiResponse<List<PaymentMethodEntity>>? paymentMethods;
  final Function()? onAddPaymentMethodPressed;
  final Future<ApiResponse> Function(
    PaymentMethodEntity paymentMethod,
    double amount,
  )?
  onConfirmPayPressed;

  const AppAddBalanceDialogTemplate({
    super.key,
    required this.currency,
    this.paymentMethods,
    this.onAddPaymentMethodPressed,
    required this.presetAmounts,
    required this.minimumAmount,
    required this.maximumAmount,
    this.onConfirmPayPressed,
  });

  @override
  State<AppAddBalanceDialogTemplate> createState() =>
      _AppAddBalanceDialogTemplateState();
}

class _AppAddBalanceDialogTemplateState
    extends State<AppAddBalanceDialogTemplate> {
  late double _amount;
  PaymentMethodEntity? _selectedPaymentMethod;
  ApiResponse? _confirmPayResponse = const ApiResponse.initial();

  @override
  void initState() {
    _amount = widget.presetAmounts.elementAtOrNull(1) ?? widget.minimumAmount;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      title: context.strings.addBalance,
      iconStyle: context.isDesktop
          ? DialogHeaderIconStyle.withBorder
          : DialogHeaderIconStyle.simple,
      onClosePressed: () {
        Navigator.of(context).pop();
      },
      icon: BetterIcons.add01Filled,
      primaryButton: AppFilledButton(
        text: context.strings.confirmPay,
        isDisabled: _confirmPayResponse?.isLoading ?? false,
        isLoading: _confirmPayResponse?.isLoading ?? false,
        onPressed: () async {
          if (widget.onConfirmPayPressed != null) {
            setState(() {
              _confirmPayResponse = const ApiResponse.loading();
            });
            final result = await widget.onConfirmPayPressed!(
              _selectedPaymentMethod!,
              _amount,
            );
            setState(() {
              _confirmPayResponse = result;
            });
            if (result.isError) {
              // ignore: use_build_context_synchronously
              context.showFailure(result);
            }

            return;
          }
          if (_selectedPaymentMethod == null) {
            context.showToast(context.strings.selectPaymentMethod);
            return;
          }
          Navigator.of(context).pop(
            AddBalanceDialogResult(
              amount: _amount,
              paymentMethod: _selectedPaymentMethod!,
            ),
          );
        },
      ),
      secondaryButton: AppTextButton(
        isDisabled: _confirmPayResponse?.isLoading ?? false,
        isLoading: _confirmPayResponse?.isLoading ?? false,
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: context.strings.cancel,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.strings.selectAmount,
            style: context.textTheme.titleSmall,
          ),
          const SizedBox(height: 16),
          Row(
            spacing: 8,
            children: widget.presetAmounts.map((amount) {
              return Expanded(
                child: AppBorderedToggleButton(
                  label: amount.formatCurrency(widget.currency),
                  isSelected: _amount == amount,
                  onPressed: () {
                    setState(() {
                      _amount = amount;
                    });
                  },
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          AppCounterInput(
            label: context.strings.enterAmount,
            min: widget.minimumAmount.toInt(),
            max: widget.maximumAmount.toInt(),
            initialValue: _amount.toInt(),
            onChanged: (value) {
              setState(() {
                _amount = value.toDouble();
              });
            },
          ),
          const SizedBox(height: 16),

          if (widget.paymentMethods != null &&
              widget.onAddPaymentMethodPressed != null) ...[
            Text(
              context.strings.selectPaymentMethod,
              style: context.textTheme.titleSmall,
            ),
            const SizedBox(height: 16),
            if (widget.paymentMethods!.data != null)
              AppPaymentMethodsList(
                maxHeight: 250,
                paymentMethods: widget.paymentMethods!.data!,
                onPaymentMethodSelected: (selectedPaymentMethod) {
                  setState(() {
                    _selectedPaymentMethod = selectedPaymentMethod;
                  });
                },
                onAddPaymentMethod: widget.onAddPaymentMethodPressed!,
                selectedPaymentMethod: _selectedPaymentMethod,
              ),
          ],
        ],
      ),
    );
  }
}
