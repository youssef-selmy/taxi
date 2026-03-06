import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppResponsiveDialog)
Widget defaultResponsiveDialog(BuildContext context) {
  return AppResponsiveDialog(
    title: 'Dialog Title',
    subtitle: 'Dialog Subtitle',
    icon: BetterIcons.flag02Filled,
    onClosePressed: () {},
    iconColor: context.knobs.object.dropdown(
      label: 'Icon Color',
      options: SemanticColor.values,
      initialOption: SemanticColor.primary,
      labelBuilder: (option) => option?.name ?? '-',
    ),
    iconStyle: context.knobs.object.dropdown(
      label: 'Icon Style',
      options: DialogHeaderIconStyle.values,
      initialOption: DialogHeaderIconStyle.simple,
      labelBuilder: (option) => option.name,
    ),
    alignment: context.knobs.object.dropdown(
      label: 'Alignment',
      options: DialogHeaderAlignment.values,
      initialOption: DialogHeaderAlignment.start,
      labelBuilder: (option) => option.name,
    ),
    primaryButton: AppFilledButton(onPressed: () {}, text: 'Primary'),
    secondaryButton: AppFilledButton(
      onPressed: () {},
      text: 'Secondary',
      color: SemanticColor.primary,
    ),
    tertiaryButton: AppFilledButton(
      onPressed: () {},
      text: 'Tertiary',
      color: SemanticColor.error,
    ),
    defaultDialogType: context.knobs.object.dropdown(
      label: 'Dialog Type',
      options: DialogType.values,
      initialOption: DialogType.dialog,
      labelBuilder: (option) => option.name,
    ),
    child: const SizedBox(height: 100, child: Center(child: Text("Content"))),
  );
}
