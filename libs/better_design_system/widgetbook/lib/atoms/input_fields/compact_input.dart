import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/compact_input/compact_input.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppCompactInput)
Widget appCompactInput(BuildContext context) {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  return Form(
    key: key,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: [
        SizedBox(
          width: 352,
          child: AppCompactInput(
            initialValue: 'Placeholder',
            prefixIcon: BetterIcons.userCircle02Outline,
            isDisabled: context.knobs.boolean(
              label: 'Disabled',
              initialValue: false,
            ),
            validator: (value) {
              if (value!.isNotEmpty) {
                return 'This field is required';
              }
              return null;
            },
            onTextSubmitted: (p0) {},
          ),
        ),

        AppFilledButton(
          onPressed: () {
            if (key.currentState!.validate()) {}
          },
          text: 'Click',
        ),
      ],
    ),
  );
}
