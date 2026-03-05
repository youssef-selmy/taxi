import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/sms_provider.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/sms_provider.graphql.mock.dart';
import 'package:admin_frontend/features/management_common/sms_provider/data/graphql/sms_provider.graphql.dart';
import 'package:admin_frontend/features/management_common/sms_provider/data/repositories/sms_provider_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: SmsProviderRepository)
class SmsProviderRepositoryMock implements SmsProviderRepository {
  @override
  Future<ApiResponse<Fragment$smsProviderDetails>> create({
    required Input$SMSProviderInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockSmsProviderDetails);
  }

  @override
  Future<ApiResponse<Query$smsProviders>> getAll({
    required Input$OffsetPaging? paging,
    required Input$SMSProviderFilter filter,
    required List<Input$SMSProviderSort> sort,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$smsProviders(
        smsProviders: Query$smsProviders$smsProviders(
          nodes: mockSmsProviderList,
          pageInfo: mockPageInfo,
          totalCount: mockSmsProviderList.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$smsProviderDetails>> getOne({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockSmsProviderDetails);
  }

  @override
  Future<ApiResponse<Fragment$smsProviderDetails>> update({
    required String id,
    required Input$SMSProviderInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockSmsProviderDetails);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<Fragment$smsProviderDetails>> markAsDefault({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockSmsProviderDetails);
  }
}
