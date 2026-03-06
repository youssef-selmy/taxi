import 'package:better_design_system/atoms/buttons/fab_size.dart';
import 'package:better_design_system/molecules/bottom_navigation/bottom_navigation_fab.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: BottomNavFab)
Widget bottomNavFabUseCase(BuildContext context) {
  final iconOptions = {
    'Add Outline': BetterIcons.add01Outline,
    'Add Filled': BetterIcons.add01Filled,
    'Home Outline': BetterIcons.home01Outline,
    'Home Filled': BetterIcons.home01Filled,
    'Star Outline': BetterIcons.starOutline,
    'Star Filled': BetterIcons.starFilled,
  };

  final outlineIcon = context.knobs.object.dropdown<IconData>(
    label: 'Icon (Outline)',
    options: [
      BetterIcons.add01Outline,
      BetterIcons.home01Outline,
      BetterIcons.starOutline,
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
      BetterIcons.add01Filled,
      BetterIcons.home01Filled,
      BetterIcons.starFilled,
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

  final color = context.knobs.object.dropdown<SemanticColor>(
    label: 'Semantic Color',
    options: SemanticColor.values,
    initialOption: SemanticColor.primary,
    labelBuilder: (value) => value.name,
    description: 'Defines the base color scheme for the FAB.',
  );

  final selected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
    description: 'Whether the FAB is in a selected state.',
  );

  final isDisabled = context.knobs.boolean(
    label: 'Is Disabled',
    initialValue: false,
    description: 'Whether the FAB is disabled.',
  );

  final badgeCount = context.knobs.intOrNull.slider(
    label: 'Badge Count (Optional)',
    initialValue: null,
    min: 0,
    max: 99,
    description: 'Displays a count badge if a non-null value is provided.',
  );

  final fabSize = context.knobs.object.dropdown<FabSize>(
    label: 'FAB Size',
    options: FabSize.values,
    initialOption: FabSize.extraLarge,
    labelBuilder: (value) => value.name,
    description:
        'Controls the size of the FAB (small, medium, large, extraLarge).',
  );

  return BottomNavFab(
    icon: Icon(outlineIcon),
    activeIcon: Icon(filledIcon),
    color: color,
    selected: selected,
    isDisabled: isDisabled,
    badgeCount: badgeCount,
    fabSize: fabSize,
    onPressed: () {},
  );
}
