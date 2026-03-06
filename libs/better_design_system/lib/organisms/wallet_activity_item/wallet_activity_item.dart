import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

export 'package:better_design_system/colors/semantic_color.dart';

typedef BetterWalletActivityItem = AppWalletActivityItem;

class AppWalletActivityItem extends StatefulWidget {
  final String title;
  final String currency;
  final double amount;
  final DateTime date;
  final IconData icon;
  final SemanticColor iconColor;
  final Function()? onPressed;
  final bool isLoading;

  const AppWalletActivityItem({
    super.key,
    required this.title,
    required this.currency,
    required this.amount,
    required this.date,
    required this.icon,
    this.iconColor = SemanticColor.primary,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  State<AppWalletActivityItem> createState() => _AppWalletActivityItemState();
}

class _AppWalletActivityItemState extends State<AppWalletActivityItem> {
  bool _isHovering = false;
  bool _isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.isLoading,
      enableSwitchAnimation: true,

      child: InkWell(
        onHover: (value) => setState(() => _isHovering = value),
        onHighlightChanged: (value) => setState(() => _isHighlighted = value),
        onTap: widget.onPressed,
        child: AnimatedContainer(
          padding: const EdgeInsets.all(8),
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: _backgroundColor(context),
            border: Border.all(color: _borderColor(context)),
          ),
          child: Row(
            spacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  border: Border.all(color: context.colors.outline),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.iconColor.main(context),
                  size: 24,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(widget.title, style: context.textTheme.labelLarge),
                    Text(
                      widget.date.formatDateTime,
                      style: context.textTheme.bodySmall?.variant(context),
                    ),
                  ],
                ),
              ),
              Text(
                widget.amount.formatCurrency(widget.currency),
                style: context.textTheme.labelLarge?.apply(
                  color: widget.amount >= 0
                      ? context.colors.success
                      : context.colors.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _borderColor(BuildContext context) {
    if (_isHovering || _isHighlighted) {
      return context.colors.outlineVariant;
    } else {
      return context.colors.outline;
    }
  }

  Color _backgroundColor(BuildContext context) {
    if (_isHighlighted) {
      return context.colors.surfaceVariant;
    } else {
      return context.colors.surfaceVariantLow;
    }
  }
}
