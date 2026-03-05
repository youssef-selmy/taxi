import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/gen/assets.gen.dart';

part 'onboarding.model.freezed.dart';

@freezed
sealed class OnBoardingItem with _$OnBoardingItem {
  const factory OnBoardingItem({
    required AssetGenImage image,
    required String title,
    required String description,
  }) = _OnBoardItem;
}

List<OnBoardingItem> onboardingItems(BuildContext context) => [
  OnBoardingItem(
    image: Assets.images.onboarding1,
    title: context.tr.adminPanelOnboardingOneTitle,
    description: context.tr.adminPanelOnboardingOneSubtitle,
  ),
  OnBoardingItem(
    image: Assets.images.onboarding2,
    title: context.tr.adminPanelOnboardingTwoTitle,
    description: context.tr.adminPanelOnboardingTwoSubtitle,
  ),
];
