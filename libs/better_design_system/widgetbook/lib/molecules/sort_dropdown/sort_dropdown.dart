import 'package:better_design_system/molecules/sort_dropdown/sort_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSortDropdown)
Widget defaultSortDropdown(BuildContext context) {
  return AppSortDropdown(
    items: ['Option 1', 'Option 2'],
    labelGetter: (p0) => p0,
    selectedValues: ['Option 1'],
  );
}
