import 'package:better_design_system/atoms/fab/fab.dart';
import 'package:better_design_system_widgetbook/knobs/knobs.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Icon Only', type: AppFab)
Widget fabUseCase(BuildContext context) {
  final style = context.knobs.fabStyle;
  final size = context.knobs.buttonSize;
  final color = context.knobs.semanticColor;
  final isDisabled = context.knobs.isDisabled;

  return AppFab.icon(
    icon: BetterIcons.pencilEdit01Outline,
    onPressed: () {},
    style: style,
    size: size,
    color: color,
    isDisabled: isDisabled,
  );
}

@UseCase(name: 'Extended', type: AppFab)
Widget defaultFabWidget(BuildContext context) {
  final style = context.knobs.fabStyle;
  final prefixIcon =
      context.knobs.boolean(label: "Show Prefix Icon", initialValue: false)
          ? BetterIcons.pencilEdit01Outline
          : null;
  final text = context.knobs.title;
  final showSuffixIcon = context.knobs.boolean(
    label: "Show Suffix Icon",
    initialValue: false,
  );
  final size = context.knobs.buttonSize;
  final isDisabled = context.knobs.isDisabled;
  final color = context.knobs.semanticColor;

  return AppFab.extended(
    onPressed: () {},
    style: style,
    size: size,
    color: color,
    isDisabled: isDisabled,
    prefixIcon: prefixIcon,
    text: text,
    suffixIcon: showSuffixIcon ? BetterIcons.userMultipleOutline : null,
  );
}
