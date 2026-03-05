import 'package:flutter/cupertino.dart';

import 'package:admin_frontend/core/components/kpi_card/delta_text.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';

class WalletBalanceSummary extends StatelessWidget {
  final String title;
  final IconData icon;
  final String currency;
  final double amount;
  final WalletBalanceSummaryColor color;
  final (double, double)? delta;

  const WalletBalanceSummary({
    super.key,
    required this.icon,
    required this.currency,
    required this.amount,
    required this.color,
    required this.title,
    this.delta,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _glyphBackgroundColor(context),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: _glyphColor(context)),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(title, style: context.textTheme.labelMedium)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: amount.formatCurrency(currency),
                    style: context.textTheme.headlineMedium,
                  ),
                  TextSpan(
                    text: " $currency",
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                ],
              ),
            ),
            if (delta != null)
              DeltaText(
                timePeriod: DetailTimePeriod.today,
                previousValue: delta!.$1,
                currentValue: delta!.$2,
                currency: currency,
              ),
          ],
        ),
      ],
    );
  }

  Color _glyphBackgroundColor(BuildContext context) => switch (color) {
    WalletBalanceSummaryColor.primary => context.colors.primaryContainer,
    WalletBalanceSummaryColor.secondary => context.colors.secondaryContainer,
    WalletBalanceSummaryColor.tertiary => context.colors.tertiaryContainer,
    WalletBalanceSummaryColor.green => context.colors.successContainer,
    WalletBalanceSummaryColor.red => context.colors.errorContainer,
    WalletBalanceSummaryColor.orange => context.colors.warningContainer,
  };

  Color _glyphColor(BuildContext context) {
    switch (color) {
      case WalletBalanceSummaryColor.primary:
        return context.colors.primary;
      case WalletBalanceSummaryColor.secondary:
        return context.colors.secondary;
      case WalletBalanceSummaryColor.tertiary:
        return context.colors.tertiary;
      case WalletBalanceSummaryColor.green:
        return context.colors.success;
      case WalletBalanceSummaryColor.red:
        return context.colors.error;
      case WalletBalanceSummaryColor.orange:
        return context.colors.warning;
    }
  }
}

enum WalletBalanceSummaryColor {
  primary,
  secondary,
  tertiary,
  green,
  red,
  orange,
}
