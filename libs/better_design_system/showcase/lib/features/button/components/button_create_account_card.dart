import 'package:better_assets/assets.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class ButtonCreateAccountCard extends StatelessWidget {
  const ButtonCreateAccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIconContainer(context),
            const SizedBox(height: 16),
            Text('Create Your Account', style: context.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Let\'s get started with your 30-day free trial',
              style: context.textTheme.bodyMedium?.variant(context),
            ),
            const SizedBox(height: 32),
            _buildFormContent(context),
          ],
        ),
      ),
    );
  }

  /// Builds the icon container at the top of the card
  Widget _buildIconContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        BetterIcons.allBookmarkFilled,
        size: 24,
        color: context.colors.onSurfaceVariant,
      ),
    );
  }

  /// Builds the main form content including all input fields and buttons
  Widget _buildFormContent(BuildContext context) {
    return Column(
      spacing: 16,
      children: <Widget>[
        _buildNameFields(),
        _buildEmailField(),
        _buildPasswordField(context),
        _buildConfirmPasswordField(context),
        _buildTermsCheckbox(context),
        _buildSignUpButton(),
        _buildLoginLink(context),
        _buildOrDivider(context),
        _buildSocialLoginButtons(context),
      ],
    );
  }

  /// Builds first and last name input fields
  Widget _buildNameFields() {
    return const Row(
      spacing: 16,
      children: [
        Expanded(
          child: AppTextField(
            initialValue: 'Surge',
            label: 'First name',
            isRequired: true,
            readOnly: true,
            isFilled: false,
          ),
        ),
        Expanded(
          child: AppTextField(
            initialValue: 'Bennett',
            label: 'Last name',
            isRequired: true,
            readOnly: true,
            isFilled: false,
          ),
        ),
      ],
    );
  }

  /// Builds email input field
  Widget _buildEmailField() {
    return const AppTextField(
      hint: 'Enter your email',
      label: 'Email',
      isRequired: true,
      isFilled: false,
    );
  }

  /// Builds password input field with lock and visibility icons
  Widget _buildPasswordField(BuildContext context) {
    return AppTextField(
      isFilled: false,
      prefixIcon: _buildLockIcon(context),
      hint: 'Enter your password',
      label: 'Password',
      isRequired: true,
      suffixIcon: _buildVisibilityIcon(context),
    );
  }

  /// Builds confirm password input field with lock and visibility icons
  Widget _buildConfirmPasswordField(BuildContext context) {
    return AppTextField(
      isFilled: false,
      prefixIcon: _buildLockIcon(context),
      hint: 'Confirm your Password',
      label: 'Confirm Password',
      isRequired: true,
      suffixIcon: _buildVisibilityIcon(context),
    );
  }

  /// Builds lock icon for password fields
  Widget _buildLockIcon(BuildContext context) {
    return Icon(
      BetterIcons.squareLock02Outline,
      size: 20,
      color: context.colors.onSurfaceVariant,
    );
  }

  /// Builds visibility toggle icon for password fields
  Widget _buildVisibilityIcon(BuildContext context) {
    return Icon(
      BetterIcons.viewOffSlashFilled,
      size: 20,
      color: context.colors.onSurfaceVariant,
    );
  }

  /// Builds terms and conditions checkbox with text
  Widget _buildTermsCheckbox(BuildContext context) {
    return Row(
      spacing: 8,
      children: <Widget>[
        const AppCheckbox(value: true),
        Text.rich(
          TextSpan(
            text: 'I accepted all ',
            style: context.textTheme.labelLarge,
            children: <TextSpan>[
              TextSpan(
                text: 'terms & conditions.',
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds sign up button
  Widget _buildSignUpButton() {
    return Row(
      children: [
        Expanded(child: AppFilledButton(onPressed: () {}, text: 'Sign up')),
      ],
    );
  }

  /// Builds login link text
  Widget _buildLoginLink(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Already have an account? ',
        style: context.textTheme.labelLarge,
        children: <TextSpan>[
          TextSpan(
            text: 'Login',
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colors.info,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds "Or" divider with lines on both sides
  Widget _buildOrDivider(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        const Expanded(child: AppDivider(height: 20)),
        Text('Or', style: context.textTheme.labelMedium?.variant(context)),
        const Expanded(child: AppDivider(height: 20)),
      ],
    );
  }

  /// Builds social login buttons (Google, Apple, Facebook)
  Widget _buildSocialLoginButtons(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: _buildSocialButton(
            context,
            Assets.images.brands.google.image(width: 20, height: 20),
          ),
        ),
        Expanded(
          child: _buildSocialButton(
            context,
            Assets.images.brands.apple.image(width: 20, height: 20),
          ),
        ),
        Expanded(
          child: _buildSocialButton(
            context,
            Assets.images.brands.facebook.image(width: 20, height: 20),
          ),
        ),
      ],
    );
  }

  /// Builds a single social login button with consistent styling
  Widget _buildSocialButton(BuildContext context, Widget icon) {
    return AppOutlinedButton(
      size: ButtonSize.extraLarge,
      child: icon,
      onPressed: () {},
    );
  }
}
