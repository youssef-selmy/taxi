import 'package:better_design_system/atoms/breadcrumb/breadcrumb.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppBreadcrumb)
Widget appBreadcrumb(BuildContext context) {
  List<BreadcrumbOption> items = [
    BreadcrumbOption(title: 'Shop', value: 1),
    BreadcrumbOption(title: 'Products', value: 2),
    BreadcrumbOption(title: 'Popular', value: 3),
    BreadcrumbOption(title: 'Product', value: 4),
    BreadcrumbOption(title: 'Categories', value: 5),
    BreadcrumbOption(title: 'Electronics', value: 6),
    BreadcrumbOption(title: 'Mobile Phones', value: 7),
    BreadcrumbOption(title: 'Samsung', value: 8),
  ];
  return AppBreadcrumb(
    items: items,
    onPressed: (value) {},
    separator: context.knobs.object.dropdown(
      label: 'Separator',
      options: BreadcrumbSeparator.values,
      initialOption: BreadcrumbSeparator.slash,
      labelBuilder: (value) => value.name,
    ),
    style: context.knobs.object.dropdown(
      label: 'Style',
      options: BreadcrumbStyle.values,
      initialOption: BreadcrumbStyle.ghost,
      labelBuilder: (value) => value.name,
    ),
  );
}
