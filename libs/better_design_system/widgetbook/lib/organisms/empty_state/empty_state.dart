import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:better_assets/assets.dart';

@UseCase(name: 'Default', type: AppEmptyState)
Widget defaultEmptyState(BuildContext context) {
  return AppEmptyState(
    title: 'No data available',
    image: Assets.images.emptyStates.noRecord,
    actionText: 'Retry',
  );
}
