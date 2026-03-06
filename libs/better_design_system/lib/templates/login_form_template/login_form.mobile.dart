part of 'login_form.dart';

extension LoginFormMobile on AppLoginForm {
  Widget _buildMobile(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (onBackButtonPressed != null) ...[
              AppIconButton(
                icon: BetterIcons.arrowLeft02Outline,
                onPressed: onBackButtonPressed,
              ),
              const SizedBox(height: 24),
            ],
            if (stepper != null) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: stepper!,
              ),
              const SizedBox(height: 24),
            ],
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null) ...[
                      Text(
                        title!,
                        style: context.textTheme.headlineMedium,
                        textAlign: TextAlign.start,
                      ),
                    ],
                    if (subtitle != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        subtitle!,
                        style: context.textTheme.bodyMedium?.variant(context),
                        textAlign: TextAlign.start,
                      ),
                    ],
                    const SizedBox(height: 32),
                    content,
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            Column(children: _buttonsWidgets),
          ],
        ),
      ),
    );
  }
}
