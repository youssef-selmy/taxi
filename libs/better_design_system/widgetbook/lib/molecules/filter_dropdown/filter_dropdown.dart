import 'package:better_design_system/molecules/filter_dropdown/filter_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppFilterDropdown)
Widget defaultFilterDropdown(BuildContext context) {
  return AppFilterDropdown(
    title: "Filter",
    items: [
      FilterItem(label: 'Option 1', value: 0),
      FilterItem(label: 'Option 2', value: 1),
      FilterItem(label: 'Option 3', value: 2),
    ],
    selectedValues: [0],
  );
}
