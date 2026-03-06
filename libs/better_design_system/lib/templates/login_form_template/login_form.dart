import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
part 'login_form.desktop.dart';
part 'login_form.mobile.dart';

typedef BetterLoginForm = AppLoginForm;

class AppLoginForm extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget content;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final Widget? stepper;
  final VoidCallback? onBackButtonPressed;
  final bool? isDesktop;
  final String? logoTypeAssetPath;
  final String? logoTypeAssetPathLight;
  final String? logoTypeAssetPathDark;

  const AppLoginForm({
    super.key,
    this.title,
    this.subtitle,
    this.stepper,
    required this.content,
    this.primaryButton,
    this.secondaryButton,
    this.isDesktop,
    this.onBackButtonPressed,
    @Deprecated('Use logoTypeAssetPathLight and logoTypeAssetPathDark instead')
    this.logoTypeAssetPath,
    this.logoTypeAssetPathLight,
    this.logoTypeAssetPathDark,
  });

  @override
  Widget build(BuildContext context) {
    return (isDesktop ?? context.isDesktop)
        ? _buildDesktop(context)
        : _buildMobile(context);
  }

  List<Widget> get _buttonsWidgets {
    return [
      if (primaryButton != null)
        SizedBox(width: double.infinity, child: primaryButton!),
      if (secondaryButton != null) ...[
        const SizedBox(height: 16),
        SizedBox(width: double.infinity, child: secondaryButton!),
      ],
    ];
  }
}
