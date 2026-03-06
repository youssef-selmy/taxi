import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/organisms/phone_number_field/phone_number_field.dart';
import 'package:better_design_system/templates/login_form_template/login_form.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../gen/assets.gen.dart';

@UseCase(name: 'Default', type: AppLoginForm)
Widget defaultLoginFormTemplate(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(30),
    child: AppLoginForm(
      title: 'Enter PhoneNumber',
      subtitle: 'Enter Number Form Subtitle',
      logoTypeAssetPathLight: Assets.horizontalLogoType.path,
      content: AppPhoneNumberField(initialValue: ('US', '')),
      isDesktop: context.isDesktop,
      onBackButtonPressed: () {},
      primaryButton: AppFilledButton(
        onPressed: () {},
        child: Text('Action Continue'),
      ),
    ),
  );
}
