import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/atoms/button/back_button.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:admin_frontend/features/configurer/presentation/components/form_container.dart';

class GoogleMapsForm extends StatefulWidget {
  const GoogleMapsForm({super.key});

  @override
  State<GoogleMapsForm> createState() => _GoogleMapsFormState();
}

class _GoogleMapsFormState extends State<GoogleMapsForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      child: Form(
        key: formKey,
        child: BlocBuilder<ConfigurerBloc, ConfigurerState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppBackButton(
                        onPressed: () {
                          context.read<ConfigurerBloc>().goToPage(
                            ConfigurerPage.brandCompany,
                          );
                        },
                      ),
                    ),
                    Text(
                      "Google Maps API Key",
                      style: context.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        "Please enter Google Maps API Keys",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    AppTextField(
                      constraints: const BoxConstraints(maxWidth: 500),
                      initialValue: state.googleMapsAdminPanelApiKey,
                      onChanged: (value) {
                        context
                            .read<ConfigurerBloc>()
                            .onGoogleMapsAdminPanelApiKeyChanged(value);
                      },
                      validator: (p0) => (p0?.isEmpty ?? true)
                          ? context.tr.pleaseEnterGoogleMapsApiKey
                          : null,
                      isFilled: true,
                    ),
                    const SizedBox(height: 24),
                    AppTextField(
                      constraints: const BoxConstraints(maxWidth: 500),
                      initialValue: state.googleMapsBackendApiKey,
                      onChanged: (value) {
                        context
                            .read<ConfigurerBloc>()
                            .onGoogleMapsBackendApiKeyChanged(value);
                      },
                      validator: (p0) => (p0?.isEmpty ?? true)
                          ? context.tr.pleaseEnterGoogleMapsApiKey
                          : null,
                      isFilled: true,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppFilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<ConfigurerBloc>().goToPage(
                          ConfigurerPage.mySql,
                        );
                      }
                    },
                    text: context.tr.next,
                    suffixIcon: BetterIcons.arrowRight02Outline,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
