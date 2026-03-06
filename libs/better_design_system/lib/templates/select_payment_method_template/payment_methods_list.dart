import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

typedef BetterPaymentMethodsList = AppPaymentMethodsList;

class AppPaymentMethodsList extends StatefulWidget {
  final List<PaymentMethodEntity> paymentMethods;
  final Function(PaymentMethodEntity) onPaymentMethodSelected;
  final Function()? onAddPaymentMethod;
  final PaymentMethodEntity? selectedPaymentMethod;
  final double? maxHeight;
  final bool showWalletCreditOption;
  final bool isWalletCreditSufficient;
  final bool showCashOption;
  final String walletCreditTitle;
  final String cashTitle;
  final String insufficientWalletCreditMessage;
  final List<Widget> additionalOptions;

  const AppPaymentMethodsList({
    super.key,
    required this.paymentMethods,
    this.additionalOptions = const [],
    required this.onPaymentMethodSelected,
    required this.onAddPaymentMethod,
    required this.selectedPaymentMethod,
    this.showWalletCreditOption = false,
    this.isWalletCreditSufficient = true,
    this.showCashOption = false,
    this.walletCreditTitle = 'Wallet Credit',
    this.cashTitle = 'Cash',
    this.insufficientWalletCreditMessage = 'Insufficient wallet credit',
    this.maxHeight,
  });

  @override
  State<AppPaymentMethodsList> createState() => _AppPaymentMethodsListState();
}

class _AppPaymentMethodsListState extends State<AppPaymentMethodsList> {
  PaymentMethodEntity? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _selectedPaymentMethod = widget.selectedPaymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.maxHeight != null) {
      return SizedBox(
        height: widget.maxHeight,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...widget.additionalOptions,
                    for (var paymentMethod in widget.paymentMethods)
                      AppListItem(
                        isCompact: true,
                        title: paymentMethod.title,
                        isSelected:
                            _selectedPaymentMethod?.id == paymentMethod.id &&
                            _selectedPaymentMethod?.type == paymentMethod.type,
                        leading: Padding(
                          padding: const EdgeInsets.all(4),
                          child: paymentMethod.icon(
                            size: 24,
                            color: SemanticColor.primary.main(context),
                          ),
                        ),
                        actionType: ListItemActionType.radio,
                        onTap: (value) => setState(() {
                          _selectedPaymentMethod = paymentMethod;
                          widget.onPaymentMethodSelected(paymentMethod);
                        }),
                      ),
                    if (widget.showWalletCreditOption)
                      AppListItem(
                        isCompact: true,
                        title: widget.walletCreditTitle,
                        isDisabled: !widget.isWalletCreditSufficient,
                        badge: widget.isWalletCreditSufficient
                            ? null
                            : AppBadge(
                                text: widget.insufficientWalletCreditMessage,
                                isRounded: true,
                                color: SemanticColor.warning,
                              ),
                        isSelected:
                            _selectedPaymentMethod?.type ==
                            PaymentMethodType.walletCredit,
                        leading: Padding(
                          padding: const EdgeInsets.all(4),
                          child: PaymentMethodEntity.walletCredit().icon(
                            size: 24,
                            color: SemanticColor.primary.main(context),
                          ),
                        ),
                        actionType: ListItemActionType.radio,
                        onTap: (value) {
                          setState(() {
                            _selectedPaymentMethod =
                                PaymentMethodEntity.walletCredit();
                            widget.onPaymentMethodSelected(
                              _selectedPaymentMethod!,
                            );
                          });
                        },
                      ),
                    if (widget.showCashOption)
                      AppListItem(
                        isCompact: true,
                        title: widget.cashTitle,
                        isSelected:
                            _selectedPaymentMethod?.type ==
                            PaymentMethodType.cash,
                        leading: Padding(
                          padding: const EdgeInsets.all(4),
                          child: PaymentMethodEntity.cash().icon(
                            size: 24,
                            color: SemanticColor.primary.main(context),
                          ),
                        ),
                        actionType: ListItemActionType.radio,
                        onTap: (value) {
                          setState(() {
                            _selectedPaymentMethod = PaymentMethodEntity.cash();
                            widget.onPaymentMethodSelected(
                              _selectedPaymentMethod!,
                            );
                          });
                        },
                      ),
                  ].separated(separator: const AppDivider(height: 16)),
                ),
              ),
            ),
            if (widget.onAddPaymentMethod != null) ...[
              const AppDivider(height: 16),
              _addPaymentMethodButton(context),
            ],
          ],
        ),
      );
    }

    return Column(
      children: [
        for (var paymentMethod in widget.paymentMethods)
          AppListItem(
            isCompact: true,
            title: paymentMethod.title,
            isSelected:
                _selectedPaymentMethod?.id == paymentMethod.id &&
                _selectedPaymentMethod?.type == paymentMethod.type,
            leading: Padding(
              padding: const EdgeInsets.all(4),
              child: paymentMethod.icon(
                size: 32,
                color: SemanticColor.primary.main(context),
              ),
            ),
            actionType: ListItemActionType.radio,
            onTap: (value) => setState(() {
              _selectedPaymentMethod = paymentMethod;
              widget.onPaymentMethodSelected(paymentMethod);
            }),
          ),
        _addPaymentMethodButton(context),
      ].separated(separator: const AppDivider(height: 16)),
    );
  }

  Widget _addPaymentMethodButton(BuildContext context) {
    if (widget.onAddPaymentMethod == null) {
      return const SizedBox.shrink();
    }
    return AppListItem(
      title: context.strings.addNewPaymentMethod,
      isCompact: true,
      iconColor: SemanticColor.primary,
      onTap: (_) => widget.onAddPaymentMethod?.call(),
      icon: BetterIcons.addCircleFilled,
    );
  }
}
