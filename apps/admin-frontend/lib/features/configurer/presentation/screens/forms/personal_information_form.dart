import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/atoms/button/back_button.dart';
import 'package:admin_frontend/core/components/stepper_dots/stepper_dots.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:admin_frontend/features/configurer/presentation/components/form_container.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/personal_information_name_email_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/personal_information_password_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/personal_information_phone_number_form.dart';

class PersonalInformationForm extends StatelessWidget {
  const PersonalInformationForm({super.key});
  @override
  Widget build(BuildContext context) {
    return FormContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AppBackButton(
              onPressed: () {
                switch (context.read<ConfigurerBloc>().state.page) {
                  case ConfigurerPage.personalNumber:
                    context.read<ConfigurerBloc>().goToPage(
                      ConfigurerPage.language,
                    );
                    break;
                  case ConfigurerPage.personalName:
                    context.read<ConfigurerBloc>().goToPage(
                      ConfigurerPage.personalNumber,
                    );
                    break;
                  case ConfigurerPage.personalPassword:
                    context.read<ConfigurerBloc>().goToPage(
                      ConfigurerPage.personalName,
                    );
                    break;
                  default:
                    context.read<ConfigurerBloc>().goToPage(
                      ConfigurerPage.language,
                    );
                    break;
                }
              },
            ),
          ),
          Text(
            context.tr.personalInformation,
            style: context.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            context.tr.pleaseEnterPersonalInformation,
            style: context.textTheme.bodyMedium?.variant(context),
          ),
          const SizedBox(height: 24),
          BlocBuilder<ConfigurerBloc, ConfigurerState>(
            builder: (context, state) {
              return AppStepperDots(
                activeIndex: state.page == ConfigurerPage.personalNumber
                    ? 0
                    : (state.page == ConfigurerPage.personalName ? 1 : 2),
                count: 3,
              );
            },
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: BlocBuilder<ConfigurerBloc, ConfigurerState>(
                  builder: (context, state) {
                    return switch (state.page) {
                      ConfigurerPage.personalNumber =>
                        const PersonalInformationPhoneNumberForm(),
                      ConfigurerPage.personalName =>
                        const PersonalInformationNameEmailForm(),
                      ConfigurerPage.personalPassword =>
                        const PersonalInformationPasswordForm(),
                      _ => Text(context.tr.pageNotFound),
                    };
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
