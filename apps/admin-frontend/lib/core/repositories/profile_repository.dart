import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/profile.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/token.fragment.graphql.dart';

abstract class ProfileRepository {
  Stream<ApiResponse<Fragment$profile>> get profileStream;
  Stream<ApiResponse<List<String>>> get supportedCurrenciesStream;

  Future<ApiResponse<Fragment$token>> login({
    required String email,
    required String password,
  });
  Future<ApiResponse<String>> refreshToken({required String refreshToken});
  Future<ApiResponse<Fragment$profile>> getProfile();

  Future<ApiResponse<Fragment$profile>> updateProfile({
    required Input$UpdateProfileInput input,
  });

  Future<ApiResponse<List<String>>> getSupportedCurrencies();
}
