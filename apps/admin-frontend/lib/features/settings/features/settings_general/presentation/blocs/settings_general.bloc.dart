import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/profile.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/repositories/profile_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'settings_general.state.dart';
part 'settings_general.bloc.freezed.dart';

class SettingsGeneralBloc extends Cubit<SettingsGeneralState> {
  final ProfileRepository _profileRepository = locator<ProfileRepository>();

  SettingsGeneralBloc() : super(const SettingsGeneralState());

  void onStarted() {
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    emit(state.copyWith(profileState: const ApiResponseLoading()));
    final profileOrError = await _profileRepository.getProfile();
    emit(
      state.copyWith(
        profileState: profileOrError,
        firstName: profileOrError.data?.firstName,
        lastName: profileOrError.data?.lastName,
        email: profileOrError.data?.email,
        mobileNumber: profileOrError.data?.mobileNumber,
        userName: profileOrError.data?.userName,
        profilePicture: profileOrError.data?.media,
      ),
    );
  }

  void onLastNameChanged(String p1) {
    emit(state.copyWith(lastName: p1));
  }

  void onFirstNameChanged(String p1) {
    emit(state.copyWith(firstName: p1));
  }

  void onUserNameChanged(String p1) {
    emit(state.copyWith(userName: p1));
  }

  void onEmailChanged(String p1) {
    emit(state.copyWith(email: p1));
  }

  void onMobileNumberChanged((String, String?)? p1) {
    emit(state.copyWith(mobileNumber: p1?.$2));
  }

  void onProfilePictureChanged(Fragment$Media? media) {
    emit(state.copyWith(profilePicture: media));
  }

  Future<void> onSubmit() async {
    _profileRepository.updateProfile(input: state.toUpdateProfileInput);
  }
}
