import 'package:flutter/material.dart';

import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:admin_frontend/features/configurer/presentation/components/stepper_vertical.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/brand_information_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/confirmation_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/firebase_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/google_maps_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/langugage_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/mysql_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/personal_information_form.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/forms/redis_form.dart';

class ConfigurerScreenDesktop extends StatelessWidget {
  const ConfigurerScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 368,
          decoration: BoxDecoration(
            color: context.colors.surfaceVariant,
            border: Border(
              right: BorderSide(color: context.colors.outline, width: 1.5),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 72),
              BlocBuilder<ConfigurerBloc, ConfigurerState>(
                builder: (context, state) {
                  return StepperVertical(
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
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
            child: Card(
              child: BlocBuilder<ConfigurerBloc, ConfigurerState>(
                builder: (context, state) {
                  return AnimatedSwitcher(
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
                      ConfigurerPage.brandApps => const BrandInformationForm(),
                      ConfigurerPage.googleMaps => const GoogleMapsForm(),
                      ConfigurerPage.mySql => const MySqlForm(),
                      ConfigurerPage.redis => RedisForm(),
                      ConfigurerPage.firebase => const FirebaseForm(),
                      ConfigurerPage.confirmation => const ConfirmationForm(),
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
