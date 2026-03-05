import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

List<BoxShadow> kElevation1(BuildContext context) => [
  BoxShadow(
    color: context.colors.shadow,
    offset: const Offset(0, 4),
    blurRadius: 12,
    spreadRadius: 0,
  ),
];

List<BoxShadow> kBottomBarShadow(BuildContext context) => [
  BoxShadow(
    color: context.colors.shadow,
    blurRadius: 8,
    offset: const Offset(0, -12),
    spreadRadius: 0,
  ),
];

List<BoxShadow> kShadow(BuildContext context) => [
  BoxShadow(
    color: context.colors.shadow,
    offset: const Offset(0, 12),
    blurRadius: 24,
    spreadRadius: 0,
  ),
];

Border kBorder(BuildContext context) =>
    Border.all(color: context.colors.outline);

Border kBorderVariant(BuildContext context) =>
    Border.all(color: context.colors.outlineVariant);
