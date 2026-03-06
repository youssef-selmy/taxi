part of 'login_form.dart';

extension LoginFormDesktop on AppLoginForm {
  Widget _buildDesktop(BuildContext context) {
    final logoPath = _getLogoTypeAssetPath(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              if (logoPath != null)
                Positioned(
                  left: 100,
                  right: 100,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Image.asset(
                      logoPath,
                      width: 150,
                      height: 32,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              if (onBackButtonPressed != null)
                AppIconButton(
                  icon: BetterIcons.arrowLeft02Outline,
                  onPressed: onBackButtonPressed,
                ),
              if (onBackButtonPressed == null) const SizedBox(height: 32),
            ],
          ),
          const SizedBox(height: 48),
          if (stepper != null) ...[stepper!, const SizedBox(height: 32)],
          if (title != null)
            Text(
              title!,
              style: context.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: context.textTheme.bodyMedium?.variant(context),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 16),
          content,
          const SizedBox(height: 48),
          ..._buttonsWidgets,
        ],
      ),
    );
  }

  String? _getLogoTypeAssetPath(BuildContext context) {
    if (context.isDark) {
      return logoTypeAssetPathDark ?? logoTypeAssetPath;
    }
    return logoTypeAssetPathLight ?? logoTypeAssetPath;
  }
}
