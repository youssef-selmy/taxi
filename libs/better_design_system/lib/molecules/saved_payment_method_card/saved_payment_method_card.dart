import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

typedef BetterSavedPaymentMethodCard = AppSavedPaymentMethodCard;

class AppSavedPaymentMethodCard extends StatelessWidget {
  final PaymentMethodCard? cardType;
  final String title;
  final String expirationDate;
  final String? holderName;
  final bool isLoading;
  final Function()? onPressed;
  final Function()? onDeletePressed;
  final Function()? onMarkAsDefaultPressed;

  const AppSavedPaymentMethodCard({
    super.key,
    required this.cardType,
    required this.title,
    required this.expirationDate,
    required this.holderName,
    this.isLoading = false,
    this.onPressed,
    this.onDeletePressed,
    this.onMarkAsDefaultPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 400,
        height: 200,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Skeletonizer(
          enabled: isLoading,
          enableSwitchAnimation: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Assets.images.cardBackgrounds.linearGradientStyle1
                          .provider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (cardType != null)
                        Align(
                          alignment: Alignment.topRight,
                          child: cardType!.logo.image(
                            height: 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 32),
                      Text(
                        context.strings.cardNumber,
                        style: context.textTheme.labelMedium?.apply(
                          color: context.colors.fixedDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: context.textTheme.titleLarge?.apply(
                          color: context.colors.fixedDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: context.colors.fixedDark),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Text(
                      holderName ?? '',
                      style: context.textTheme.labelMedium?.apply(
                        color: context.colors.fixedLight,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${context.strings.expiryDate} $expirationDate',
                      style: context.textTheme.labelMedium?.apply(
                        color: context.colors.fixedLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
