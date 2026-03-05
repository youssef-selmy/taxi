import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:admin_frontend/features/configurer/presentation/components/stepper_horizontal.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/brand_information_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/confirmation_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/firebase_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/google_maps_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/langugage_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/mysql_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/personal_information_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/redis_form.dart';

class ConfigurerScreenMobile extends StatelessWidget {
  const ConfigurerScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.surfaceVariant,
      child: BlocBuilder<ConfigurerBloc, ConfigurerState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  scrollDirection: Axis.horizontal,
                  child: StepperHorizontal(
                    onStepSelected: (p0) => context
                        .read<ConfigurerBloc>()
                        .goToPage(ConfigurerPage.values[p0]),
                    steps: [
                      ConfigurerPage.language.name,
                      ConfigurerPage.personalName.name,
                      ConfigurerPage.brand.name,
                      ConfigurerPage.googleMaps.name,
                      ConfigurerPage.mySql.name,
                      ConfigurerPage.redis.name,
                      ConfigurerPage.firebase.name,
                      ConfigurerPage.confirmation.name,
                    ],
                    currentStep: state.page.pageIndex,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    border: Border(
                      top: BorderSide(
                        color: context.colors.outline,
                        width: 1.5,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                      child: AnimatedSwitcher(
                        duration: kThemeAnimationDuration,
                        child: switch (state.page) {
                          ConfigurerPage.language => const LangugageForm(),
                          ConfigurerPage.personalNumber =>
                            const PersonalInformationForm(),
                          ConfigurerPage.personalName =>
                            const PersonalInformationForm(),
                          ConfigurerPage.personalPassword =>
                            const PersonalInformationForm(),
                          ConfigurerPage.brand => const BrandInformationForm(),
                          ConfigurerPage.brandCompany =>
                            const BrandInformationForm(),
                          ConfigurerPage.brandApps =>
                            const BrandInformationForm(),
                          ConfigurerPage.googleMaps => const GoogleMapsForm(),
                          ConfigurerPage.mySql => const MySqlForm(),
                          ConfigurerPage.redis => RedisForm(),
                          ConfigurerPage.firebase => const FirebaseForm(),
                          ConfigurerPage.confirmation =>
                            const ConfirmationForm(),
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
