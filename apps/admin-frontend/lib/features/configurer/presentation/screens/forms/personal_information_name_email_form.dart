import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:better_localization/localizations.dart';

class PersonalInformationNameEmailForm extends StatefulWidget {
  const PersonalInformationNameEmailForm({super.key});

  @override
  State<PersonalInformationNameEmailForm> createState() =>
      _PersonalInformationNameEmailFormState();
}

class _PersonalInformationNameEmailFormState
    extends State<PersonalInformationNameEmailForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurerBloc, ConfigurerState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    children: [
                      UploadFieldSmall(
                        initialValue: state.profilePicture,
                        title: context.tr.profilePicture,
                        onChanged: (value) {
                          context
                              .read<ConfigurerBloc>()
                              .onProfilePictureChanged(value);
                        },
                        validator: (p0) => p0 == null
                            ? context.tr.pleaseUploadValidProfilePicture
                            : null,
                      ),
                      AppTextField(
                        label: context.tr.firstName,
                        initialValue: state.firstName,
                        onChanged: (value) {
                          context.read<ConfigurerBloc>().onFirstNameChanged(
                            value,
                          );
                        },
                        validator: (p0) => (p0?.isEmpty ?? true)
                            ? context.tr.pleaseEnterValidFirstName
                            : null,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: context.tr.lastName,
                        initialValue: state.lastName,
                        onChanged: (value) {
                          context.read<ConfigurerBloc>().onLastNameChanged(
                            value,
                          );
                        },
                        validator: (p0) => (p0?.isEmpty ?? true)
                            ? context.tr.pleaseEnterValidLastName
                            : null,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: context.tr.email,
                        keyboardType: TextInputType.emailAddress,
                        initialValue: state.email,
                        onChanged: (value) {
                          context.read<ConfigurerBloc>().onEmailChanged(value);
                        },
                        validator: (p0) => (p0?.isEmpty ?? true)
                            ? context.tr.pleaseEnterValidEmail
                            : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppFilledButton(
                    text: context.tr.next,
                    suffixIcon: BetterIcons.arrowRight02Outline,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<ConfigurerBloc>().goToPage(
                          ConfigurerPage.personalPassword,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
