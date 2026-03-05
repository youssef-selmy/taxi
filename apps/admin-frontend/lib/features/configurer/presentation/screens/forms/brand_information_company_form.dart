import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:better_localization/localizations.dart';

class BrandInformationCompanyForm extends StatefulWidget {
  const BrandInformationCompanyForm({super.key});

  @override
  State<BrandInformationCompanyForm> createState() =>
      _BrandInformationCompanyFormState();
}

class _BrandInformationCompanyFormState
    extends State<BrandInformationCompanyForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocBuilder<ConfigurerBloc, ConfigurerState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    UploadFieldSmall(
                      title: context.tr.companyLogo,
                      initialValue: state.companyLogo,
                      onChanged: (value) {
                        context.read<ConfigurerBloc>().onCompanyLogoChanged(
                          value,
                        );
                      },
                      validator: (p0) => p0 == null
                          ? context.tr.pleaseUploadCompanyLogo
                          : null,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: context.tr.companyName,
                      initialValue: state.companyName,
                      onChanged: (value) {
                        context.read<ConfigurerBloc>().onCompanyNameChanged(
                          value,
                        );
                      },
                      isFilled: true,
                      validator: (p0) => (p0?.isEmpty ?? true)
                          ? context.tr.pleaseEnterCompanyName
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: AppFilledButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ConfigurerBloc>().goToPage(
                        ConfigurerPage.brandApps,
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
    );
  }
}
