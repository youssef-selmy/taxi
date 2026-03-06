import 'package:better_assets/assets.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

export 'package:better_design_system/colors/semantic_color.dart';

typedef BetterFeaturePromotionDialogTemplate =
    AppFeaturePromotionDialogTemplate;

/// A data class representing a single feature promotion item.
///
/// Each item displays an icon with a title and optional subtitle,
/// used to highlight key benefits or features in a promotion dialog.
class FeaturePromotionItem {
  /// The icon displayed for this feature.
  final SvgGenImage icon;

  /// The title text describing the feature.
  final String title;

  /// Optional subtitle providing additional context.
  final String? subtitle;

  /// The semantic color for the icon.
  /// Defaults to [SemanticColor.primary].
  final SemanticColor iconColor;

  const FeaturePromotionItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconColor = SemanticColor.primary,
  });
}

/// A dialog template for promoting features with a centered header icon,
/// title, subtitle, and a list of feature items with icons.
///
/// This template is designed for use cases like:
/// - Passkey/biometric setup prompts
/// - New feature introductions
/// - Upgrade promotions
/// - Onboarding feature highlights
///
/// Example:
/// ```dart
/// AppFeaturePromotionDialogTemplate(
///   headerIcon: BetterIcons.fingerprint,
///   headerIconColor: SemanticColor.success,
///   title: 'Set up passkey',
///   subtitle: 'Login with fingerprint, face or passcode',
///   features: [
///     FeaturePromotionItem(
///       icon: BetterIcons.shield,
///       title: 'Next level security',
///     ),
///     FeaturePromotionItem(
///       icon: BetterIcons.lightning,
///       title: 'Quick and seamless login',
///     ),
///   ],
///   primaryButton: AppFilledButton(
///     text: 'Set Up Passkey',
///     onPressed: () => setupPasskey(),
///   ),
///   secondaryButton: AppTextButton(
///     text: 'Skip for now',
///     onPressed: () => Navigator.pop(context),
///   ),
/// )
/// ```
class AppFeaturePromotionDialogTemplate extends StatelessWidget {
  /// The icon displayed in the dialog header.
  final IconData? headerIcon;

  /// The semantic color for the header icon.
  /// Defaults to [SemanticColor.primary].
  final SemanticColor headerIconColor;

  /// The style of the header icon.
  /// Defaults to [DialogHeaderIconStyle.expanded] for a prominent circular background.
  final DialogHeaderIconStyle headerIconStyle;

  /// The title text displayed below the header icon.
  final String title;

  /// Optional subtitle text displayed below the title.
  final String? subtitle;

  /// List of features to display with icons and descriptions.
  final List<FeaturePromotionItem> features;

  /// The primary action button (e.g., "Set Up Passkey").
  final Widget primaryButton;

  /// Optional secondary action button (e.g., "Skip for now").
  final Widget? secondaryButton;

  /// Callback when the close button is pressed.
  /// If null, no close button is shown.
  final VoidCallback? onClosePressed;

  /// The dialog type for mobile devices.
  /// Defaults to [DialogType.fullScreenBottomSheet].
  final DialogType defaultDialogType;

  /// The dialog type for desktop devices.
  /// Defaults to [DialogType.dialog].
  final DialogType desktopDialogType;

  const AppFeaturePromotionDialogTemplate({
    super.key,
    this.headerIcon,
    this.headerIconColor = SemanticColor.primary,
    this.headerIconStyle = DialogHeaderIconStyle.expanded,
    required this.title,
    this.subtitle,
    required this.features,
    required this.primaryButton,
    this.secondaryButton,
    this.onClosePressed,
    this.defaultDialogType = DialogType.fullScreenBottomSheet,
    this.desktopDialogType = DialogType.dialog,
  });

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      defaultDialogType: defaultDialogType,
      desktopDialogType: desktopDialogType,
      title: title,
      subtitle: subtitle,
      icon: headerIcon,
      iconColor: headerIconColor,
      iconStyle: headerIconStyle,
      alignment: DialogHeaderAlignment.center,
      desktopAlignment: DialogHeaderAlignment.center,
      onClosePressed: onClosePressed,
      primaryButton: primaryButton,
      secondaryButton: secondaryButton,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: _buildFeaturesList(context),
    );
  }

  Widget _buildFeaturesList(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: features
          .map((item) => _buildFeatureItem(context, item))
          .toList(),
    );
  }

  Widget _buildFeatureItem(BuildContext context, FeaturePromotionItem item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        item.icon.svg(
          width: 32,
          height: 32,
          colorFilter: ColorFilter.mode(
            context.colors.primary,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: context.textTheme.titleSmall),
              if (item.subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  item.subtitle!,
                  style: context.textTheme.bodyMedium?.variant(context),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
