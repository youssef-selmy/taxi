import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/settings/features/settings_password/presentation/blocs/settings_password.bloc.dart';
import 'package:admin_frontend/features/settings/presentation/components/settings_page_header.dart';

@RoutePage()
class SettingsPasswordScreen extends StatefulWidget {
  const SettingsPasswordScreen({super.key});

  @override
  State<SettingsPasswordScreen> createState() => _SettingsPasswordScreenState();
}

class _SettingsPasswordScreenState extends State<SettingsPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsPasswordBloc(),
      child: BlocBuilder<SettingsPasswordBloc, SettingsPasswordState>(
        builder: (context, state) {
          return Column(
            children: [
              SettingsPageHeader(
                title: context.tr.password,
                actions: [
                  AppFilledButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        context.read<SettingsPasswordBloc>().onUpdatePassword();
                      }
                    },
                    text: context.tr.submit,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LayoutGrid(
                columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
                rowSizes: [auto, auto],
                rowGap: 16,
                columnGap: 16,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppTextField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          maxLines: 1,
                          validator: (p0) => (p0?.isEmpty ?? true)
                              ? context.tr.passwordRequired
                              : null,
                          label: context.tr.previousPassword,
                          hint: context.tr.enterPreviousPassword,
                          onChanged: context
                              .read<SettingsPasswordBloc>()
                              .onPreviousPasswordChanged,
                        ),
                        const SizedBox(height: 8),
                        AppTextField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          maxLines: 1,
                          validator: (p0) => (p0?.isEmpty ?? true)
                              ? context.tr.passwordRequired
                              : null,
                          label: context.tr.password,
                          hint: context.tr.enterNewPassword,
                          onChanged: context
                              .read<SettingsPasswordBloc>()
                              .onPasswordChanged,
                        ),
                        const SizedBox(height: 8),
                        AppTextField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          maxLines: 1,
                          validator: (p0) {
                            if ((p0?.isEmpty ?? true)) {
                              return context.tr.confirmPasswordRequired;
                            }
                            if (p0 != state.password) {
                              return context.tr.passwordsDoNotMatch;
                            }
                            return null;
                          },
                          label: context.tr.confirmPassword,
                          hint: context.tr.confirmNewPassword,
                          onChanged: context
                              .read<SettingsPasswordBloc>()
                              .onConfirmPasswordChanged,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
