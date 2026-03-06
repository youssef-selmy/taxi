import 'package:better_design_system/templates/onboarding_template/onboarding_template.dart';
import 'package:better_design_system_widgetbook/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppOnboardingTemplate)
Widget defaultOnboardingTemplate(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(30),
    child: AppOnboardingTemplate(
      backgroundImageAssetPath: Assets.onboardingImage.path,
      logoTypeAssetPathLight: Assets.horizontalLogoType.path,
      title: 'Welcome to the App',
      subtitle: 'This is a brief description of the onboarding process.',
      onGetStarted: () {},
      onSkip: () {},
    ),
  );
}
