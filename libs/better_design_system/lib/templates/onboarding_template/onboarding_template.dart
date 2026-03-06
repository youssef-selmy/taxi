import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterOnboardingTemplate = AppOnboardingTemplate;

class AppOnboardingTemplate extends StatelessWidget {
  final String backgroundImageAssetPath;
  final String? logoImageAssetPath;
  final String? logoTypeAssetPathLight;
  final String? logoTypeAssetPathDark;
  final String title;
  final String subtitle;
  final Function()? onGetStarted;
  final Function()? onSkip;
  final Widget? customWidget;

  const AppOnboardingTemplate({
    super.key,
    required this.backgroundImageAssetPath,
    @Deprecated('Use logoTypeAssetPathLight and logoTypeAssetPathDark instead')
    this.logoImageAssetPath,
    this.logoTypeAssetPathLight,
    this.logoTypeAssetPathDark,
    required this.title,
    required this.subtitle,
    this.onGetStarted,
    this.onSkip,
    this.customWidget,
  });

  @override
  Widget build(BuildContext context) {
    return context.isDesktop ? _buildDesktop(context) : _buildMobile(context);
  }

  Widget _buildDesktop(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.colors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                _getLogoTypeAssetPath(context),
                width: 190,
                height: 32,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 48),
              Text(
                title,
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.variant(context),
              ),
              const SizedBox(height: 48),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 415),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: AppFilledButton(
                        onPressed: onGetStarted,
                        text: context.strings.letsGetStarted,
                      ),
                    ),
                    if (customWidget != null) ...[
                      const SizedBox(height: 8),
                      SizedBox(width: double.infinity, child: customWidget!),
                    ],
                    if (onSkip != null) ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: AppTextButton(
                          onPressed: onSkip,
                          text: context.strings.skipForNow,
                          color: SemanticColor.primary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImageAssetPath),
          filterQuality: FilterQuality.high,
          isAntiAlias: true,
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 16,
              right: 16,
              left: 16,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withAlpha(0),
                  context.colors.surface,
                  context.colors.surface,
                ],
                stops: const [0.0, 0.4, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 250),
                  Text(title, style: context.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: context.textTheme.bodyMedium?.variant(context),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: AppFilledButton(
                      onPressed: onGetStarted,
                      text: context.strings.letsGetStarted,
                    ),
                  ),
                  if (customWidget != null) ...[
                    const SizedBox(height: 8),
                    SizedBox(width: double.infinity, child: customWidget!),
                  ],
                  if (onSkip != null) ...[
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: AppTextButton(
                        onPressed: onSkip,
                        text: context.strings.skipForNow,
                        color: SemanticColor.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getLogoTypeAssetPath(BuildContext context) {
    if (context.isDark) {
      return logoTypeAssetPathDark ?? logoImageAssetPath ?? '';
    }
    return logoTypeAssetPathLight ?? logoImageAssetPath ?? '';
  }
}
