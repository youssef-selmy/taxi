import 'package:better_design_system/atoms/buttons/button_size.dart';
import 'package:better_design_system/atoms/fab/fab.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field_type.dart';
import 'package:better_design_system/atoms/input_fields/text_field_density.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/molecules/list_item/list_action.dart';
import 'package:better_design_system/molecules/list_item/vertical_toggle_item.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook/widgetbook.dart';

extension BetterKnobs on KnobsBuilder {
  String get currency => object.dropdown(
    label: 'Currency',
    options: ['USD', 'EUR', 'GBP', 'JPY'],
    initialOption: 'USD',
    labelBuilder: (value) => value.toString(),
  );
  SemanticColor get semanticColor => object.dropdown(
    label: 'Semantic Color',
    description: 'Select the semantic color',
    initialOption: SemanticColor.primary,
    options: SemanticColor.values,
    labelBuilder: (value) => value.name,
  );

  TextFieldDensity get textFieldDensity => object.dropdown(
    label: 'Density',
    description: 'Select the text field density',
    options: TextFieldDensity.values,
    labelBuilder: (value) => value.name,
  );

  DropdownFieldType get dropdownFieldType => object.dropdown(
    label: 'Dropdown Field Type',
    description: 'Select the dropdown field type',
    initialOption: DropdownFieldType.normal,
    options: DropdownFieldType.values,
    labelBuilder: (value) => value.name,
  );

  String get title => string(
    label: 'Title',
    initialValue: 'Title',
    description: 'Enter the title for the widget',
  );

  DateTime get createdAt => dateTime(
    start: DateTime(2020),
    end: DateTime(2030),
    label: 'Created At',
    description: 'Select a date and time',
    initialValue: DateTime.now(),
  );

  String? get userImageNullable => stringOrNull(
    label: 'User Image',
    description: 'Enter the user image URL or leave it empty',
    initialValue: ImageFaker().person.random(),
  );

  String get subLabel => string(
    label: 'Sub Label',
    initialValue: 'Sub Label',
    description: 'Enter the sub label for the widget',
  );

  bool get isFilled => boolean(
    label: 'Is Filled',
    initialValue: true,
    description: 'Select if the widget has a filled background',
  );

  bool get isDisabled => boolean(
    label: 'Is Disabled',
    initialValue: false,
    description: 'Select if the widget is disabled',
  );

  bool get isCompact => boolean(
    label: "Is Compact",
    initialValue: false,
    description: 'Select if the widget is compact in size',
  );

  bool get isSelected => boolean(
    label: "Is Selected",
    initialValue: false,
    description: "Select if the widget is in selected state",
  );

  ListActionType get actionType => object.dropdown(
    label: 'Action Type',
    description: 'Select the action type for the list item',
    initialOption: null,
    options: ListActionType.values,
    labelBuilder:
        (value) => switch (value) {
          ListActionType.checkable => 'Checkable',
          ListActionType.clickable => 'Clickable',
          ListActionType.dropdown => 'Dropdown',
        },
  );

  ListItemActionType get listItemActionType => object.dropdown(
    label: 'List Item Action Type',
    description: 'Select the action type for the list item',
    initialOption: ListItemActionType.none,
    options: ListItemActionType.values,
    labelBuilder: (value) => value.name,
  );

  ButtonSize get buttonSize => object.dropdown(
    label: 'Button Size',
    description: 'Select the button size',
    initialOption: ButtonSize.large,
    options: ButtonSize.values,
    labelBuilder: (value) => value.name,
  );

  AppFabStyle get fabStyle => object.dropdown(
    label: 'Style',
    options: AppFabStyle.values,
    initialOption: AppFabStyle.soft,
    labelBuilder: (value) => value.name,
    description: 'Controls the visual style (filled or outlined).',
  );

  TagSize get tagSize => object.dropdown(
    label: 'Tag Size',
    description: 'Select the tag size',
    initialOption: TagSize.medium,
    options: TagSize.values,
    labelBuilder: (value) => value.name,
  );

  // DropdownFieldType get dropdownType => list(
  //   label: 'Dropdown Type',
  //   description: 'Select the dropdown type',
  //   initialOption: DropdownFieldType.normal,
  //   options: DropdownFieldType.values,
  //   labelBuilder: (value) => value.name,
  // );

  String get subtitle => string(
    label: 'Subtitle',
    initialValue: 'Subtitle',
    description: 'Enter the subtitle for the widget',
  );

  IconData? get iconOrNull {
    final icons = [
      BetterIcons.globalOutline,
      BetterIcons.checkmarkCircle02Filled,
      BetterIcons.checkmarkCircle02Outline,
      BetterIcons.car01Filled,
    ];
    return objectOrNull.dropdown(
      label: 'Icon',
      description: 'Select an icon or leave it empty',
      labelBuilder:
          (value) => switch (value) {
            BetterIcons.globalOutline => 'Global Icon',
            BetterIcons.checkmarkCircle02Filled => 'Checkmark Circle Filled',
            BetterIcons.checkmarkCircle02Outline => 'Checkmark Circle Outline',
            BetterIcons.car01Filled => 'Car Icon',
            _ => '-',
          },
      options: icons,
    );
  }

  IconData get icon {
    final icons = [
      BetterIcons.globalOutline,
      BetterIcons.checkmarkCircle02Filled,
      BetterIcons.checkmarkCircle02Outline,
      BetterIcons.car01Filled,
    ];
    return object.dropdown(
      label: 'Icon',
      description: 'Select an icon',
      initialOption: icons.first,
      labelBuilder:
          (value) => switch (icons) {
            BetterIcons.globalOutline => 'Global Icon',
            BetterIcons.checkmarkCircle02Filled => 'Checkmark Circle Filled',
            BetterIcons.checkmarkCircle02Outline => 'Checkmark Circle Outline',
            BetterIcons.car01Filled => 'Car Icon',
            _ => '-',
          },
      options: icons,
    );
  }
}
