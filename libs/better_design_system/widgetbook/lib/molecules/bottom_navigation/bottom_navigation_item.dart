import 'package:better_design_system/molecules/bottom_navigation/bottom_navigation_item.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppBottomNavigationItem)
Widget bottomNavItemUseCase(BuildContext context) {
  final iconOptions = {
    'Home Outline': BetterIcons.home01Outline,
    'Home Filled': BetterIcons.home01Filled,
    'User Outline': BetterIcons.userOutline,
    'User Filled': BetterIcons.userFilled,
    'Checkmark Outline': BetterIcons.checkmarkCircle02Outline,
    'Checkmark Filled': BetterIcons.checkmarkCircle02Filled,
  };

  final outlineIcon = context.knobs.object.dropdown<IconData>(
    label: 'Icon (Outline)',
    options: [
      BetterIcons.home01Outline,
      BetterIcons.userOutline,
      BetterIcons.checkmarkCircle02Outline,
    ],
    initialOption: BetterIcons.home01Outline,
    labelBuilder: (value) {
      return iconOptions.entries
          .firstWhere(
            (entry) => entry.value == value,
            orElse: () => const MapEntry('Unknown', Icons.help),
          )
          .key;
    },
    description: 'Select the outline icon.',
  );

  final filledIcon = context.knobs.object.dropdown<IconData>(
    label: 'Active Icon (Filled)',
    options: [
      BetterIcons.home01Filled,
      BetterIcons.userFilled,
      BetterIcons.checkmarkCircle02Filled,
    ],
    initialOption: BetterIcons.home01Filled,
    labelBuilder: (value) {
      return iconOptions.entries
          .firstWhere(
            (entry) => entry.value == value,
            orElse: () => const MapEntry('Unknown', Icons.help),
          )
          .key;
    },
    description: 'Select the filled icon for selected/pressed state.',
  );

  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Title',
    description: 'The label text under the icon.',
  );

  final color = context.knobs.object.dropdown<SemanticColor>(
    label: 'Semantic Color',
    options: SemanticColor.values,
    initialOption: SemanticColor.primary,
    labelBuilder: (value) => value.name,
    description: 'Defines the base color scheme.',
  );

  final displayType = context.knobs.object.dropdown<BottomNavItemDisplayType>(
    label: 'Display Type',
    options: BottomNavItemDisplayType.values,
    initialOption: BottomNavItemDisplayType.withoutContainerHorizontal,
    labelBuilder: (value) => value.name,
    description: 'Choose the layout orientation.',
  );

  final selected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
    description: 'Whether the item is selected.',
  );

  final isDisabled = context.knobs.boolean(
    label: 'Is Disabled',
    initialValue: false,
    description: 'Whether the item is disabled.',
  );

  final badgeCount = context.knobs.intOrNull.slider(
    label: 'Badge Count (Optional)',
    initialValue: null,
    description: 'Displays a count badge if a non-null value is provided.',
  );

  return AppBottomNavigationItem<String>(
    icon: Icon(outlineIcon),
    activeIcon: Icon(filledIcon),
    label: label,
    color: color,
    displayType: displayType,
    selected: selected,
    isDisabled: isDisabled,
    badgeCount: badgeCount,
    value: 'item_1', // Provide the required 'value' parameter
    onPressed: () {},
  );
}
