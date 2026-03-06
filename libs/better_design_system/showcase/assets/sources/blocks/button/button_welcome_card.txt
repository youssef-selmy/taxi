import 'package:better_assets/assets.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class ButtonWelcomeCard extends StatelessWidget {
  const ButtonWelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Welcome Back!', style: context.textTheme.headlineSmall),
            SizedBox(height: 8),
            Text(
              'Please log in to your account',
              style: context.textTheme.bodyMedium?.variant(context),
            ),
            SizedBox(height: 16),
            Column(
              spacing: 16,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: context.colors.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: context.colors.outline),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Assets.images.brands.google.image(
                              width: 20,
                              height: 20,
                            ),
                            Text(
                              'Sign in with Google',
                              style: context.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: context.colors.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: context.colors.outline),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Assets.images.brands.apple.image(
                              width: 20,
                              height: 20,
                            ),
                            Text(
                              'Sign in with Apple',
                              style: context.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  spacing: 16,
                  children: [
                    Expanded(child: AppDivider(height: 20)),
                    Text(
                      'Or',
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    Expanded(child: AppDivider(height: 20)),
                  ],
                ),

                AppTextField(
                  hint: 'Enter your email',
                  label: 'Email',
                  isRequired: true,
                  isFilled: false,
                ),

                AppTextField(
                  isFilled: false,
                  prefixIcon: Icon(
                    BetterIcons.squareLock02Outline,
                    size: 20,
                    color: context.colors.onSurfaceVariant,
                  ),
                  hint: 'Enter your password',
                  label: 'Password',
                  isRequired: true,
                  suffixIcon: Icon(
                    BetterIcons.viewOffSlashFilled,
                    size: 20,
                    color: context.colors.onSurfaceVariant,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      spacing: 8,
                      children: [
                        AppCheckbox(value: true),
                        Text(
                          'Remember me',
                          style: context.textTheme.labelLarge,
                        ),
                      ],
                    ),
                    Text(
                      'Forgot password?',
                      style: context.textTheme.labelLarge,
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: AppFilledButton(onPressed: () {}, text: 'Sign in'),
                    ),
                  ],
                ),

                Text.rich(
                  TextSpan(
                    text: 'Don’t have any account? ',
                    style: context.textTheme.labelLarge,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign up',
                        style: context.textTheme.labelLarge?.copyWith(
                          color: context.colors.info,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
