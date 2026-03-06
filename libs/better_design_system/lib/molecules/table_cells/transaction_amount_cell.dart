import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterTransactionAmountCell = AppTransactionAmountCell;

class AppTransactionAmountCell extends StatelessWidget {
  final bool? isIncome;
  final double amount;
  final String currency;

  const AppTransactionAmountCell({
    super.key,
    required this.amount,
    required this.currency,
    this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${isPositive ? "+" : "-"} ${amount.abs().formatCompactCurrency(currency)}",
          style: context.textTheme.labelLarge?.copyWith(
            color: isPositive ? context.colors.success : context.colors.error,
          ),
        ),
        const SizedBox(height: 4),
        Text(currency, style: context.textTheme.bodySmall?.variantLow(context)),
      ],
    );
  }

  bool get isPositive => isIncome ?? amount >= 0;
}
