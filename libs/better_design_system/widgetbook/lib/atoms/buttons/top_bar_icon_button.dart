import 'package:better_design_system/atoms/buttons/top_bar_icon_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppTopBarIconButton)
Widget topBarIconButtonUseCase(BuildContext context) {
  final style = context.knobs.object.dropdown<String>(
    label: 'Style',
    options: ['Ghost', 'Outline'],
    initialOption: 'Ghost',
  );

  final isSelected = context.knobs.boolean(
    label: 'Is Selected',
    initialValue: false,
  );

  final badgeCount = context.knobs.intOrNull.slider(
    label: 'Badge Count (Optional)',
    initialValue: null,
    max: 99,
  );

  if (style == 'Outline') {
    return AppTopBarIconButton.outline(
      icon: BetterIcons.notification02Outline,
      isSelected: isSelected,
      badgeCount: badgeCount,
      onPressed: () {},
    );
  }

  return AppTopBarIconButton(
    icon: BetterIcons.notification02Outline,
    isSelected: isSelected,
    badgeCount: badgeCount,
    onPressed: () {},
  );
}
