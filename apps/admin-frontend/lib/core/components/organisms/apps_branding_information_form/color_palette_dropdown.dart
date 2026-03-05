import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';

import 'package:admin_frontend/core/enums/app_color_scheme.enum.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ColorPaletteDropdown extends StatelessWidget {
  final Enum$AppColorScheme? initialValue;
  final void Function(Enum$AppColorScheme?) onChanged;

  const ColorPaletteDropdown({
    super.key,
    this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppDropdownField.single(
      initialValue: initialValue,
      validator: (p0) =>
          (p0 == null) ? context.tr.pleaseSelectColorPalette : null,
      items: Enum$AppColorScheme.values
          .where((e) => e != Enum$AppColorScheme.$unknown)
          .map(
            (e) => AppDropdownItem(
              title: e.title(context),
              value: e,
              prefix: e.toBrandColor,
            ),
          )
          .toList(),
      label: context.tr.colorPalette,
      onChanged: onChanged,
    );
  }
}
