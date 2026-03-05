import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/components/organisms/apps_branding_information_form/apps_branding_information_form.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:better_icons/better_icons.dart';

class BrandInformationAppsForm extends StatelessWidget {
  BrandInformationAppsForm({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, stateConfig) {
        return Form(
          key: formKey,
          child: BlocBuilder<ConfigurerBloc, ConfigurerState>(
            builder: (context, state) {
              return Column(
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
                        .read<ConfigurerBloc>()
                        .onTaxiLogoChanged,
                    onTaxiNameChanged: context
                        .read<ConfigurerBloc>()
                        .onTaxiNameChanged,
                    onTaxiColorPaletteChanged: context
                        .read<ConfigurerBloc>()
                        .onTaxiColorPaletteChanged,
                    onShopLogoChanged: context
                        .read<ConfigurerBloc>()
                        .onShopLogoChanged,
                    onShopNameChanged: context
                        .read<ConfigurerBloc>()
                        .onShopNameChanged,
                    onShopColorPaletteChanged: context
                        .read<ConfigurerBloc>()
                        .onShopColorPaletteChanged,
                    onParkingLogoChanged: context
                        .read<ConfigurerBloc>()
                        .onParkingLogoChanged,
                    onParkingNameChanged: context
                        .read<ConfigurerBloc>()
                        .onParkingNameChanged,
                    onParkingColorPaletteChanged: context
                        .read<ConfigurerBloc>()
                        .onParkingColorPaletteChanged,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppFilledButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<ConfigurerBloc>().goToPage(
                            ConfigurerPage.googleMaps,
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
      },
    );
  }
}
