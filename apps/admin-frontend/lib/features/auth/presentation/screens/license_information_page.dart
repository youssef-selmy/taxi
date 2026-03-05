import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/alert_bar.dart';
import 'package:admin_frontend/core/components/organisms/license_information_card/available_upgrades_card.dart';
import 'package:admin_frontend/core/components/organisms/license_information_card/license_information_card.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/config.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/auth/presentation/blocs/auth.bloc.dart';

part 'license_information_page.mobile.dart';
part 'license_information_page.desktop.dart';

@RoutePage()
class LicenseInformationPage extends StatelessWidget {
  const LicenseInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<AuthBloc>(),
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return switch (state.activateServerResponse) {
              ApiResponseLoading() => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              ApiResponseInitial() => AppEmptyState(
                title: "License Key Not Activated",
                image: Assets.images.emptyStates.error,
              ),
              ApiResponseLoaded(:final data) => context.responsive(
                LicenseInformationPageMobile(
                  data: data.updatePurchaseCode.data!,
                ),
                lg: LicenseInformationPageDesktop(
                  data: data.updatePurchaseCode.data!,
                ),
              ),
              ApiResponseError(:final errorMessage) => AppEmptyState(
                title: errorMessage ?? context.tr.somethingWentWrong,
                image: Assets.images.emptyStates.error,
              ),
            };
          },
        ),
      ),
    );
  }
}
