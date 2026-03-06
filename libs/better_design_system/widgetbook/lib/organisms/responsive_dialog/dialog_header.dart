import 'package:better_design_system/colors/semantic_color.dart';
import 'package:better_design_system/organisms/responsive_dialog/dialog_header.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppDialogHeader)
Widget defaultAppDialogHeader(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppDialogHeader(
      title: 'Title',
      subtitle: 'Subtitle',
      icon: BetterIcons.moon02Outline,
      iconStyle: context.knobs.object.dropdown(
        label: 'Icon Style',
        options: DialogHeaderIconStyle.values,
        initialOption: DialogHeaderIconStyle.simple,
        labelBuilder: (option) => option.name,
      ),
      iconColor: context.knobs.object.dropdown(
        label: 'Icon Color',
        options: SemanticColor.values,
        initialOption: SemanticColor.primary,
        labelBuilder: (option) => option?.name ?? '-',
      ),
      alignment: context.knobs.object.dropdown(
        label: 'Alignment',
        options: DialogHeaderAlignment.values,
        initialOption: DialogHeaderAlignment.start,
        labelBuilder: (option) => option.name,
      ),
      onClosePressed: () {},
    ),
  );
}
