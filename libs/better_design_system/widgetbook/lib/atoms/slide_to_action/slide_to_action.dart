import 'package:better_design_system/atoms/slide_to_action/slide_to_action.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSlideToAction)
Widget defaultSlideToAction(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppSlideToAction(
      onSlided: () {},
      text: context.knobs.string(
        label: 'Text',
        initialValue: 'Slide to action',
      ),
      isDisabled: context.knobs.boolean(label: 'Disabled', initialValue: false),
    ),
  );
}
