import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/widgets.dart';

enum SavedPaymentMethodType {
  normal,
  business,
  marketing,
  personal,
  cardNumber,
}

enum SavedPaymentMethodStyle {
  solidBlue,
  gradientRed,
  gradientPurple,
  gradientBlue,
}

class FintechSavedPaymentMethodCard extends StatelessWidget {
  final String? expireDate;
  final String cardSubtitle;
  final String displayValue;
  final SavedPaymentMethodType type;
  final SavedPaymentMethodStyle style;
  const FintechSavedPaymentMethodCard({
    super.key,
    required this.cardSubtitle,
    required this.displayValue,
    this.expireDate,
    this.type = SavedPaymentMethodType.normal,
    this.style = SavedPaymentMethodStyle.solidBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      constraints: BoxConstraints(maxWidth: 316),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _getBackground(context),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Assets.images.paymentMethods.mastercardPng.image(
                            height: 32,
                            width: 32,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'mastercard',
                            style: context.textTheme.labelLarge,
                          ),
                        ],
                      ),

                      AppIconButton(
                        icon: BetterIcons.moreHorizontalCircle01Filled,
                        size: ButtonSize.medium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 37),
                  Text(
                    _typeText,
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                  const SizedBox(height: 4),
                  Text(displayValue, style: context.textTheme.titleLarge),
                ],
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(color: context.colors.onSurface),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  cardSubtitle,
                  style: context.textTheme.labelMedium?.apply(
                    color: context.colors.surface,
                  ),
                ),
                if (expireDate != null) ...[
                  const Spacer(),
                  Text(
                    'Exp $expireDate',
                    style: context.textTheme.labelMedium?.apply(
                      color: context.colors.surface,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get _typeText => switch (type) {
    SavedPaymentMethodType.normal => 'Total Amount',
    SavedPaymentMethodType.business => 'Business',
    SavedPaymentMethodType.marketing => 'Marketing',
    SavedPaymentMethodType.personal => 'Personal',
    SavedPaymentMethodType.cardNumber => 'Card Number',
  };

  ImageProvider _getBackground(BuildContext context) => switch (style) {
    SavedPaymentMethodStyle.solidBlue =>
      Assets.images.cardBackgrounds.solidBlue.provider(),
    SavedPaymentMethodStyle.gradientRed =>
      context.isDark
          ? Assets.images.cardBackgrounds.linearGradientStyle1Dark.provider()
          : Assets.images.cardBackgrounds.linearGradientStyle1.provider(),
    SavedPaymentMethodStyle.gradientPurple =>
      Assets.images.cardBackgrounds.linearGradientStyle2.provider(),
    SavedPaymentMethodStyle.gradientBlue =>
      Assets.images.cardBackgrounds.linearGradientStyle3.provider(),
  };
}
