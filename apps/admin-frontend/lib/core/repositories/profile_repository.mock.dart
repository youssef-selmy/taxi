import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/profile.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/profile.mock.dart';
import 'package:admin_frontend/core/repositories/profile_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:rxdart/rxdart.dart';
import 'package:admin_frontend/core/graphql/fragments/token.fragment.graphql.dart';

@dev
@LazySingleton(as: ProfileRepository)
class ProfileRepositoryMock implements ProfileRepository {
  @override
  Stream<ApiResponse<Fragment$profile>> get profileStream =>
      _profileStream.stream;

  final BehaviorSubject<ApiResponse<Fragment$profile>> _profileStream =
      BehaviorSubject<ApiResponse<Fragment$profile>>();

  @override
  Stream<ApiResponse<List<String>>> get supportedCurrenciesStream =>
      _supportedCurrenciesStream.stream;

  final BehaviorSubject<ApiResponse<List<String>>> _supportedCurrenciesStream =
      BehaviorSubject<ApiResponse<List<String>>>();

  @override
  Future<ApiResponse<Fragment$profile>> getProfile() async {
    _profileStream.add(ApiResponse.loading());
    await Future.delayed(const Duration(milliseconds: 500));
    _profileStream.add(ApiResponse.loaded(mockProfile));
    return ApiResponse.loaded(mockProfile);
  }

  @override
  Future<ApiResponse<List<String>>> getSupportedCurrencies() async {
    _supportedCurrenciesStream.add(ApiResponse.loading());
    await Future.delayed(const Duration(milliseconds: 500));
    _supportedCurrenciesStream.add(
      const ApiResponse.loaded(['USD', 'EUR', 'GBP']),
    );
    return const ApiResponse.loaded(['USD', 'EUR', 'GBP']);
  }

  @override
  Future<ApiResponse<Fragment$profile>> updateProfile({
    required Input$UpdateProfileInput input,
  }) async {
    final newProfile = mockProfile.copyWith(
      firstName: input.firstName ?? mockProfile.firstName,
      lastName: input.lastName ?? mockProfile.lastName,
      email: input.email ?? mockProfile.email,
      mobileNumber: input.mobileNumber ?? mockProfile.mobileNumber,
      userName: input.userName ?? mockProfile.userName,
    );
    _profileStream.add(ApiResponse.loading());
    await Future.delayed(const Duration(milliseconds: 500));
    _profileStream.add(ApiResponse.loaded(newProfile));
    return ApiResponse.loaded(newProfile);
  }

  @override
  Future<ApiResponse<Fragment$token>> login({
    required String email,
    required String password,
  }) async {
    return ApiResponse.loaded(
      Fragment$token(accessToken: '', refreshToken: ''),
    );
  }

  @override
  Future<ApiResponse<String>> refreshToken({
    required String refreshToken,
  }) async {
    return const ApiResponse.loaded('newJwtToken');
  }
}
