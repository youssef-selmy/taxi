import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

typedef BetterSelectPaymentMethodButton = AppSelectPaymentMethodButton;

class AppSelectPaymentMethodButton extends StatelessWidget {
  final PaymentMethodEntity? paymentMethod;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  const AppSelectPaymentMethodButton({
    super.key,
    this.paymentMethod,
    this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppOutlinedButton(
      prefix: icon(context),
      color: paymentMethod == null
          ? SemanticColor.warning
          : SemanticColor.primary,
      onPressed: onPressed,
      alignment: MainAxisAlignment.start,
      backgroundColor: paymentMethod == null
          ? SemanticColor.warning.containerColor(context)
          : backgroundColor,
      foregroundColor: paymentMethod == null
          ? SemanticColor.warning.main(context)
          : SemanticColor.neutral.main(context),
      borderColor: paymentMethod == null
          ? SemanticColor.warning.main(context)
          : null,
      text: paymentMethod == null
          ? "Select payment method"
          : paymentMethod!.title,
      suffixIcon: BetterIcons.arrowRight01Outline,
      suffix: const Spacer(),
    );
  }

  Widget icon(BuildContext context) => paymentMethod != null
      ? paymentMethod!.icon(color: SemanticColor.primary.main(context))
      : Icon(
          BetterIcons.creditCardFilled,
          size: 24,
          color: SemanticColor.warning.main(context),
        );
}
