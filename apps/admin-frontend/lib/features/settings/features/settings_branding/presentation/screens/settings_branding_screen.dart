import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/settings/presentation/components/settings_page_header.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/components/organisms/apps_branding_information_form/apps_branding_information_form.dart';
import 'package:admin_frontend/features/settings/features/settings_branding/presentation/blocs/settings_branding.bloc.dart';
import 'package:better_localization/localizations.dart';

@RoutePage()
class SettingsBrandingScreen extends StatelessWidget {
  const SettingsBrandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SettingsBrandingBloc()
            ..onStarted(locator<ConfigBloc>().state.config.data),
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, stateConfig) {
          return BlocBuilder<SettingsBrandingBloc, SettingsBrandingState>(
            builder: (context, state) {
              return Column(
                children: [
                  SettingsPageHeader(
                    title: context.tr.brandingDetails,
                    actions: [
                      AppFilledButton(
                        text: context.tr.saveChanges,
                        onPressed: () =>
                            context.read<SettingsBrandingBloc>().onSubmitted(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppsBrandingInformationForm(
                            taxiEnabled: stateConfig.taxiEnabled,
                            shopEnabled: stateConfig.shopEnabled,
                            parkingEnabled: stateConfig.parkingEnabled,
                            taxiLogo: state.taxiLogo,
                            taxiName: state.taxiName,
                            taxiColorPalette: state.taxiColorPalette,
                            shopLogo: state.shopLogo,
                            shopName: state.shopName,
                            shopColorPalette: state.shopColorPalette,
                            parkingLogo: state.parkingLogo,
                            parkingName: state.parkingName,
                            parkingColorPalette: state.parkingColorPalette,
                            onTaxiLogoChanged: context
                                .read<SettingsBrandingBloc>()
                                .onTaxiLogoChanged,
                            onTaxiNameChanged: context
                                .read<SettingsBrandingBloc>()
                                .onTaxiNameChanged,
                            onTaxiColorPaletteChanged: context
                                .read<SettingsBrandingBloc>()
                                .onTaxiColorPaletteChanged,
                            onShopLogoChanged: context
                                .read<SettingsBrandingBloc>()
                                .onShopLogoChanged,
                            onShopNameChanged: context
                                .read<SettingsBrandingBloc>()
                                .onShopNameChanged,
                            onShopColorPaletteChanged: context
                                .read<SettingsBrandingBloc>()
                                .onShopColorPaletteChanged,
                            onParkingLogoChanged: context
                                .read<SettingsBrandingBloc>()
                                .onParkingLogoChanged,
                            onParkingNameChanged: context
                                .read<SettingsBrandingBloc>()
                                .onParkingNameChanged,
                            onParkingColorPaletteChanged: context
                                .read<SettingsBrandingBloc>()
                                .onParkingColorPaletteChanged,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
