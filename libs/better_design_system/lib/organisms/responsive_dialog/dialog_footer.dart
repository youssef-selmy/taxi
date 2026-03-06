import 'package:flutter/material.dart';

enum DialogFooterDirection { horizontal, vertical }

typedef BetterDialogFooter = AppDialogFooter;

class AppDialogFooter extends StatelessWidget {
  final Widget? primaryAction;
  final Widget? secondaryAction;
  final Widget? tertiaryAction;
  final DialogFooterDirection direction;

  const AppDialogFooter({
    super.key,
    required this.primaryAction,
    this.secondaryAction,
    this.tertiaryAction,
    this.direction = DialogFooterDirection.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: direction == DialogFooterDirection.horizontal
          ? horizontalDirection(context)
          : verticalDirection(context),
    );
  }

  Widget horizontalDirection(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    child: Row(
      spacing: 8,
      children: [
        if (tertiaryAction != null) ...[Expanded(child: tertiaryAction!)],
        if (secondaryAction != null) ...[
          if (tertiaryAction == null) Expanded(child: secondaryAction!),
          if (tertiaryAction != null) secondaryAction!,
        ],
        if (primaryAction != null) ...[
          if (tertiaryAction == null) Expanded(child: primaryAction!),
          if (tertiaryAction != null) primaryAction!,
        ],
      ],
    ),
  );

  Widget verticalDirection(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        if (primaryAction != null) primaryAction!,
        if (secondaryAction != null) secondaryAction!,
        if (tertiaryAction != null) tertiaryAction!,
      ],
    ),
  );
}
