import 'package:admin_frontend/core/graphql/fragments/config.fragment.graphql.dart';
import 'package:admin_frontend/core/repositories/config_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'settings_branding.state.dart';
part 'settings_branding.bloc.freezed.dart';

class SettingsBrandingBloc extends Cubit<SettingsBrandingState> {
  final ConfigRepository _configRepository = locator<ConfigRepository>();

  SettingsBrandingBloc() : super(const SettingsBrandingState());

  void onStarted(Fragment$Config? config) {
    emit(
      state.copyWith(
        taxiLogo: config?.config?.taxi?.logo == null
            ? null
            : Fragment$Media(id: "1", address: config!.config!.taxi!.logo!),
        taxiName: config?.config?.taxi?.name,
        taxiColorPalette: config?.config?.taxi?.color,
        shopLogo: config?.config?.shop?.logo == null
            ? null
            : Fragment$Media(id: "1", address: config!.config!.shop!.logo!),
        shopName: config?.config?.shop?.name,
        shopColorPalette: config?.config?.shop?.color,
        parkingLogo: config?.config?.parking?.logo == null
            ? null
            : Fragment$Media(id: "1", address: config!.config!.parking!.logo!),
        parkingName: config?.config?.parking?.name,
        parkingColorPalette: config?.config?.parking?.color,
      ),
    );
  }

  void onTaxiLogoChanged(Fragment$Media? value) =>
      emit(state.copyWith(taxiLogo: value));

  void onTaxiNameChanged(String? value) =>
      emit(state.copyWith(taxiName: value ?? ''));

  void onTaxiColorPaletteChanged(Enum$AppColorScheme? value) =>
      emit(state.copyWith(taxiColorPalette: value));

  void onShopLogoChanged(Fragment$Media? value) =>
      emit(state.copyWith(shopLogo: value));

  void onShopNameChanged(String? value) =>
      emit(state.copyWith(shopName: value ?? ''));

  void onShopColorPaletteChanged(Enum$AppColorScheme? value) =>
      emit(state.copyWith(shopColorPalette: value));

  void onParkingLogoChanged(Fragment$Media? value) =>
      emit(state.copyWith(parkingLogo: value));

  void onParkingNameChanged(String? value) =>
      emit(state.copyWith(parkingName: value ?? ''));

  void onParkingColorPaletteChanged(Enum$AppColorScheme? value) =>
      emit(state.copyWith(parkingColorPalette: value));

  void onSubmitted() {
    _configRepository.updateConfig(
      input: Input$UpdateConfigInputV2(
        taxi: Input$AppConfigInfoInput(
          logo: state.taxiLogo?.address,
          name: state.taxiName ?? "-",
          color: state.taxiColorPalette,
        ),
        shop: Input$AppConfigInfoInput(
          logo: state.shopLogo?.address,
          name: state.shopName ?? "-",
          color: state.shopColorPalette,
        ),
        parking: Input$AppConfigInfoInput(
          logo: state.parkingLogo?.address,
          name: state.parkingName ?? "-",
          color: state.parkingColorPalette,
        ),
      ),
    );
  }
}
