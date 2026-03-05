import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:better_design_system/atoms/input_fields/base_components/password_strength.dart';
import 'package:better_localization/localizations.dart';

class PersonalInformationPasswordForm extends StatefulWidget {
  const PersonalInformationPasswordForm({super.key});

  @override
  State<PersonalInformationPasswordForm> createState() =>
      _PersonalInformationPasswordFormState();
}

class _PersonalInformationPasswordFormState
    extends State<PersonalInformationPasswordForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocBuilder<ConfigurerBloc, ConfigurerState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    children: [
                      AppTextField(
                        initialValue: state.password,
                        label: context.tr.password,
                        validator: (p0) => (p0?.isEmpty ?? true)
                            ? context.tr.pleaseEnterValidPassword
                            : null,
                        onChanged: (p0) => context
                            .read<ConfigurerBloc>()
                            .onPasswordChanged(p0),
                      ),
                      const SizedBox(height: 4),
                      BlocBuilder<ConfigurerBloc, ConfigurerState>(
                        builder: (context, state) {
                          return AppPasswordStrength(
                            password: state.password,
                            confirmPassword: state.password,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: AppFilledButton(
                  isDisabled: state.password.length < 8,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ConfigurerBloc>().goToPage(
                        ConfigurerPage.brandCompany,
                      );
                    }
                  },
                  text: context.tr.next,
                  suffixIcon: Icons.arrow_forward,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
