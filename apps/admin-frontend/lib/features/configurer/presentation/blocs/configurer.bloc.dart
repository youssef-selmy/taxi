import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/repositories/config_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_localization/localizations.dart';

part 'configurer.state.dart';
part 'configurer.bloc.freezed.dart';

class ConfigurerBloc extends HydratedCubit<ConfigurerState> {
  final ConfigRepository _licenseRepository = locator<ConfigRepository>();
  ConfigurerBloc() : super(ConfigurerState.initial());

  void goToPage(ConfigurerPage page) => emit(state.copyWith(page: page));

  void onPhoneNumberChanged((String, String?)? value) {
    emit(
      state.copyWith(
        phoneNumber: (
          value?.$1 ?? Env.defaultCountry.iso2CountryCode,
          value?.$2 ?? "",
        ),
      ),
    );
  }

  void onPasswordChanged(String p0) {
    emit(state.copyWith(password: p0));
  }

  @override
  ConfigurerState? fromJson(Map<String, dynamic> json) =>
      ConfigurerState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ConfigurerState state) => state.toJson();

  void onCompanyNameChanged(String value) =>
      emit(state.copyWith(companyName: value));

  void onCompanyLogoChanged(Fragment$Media? value) =>
      emit(state.copyWith(companyLogo: value));

  void onProfilePictureChanged(Fragment$Media? value) =>
      emit(state.copyWith(profilePicture: value));

  void onEmailChanged(String value) => emit(state.copyWith(email: value));

  void onFirstNameChanged(String value) =>
      emit(state.copyWith(firstName: value));

  void onLastNameChanged(String value) => emit(state.copyWith(lastName: value));

  void onGoogleMapsAdminPanelApiKeyChanged(String value) =>
      emit(state.copyWith(googleMapsAdminPanelApiKey: value));

  void onGoogleMapsBackendApiKeyChanged(String value) =>
      emit(state.copyWith(googleMapsBackendApiKey: value));

  void onFirebaseApiKeyChanged(String filePath) {
    final fileName = filePath.split('/').last;

    emit(state.copyWith(firebaseApiKey: fileName));
  }

  void onPasswordSet(String value) => emit(state.copyWith(password: value));

  void onMySqlHostChanged(String value) =>
      emit(state.copyWith(mySqlHost: value));

  void onMySqlPortChanged(int value) => emit(state.copyWith(mySqlPort: value));

  void onMySqlDatabaseChanged(String value) =>
      emit(state.copyWith(mySqlDatabase: value));

  void onMySqlUsernameChanged(String value) =>
      emit(state.copyWith(mySqlUser: value));

  void onMySqlPasswordChanged(String value) =>
      emit(state.copyWith(mySqlPassword: value));

  void onRedisHostChanged(String value) =>
      emit(state.copyWith(redisHost: value));

  void onRedisPortChanged(int? value) =>
      emit(state.copyWith(redisPort: value ?? 0));

  void onRedisPasswordChanged(String value) =>
      emit(state.copyWith(redisPassword: value));

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

  Future<void> updateConfig() async {
    await _licenseRepository.updateConfig(input: state.toConfigInput);
  }
}
