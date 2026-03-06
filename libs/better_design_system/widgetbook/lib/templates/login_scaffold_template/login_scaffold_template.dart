import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/pin_field/pin_field.dart';
import 'package:better_design_system/organisms/phone_number_field/phone_number_field.dart';
import 'package:better_design_system/templates/login_form_template/login_form.dart';
import 'package:better_design_system/templates/login_scaffold_template/login_scaffold_template.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system_widgetbook/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppLoginScaffoldTemplate)
Widget defaultLoginScaffoldTemplate(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(30),
    child: AppLoginScaffoldTemplate(
      screens: [
        LoginScreen(
          child: AppLoginForm(
            title: 'Enter PhoneNumber',
            subtitle: 'Enter Number Form Subtitle',
            logoTypeAssetPathLight: Assets.horizontalLogoType.path,

            onBackButtonPressed: () {},
            content: AppPhoneNumberField(initialValue: ('US', '')),
            primaryButton: AppFilledButton(
              onPressed: () {},
              child: Text('Action Continue'),
            ),
          ),
          model: 0,
        ),

        LoginScreen(
          child: AppLoginForm(
            title: 'Enter Phone Number',
            subtitle: 'Enter Number Form Subtitle',
            logoTypeAssetPathLight: Assets.horizontalLogoType.path,
            onBackButtonPressed: () {},
            content: AppPinField(length: 6),
            primaryButton: AppFilledButton(
              onPressed: () {},
              child: Text('Action Continue'),
            ),
          ),
          model: 1,
        ),
      ],
      selectedPage: context.knobs.int.slider(
        label: 'Select Page',
        min: 0,
        max: 1,
        initialValue: 0,
      ),
      isDesktop: context.isDesktop,
    ),
  );
}
