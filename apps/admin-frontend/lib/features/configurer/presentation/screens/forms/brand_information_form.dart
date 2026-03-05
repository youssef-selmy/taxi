import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/components/atoms/button/back_button.dart';
import 'package:admin_frontend/core/components/stepper_dots/stepper_dots.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:admin_frontend/features/configurer/presentation/components/form_container.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/brand_information_apps_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/brand_information_company_form.dart';

class BrandInformationForm extends StatefulWidget {
  const BrandInformationForm({super.key});

  @override
  State<BrandInformationForm> createState() => _BrandInformationFormState();
}

class _BrandInformationFormState extends State<BrandInformationForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormContainer(
        child: BlocBuilder<ConfigBloc, ConfigState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppBackButton(
                    onPressed: () {
                      switch (context.read<ConfigurerBloc>().state.page) {
                        case ConfigurerPage.brandCompany:
                          context.read<ConfigurerBloc>().goToPage(
                            ConfigurerPage.personalNumber,
                          );
                          break;
                        case ConfigurerPage.brandApps:
                          context.read<ConfigurerBloc>().goToPage(
                            ConfigurerPage.brandCompany,
                          );
                          break;
                        default:
                          context.read<ConfigurerBloc>().goToPage(
                            ConfigurerPage.personalNumber,
                          );
                          break;
                      }
                    },
                  ),
                ),
                Text(
                  context.tr.brandingInformation,
                  style: context.textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    context.tr.pleaseEnterBrandingInformation,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                BlocBuilder<ConfigurerBloc, ConfigurerState>(
                  builder: (context, state) {
                    return AppStepperDots(
                      activeIndex: state.page == ConfigurerPage.brandCompany
                          ? 0
                          : 1,
                      count: 2,
                    );
                  },
                ),
                const SizedBox(height: 40),
                AnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  child: BlocBuilder<ConfigurerBloc, ConfigurerState>(
                    builder: (context, state) {
                      return switch (state.page) {
                        ConfigurerPage.brandCompany =>
                          const BrandInformationCompanyForm(),
                        ConfigurerPage.brandApps => BrandInformationAppsForm(),
                        _ => Text(context.tr.pageNotFound),
                      };
                    },
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
