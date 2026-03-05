import 'package:better_design_system/organisms/phone_number_field/phone_number_field.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:better_localization/localizations.dart';

class PersonalInformationPhoneNumberForm extends StatefulWidget {
  const PersonalInformationPhoneNumberForm({super.key});

  @override
  State<PersonalInformationPhoneNumberForm> createState() =>
      _PersonalInformationPhoneNumberFormState();
}

class _PersonalInformationPhoneNumberFormState
    extends State<PersonalInformationPhoneNumberForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurerBloc, ConfigurerState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                width: 500,
                child: AppPhoneNumberField(
                  label: context.tr.enterPhoneNumber,
                  initialValue: state.phoneNumber,
                  onChanged: (value) => context
                      .read<ConfigurerBloc>()
                      .onPhoneNumberChanged(value),
                  validator: (p0) => (p0?.$2?.isEmpty ?? true)
                      ? context.tr.pleaseEnterValidPhoneNumber
                      : null,
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
                        ConfigurerPage.personalName,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
