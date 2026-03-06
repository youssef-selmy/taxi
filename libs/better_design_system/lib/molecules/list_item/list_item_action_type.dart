import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:better_design_system/atoms/switch/switch.dart';
import 'package:flutter/material.dart';

enum ListItemActionType {
  none,
  checkbox,
  radio,
  switcher,
  dropdown;

  Widget widget<T>({
    required BuildContext context,
    required bool isSelected,
    Function(bool)? onTap,
    bool isDisabled = false,
    required List<AppDropdownItem<T>> items,
    required Function(T?)? onChanged,
    required T? initialSelectedItem,
  }) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: switch (this) {
        ListItemActionType.dropdown => SizedBox(
          width: 140,
          child: AppDropdownField.single(
            type: DropdownFieldType.compact,
            items: items,
            onChanged: onChanged,
            initialValue: initialSelectedItem,
          ),
        ),
        ListItemActionType.checkbox => AppCheckbox(
          value: isSelected,
          onChanged: isDisabled || onTap == null
              ? null
              : (value) => onTap.call(value),
          isDisabled: isDisabled,
        ),
        ListItemActionType.radio => AppRadio<bool>(
          value: true,
          groupValue: isSelected,
          size: RadioSize.small,
          onTap: isDisabled || onTap == null
              ? null
              : (value) => onTap.call(value),
          isDisabled: isDisabled,
        ),
        ListItemActionType.switcher => AppSwitch(
          isSelected: isSelected,
          onChanged: isDisabled || onTap == null
              ? null
              : (value) => onTap.call(value),
          isDisabled: isDisabled,
        ),
        ListItemActionType.none => const SizedBox.shrink(),
      },
    );
  }
}
