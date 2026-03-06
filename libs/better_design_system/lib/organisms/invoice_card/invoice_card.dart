import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

import 'invoice_item.dart';

export 'invoice_item.dart';

typedef BetterInvoiceCard = AppInvoiceCard;

class AppInvoiceCard extends StatelessWidget {
  final List<InvoiceItem> items;
  final String currency;
  final bool showPaymentMethod;
  final Function()? onSelectPaymentMethod;
  final PaymentMethodEntity? selectedPaymentMethod;
  final bool borderLess;

  const AppInvoiceCard({
    super.key,
    required this.items,
    required this.currency,
    this.borderLess = false,
    this.showPaymentMethod = false,
    this.onSelectPaymentMethod,
    this.selectedPaymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final total = items.fold<double>(0, (sum, item) => sum + item.amount);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: borderLess
          ? null
          : BoxDecoration(
              color: context.colors.surfaceVariantLow,
              border: Border.all(color: context.colors.outline),
              borderRadius: BorderRadius.circular(16),
            ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var item in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: context.textTheme.labelLarge,
                    ),
                  ),
                  Text(
                    item.amount.formatCurrency(currency),
                    style: context.textTheme.labelLarge?.variant(context),
                  ),
                ],
              ),
            ),
          const AppDivider(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  context.strings.total,
                  style: context.textTheme.titleSmall,
                ),
              ),
              Text(
                (total > 0 ? total : 0.0).formatCurrency(currency),
                style: context.textTheme.headlineLarge?.primaryColor(context),
              ),
            ],
          ),
          if (showPaymentMethod) ...[
            const AppDivider(height: 16),
            if (selectedPaymentMethod != null) ...[
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: context.colors.outline),
                      color: context.colors.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: selectedPaymentMethod!.icon(size: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    selectedPaymentMethod!.title,
                    style: context.textTheme.labelLarge,
                  ),
                ],
              ),
            ],
            if (onSelectPaymentMethod != null) ...[
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: AppTextButton(
                  color: SemanticColor.primary,
                  onPressed: () {
                    onSelectPaymentMethod!();
                  },
                  text: context.strings.selectPaymentMethod,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
