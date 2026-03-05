import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/onboarding/onboarding_view.dart';
import 'package:admin_frontend/core/components/stepper_dots/stepper_dots.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/auth/domain/entities/onboarding.model.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.6,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingView(
                onBoardingItem: onboardingItems(context)[index],
              );
            },
            itemCount: 2,
          ),
        ),
        const SizedBox(height: 64),
        AppStepperDots(activeIndex: currentPage, count: 2, isWide: false),
      ],
    );
  }
}
