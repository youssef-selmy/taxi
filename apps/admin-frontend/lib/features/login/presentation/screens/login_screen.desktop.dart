import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/onboarding/onboarding.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/login/presentation/components/login_form.dart';
import 'package:admin_frontend/gen/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenDesktop extends StatelessWidget {
  const LoginScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            color: context.colors.surfaceVariant,
            height: double.infinity,
            child: const Column(children: [Spacer(), Onboarding(), Spacer()]),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Spacer(),
              SizedBox(
                width: 450,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<ConfigBloc, ConfigState>(
                      builder: (context, state) {
                        if (state.config.data?.config?.companyLogo != null) {
                          return CachedNetworkImage(
                            imageUrl: state.config.data!.config!.companyLogo!,
                            width: 80,
                            height: 80,
                            filterQuality: FilterQuality.high,
                          );
                        } else {
                          return Assets.images.companyLogo.image(
                            width: 80,
                            height: 80,
                            isAntiAlias: true,
                            filterQuality: FilterQuality.high,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                    Text(
                      context.tr.welcomeHeader(Env.appName),
                      style: context.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.tr.pleaseEnterYourLoginCredentials,
                      style: context.textTheme.bodyMedium?.variant(context),
                    ),
                    const SizedBox(height: 32),
                    LoginForm(),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
