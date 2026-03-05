import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/email_provider.graphql.dart';
import 'package:admin_frontend/features/management_common/email_provider/data/graphql/email_provider.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class EmailProviderRepository {
  Future<ApiResponse<Query$emailProviders>> getAll({
    required Input$OffsetPaging? paging,
    required Input$EmailProviderFilter filter,
    required List<Input$EmailProviderSort> sort,
  });

  Future<ApiResponse<Fragment$emailProviderDetails>> getOne({
    required String id,
  });

  Future<ApiResponse<Fragment$emailProviderDetails>> create({
    required Input$EmailProviderInput input,
  });

  Future<ApiResponse<Fragment$emailProviderDetails>> update({
    required String id,
    required Input$EmailProviderInput input,
  });

  Future<ApiResponse<void>> delete({required String id});

  Future<ApiResponse<Fragment$emailProviderDetails>> markAsDefault({
    required String id,
  });
}
