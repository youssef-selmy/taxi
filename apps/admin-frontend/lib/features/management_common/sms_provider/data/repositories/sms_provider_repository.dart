import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/sms_provider.graphql.dart';
import 'package:admin_frontend/features/management_common/sms_provider/data/graphql/sms_provider.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class SmsProviderRepository {
  Future<ApiResponse<Query$smsProviders>> getAll({
    required Input$OffsetPaging? paging,
    required Input$SMSProviderFilter filter,
    required List<Input$SMSProviderSort> sort,
  });

  Future<ApiResponse<Fragment$smsProviderDetails>> getOne({required String id});

  Future<ApiResponse<Fragment$smsProviderDetails>> create({
    required Input$SMSProviderInput input,
  });

  Future<ApiResponse<Fragment$smsProviderDetails>> update({
    required String id,
    required Input$SMSProviderInput input,
  });

  Future<ApiResponse<void>> delete({required String id});

  Future<ApiResponse<Fragment$smsProviderDetails>> markAsDefault({
    required String id,
  });
}
