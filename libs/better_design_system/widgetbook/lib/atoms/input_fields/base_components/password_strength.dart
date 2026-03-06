import 'package:better_design_system/atoms/input_fields/base_components/password_strength.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppPasswordStrength)
Widget defaultPasswordStrength(BuildContext context) {
  return SizedBox(
    width: 600,
    child: AppPasswordStrength(
      password: context.knobs.object.dropdown(
        label: 'Password',
        options: [
          'p',
          'password',
          'password123',
          'password123!',
          'password123!@#',
        ],
      ),
      confirmPassword: context.knobs.object.dropdown(
        label: 'Confirm Password',
        options: [
          'p',
          'password',
          'password123',
          'password123!',
          'password123!@#',
        ],
      ),
      isObscure: context.knobs.boolean(label: 'Is Obscure', initialValue: true),
    ),
  );
}
