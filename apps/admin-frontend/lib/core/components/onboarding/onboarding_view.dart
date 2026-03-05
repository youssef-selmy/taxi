import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/auth/domain/entities/onboarding.model.dart';

class OnboardingView extends StatelessWidget {
  final OnBoardingItem onBoardingItem;

  const OnboardingView({super.key, required this.onBoardingItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: onBoardingItem.image.image(
            isAntiAlias: true,
            filterQuality: FilterQuality.high,
          ),
        ),
        const SizedBox(height: 32),
        Text(onBoardingItem.title, style: context.textTheme.headlineLarge),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Text(
            onBoardingItem.description,
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium?.variant(context),
          ),
        ),
      ],
    );
  }
}
