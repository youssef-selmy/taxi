import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class TextInputLoginCard extends StatefulWidget {
  const TextInputLoginCard({super.key});

  @override
  State<TextInputLoginCard> createState() => _TextInputLoginCardState();
}

class _TextInputLoginCardState extends State<TextInputLoginCard> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.surfaceVariant,
              ),
              child: Center(
                child: Assets.images.iconsTwotone.userCircle.svg(
                  width: 40,
                  height: 40,
                  colorFilter: ColorFilter.mode(
                    context.colors.onSurfaceVariant,
                    BlendMode.srcIn,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Login', style: context.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Enter your information to login',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              spacing: 16,
              children: [
                AppTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  isFilled: false,
                  prefixIcon: Icon(
                    BetterIcons.mail02Outline,
                    color: context.colors.onSurfaceVariant,
                    size: 20,
                  ),
                ),
                AppTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  obscureText: _obscurePassword,
                  isFilled: false,
                  prefixIcon: Icon(
                    BetterIcons.squareLock02Outline,
                    color: context.colors.onSurfaceVariant,
                    size: 20,
                  ),
                  suffixIcon: AppIconButton(
                    icon: BetterIcons.eyeOutline,
                    iconSelected: BetterIcons.eyeFilled,
                    isSelected: !_obscurePassword,
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    size: ButtonSize.medium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppLinkButton(
                  onPressed: () {},
                  text: 'Forgot Password?',
                  alwaysUnderline: true,
                  color: SemanticColor.neutral,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: AppFilledButton(
                  onPressed: () {},
                  text: 'Login',
                  size: ButtonSize.extraLarge,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: context.textTheme.labelLarge!.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                AppLinkButton(onPressed: () {}, text: 'Sign up'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
