import 'package:flutter/material.dart';

import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/components/atoms/copyright_notice/copyright_notice.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/login/presentation/components/login_form.dart';
import 'package:admin_frontend/gen/assets.gen.dart';

class LoginScreenMobile extends StatelessWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Assets.images.companyLogo.image(
              width: 64,
              height: 64,
              isAntiAlias: true,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(height: 16),
            Text(
              context.tr.welcomeHeader(Env.appName),
              style: context.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              context.tr.pleaseEnterYourLoginCredentials,
              style: context.textTheme.bodyMedium?.variant(context),
            ),
            LoginForm(),
            Spacer(),
            CopyrightNotice(),
          ],
        ),
      ),
    );
  }
}
