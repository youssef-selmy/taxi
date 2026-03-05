import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:better_localization/localizations.dart';
import 'package:admin_frontend/config/env.dart';
import 'package:better_design_system/atoms/banner/banner.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/login/presentation/blocs/login.cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Form(
          key: state.formKey,
          child: AutofillGroup(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTextField(
                  isFilled: true,
                  isRequired: true,
                  initialValue: state.email,
                  onChanged: bloc.emailChanged,
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                  validator: (value) => (value?.isEmpty ?? true)
                      ? context.tr.emailRequired
                      : null,
                  label: context.tr.userName,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  isFilled: true,
                  isRequired: true,
                  initialValue: state.password,
                  autofillHints: const [AutofillHints.password],
                  validator: (p0) => (p0?.isEmpty ?? true)
                      ? context.tr.passwordRequired
                      : null,
                  obscureText: true,
                  onChanged: bloc.passwordChanged,
                  label: context.tr.password,
                ),
                const SizedBox(height: 32),
                if (Env.isDemoMode) ...[
                  AppBanner(
                    type: BannerType.info,
                    title: context.tr.demoModeLoginInstruction,
                  ),
                  const SizedBox(height: 16),
                ],
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, stateAuth) {
                    return AppFilledButton(
                      text: context.tr.login,
                      isLoading:
                          stateAuth.unauthenticated?.loginResponse.isLoading ??
                          false,
                      isDisabled:
                          stateAuth.unauthenticated?.loginResponse.isLoading ??
                          false,
                      onPressed: () {
                        if (state.formKey.currentState!.validate()) {
                          locator<AuthBloc>().add(
                            AuthEvent.login(state.email, state.password),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
