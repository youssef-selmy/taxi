import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/molecules/tooltip/tooltip.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Tooltip (Without Buttons)', type: AppTooltip)
Widget defaultappTooltip(BuildContext context) {
  final trigger = context.knobs.object.dropdown(
    label: 'Trigger',
    options: TooltipTrigger.values,
    labelBuilder: (value) => value.name,
    initialOption: TooltipTrigger.click,
  );
  return AppTooltip(
    title: 'Tooltip Text',
    size: context.knobs.object.dropdown(
      label: 'Size',
      options: TooltipSize.values,
      initialOption: TooltipSize.large,
      labelBuilder: (value) => value.name,
    ),
    alignment: context.knobs.object.dropdown(
      label: 'Alignment',
      options: TooltipAlignment.values,
      labelBuilder: (value) => value.name,
    ),
    trigger: trigger,
    showCloseButton: context.knobs.boolean(
      label: 'Show Close Button',
      initialValue: false,
    ),
    child: Text(trigger == TooltipTrigger.click ? 'Click Here' : 'Hover Here'),
  );
}

@UseCase(name: 'Tooltip (With Buttons)', type: AppTooltip)
Widget appTooltip(BuildContext context) {
  final trigger = context.knobs.object.dropdown(
    label: 'Trigger',
    options: TooltipTrigger.values,
    labelBuilder: (value) => value.name,
    initialOption: TooltipTrigger.click,
  );
  return AppTooltip(
    title: 'Tooltip Text',
    subtitle: 'Description here.',
    size: context.knobs.object.dropdown(
      label: 'Size',
      options: TooltipSize.values,
      initialOption: TooltipSize.large,
      labelBuilder: (value) => value.name,
    ),
    icon: BetterIcons.mail02Outline,
    primaryButton:
        trigger == TooltipTrigger.hover
            ? null
            : AppFilledButton(onPressed: () {}, text: 'Button'),
    secondaryButton:
        trigger == TooltipTrigger.hover
            ? null
            : AppOutlinedButton(onPressed: () {}, text: 'Button'),
    alignment: context.knobs.object.dropdown(
      label: 'Alignment',
      options: TooltipAlignment.values,
      labelBuilder: (value) => value.name,
    ),
    showCloseButton: context.knobs.boolean(
      label: 'Show Close Button',
      initialValue: false,
    ),
    trigger: trigger,
    child: Text(trigger == TooltipTrigger.click ? 'Click Here' : 'Hover Here'),
  );
}
