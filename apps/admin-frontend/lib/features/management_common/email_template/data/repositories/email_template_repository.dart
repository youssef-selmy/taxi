import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/email_template.graphql.dart';
import 'package:admin_frontend/features/management_common/email_template/data/graphql/email_template.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class EmailTemplateRepository {
  Future<ApiResponse<Query$emailTemplates>> getAll({
    required Input$OffsetPaging? paging,
    required Input$EmailTemplateFilter filter,
    required List<Input$EmailTemplateSort> sort,
  });

  Future<ApiResponse<Fragment$emailTemplateDetails>> getOne({
    required String id,
  });

  Future<ApiResponse<Fragment$emailTemplateDetails>> create({
    required Input$EmailTemplateInput input,
  });

  Future<ApiResponse<Fragment$emailTemplateDetails>> update({
    required String id,
    required Input$EmailTemplateInput input,
  });

  Future<ApiResponse<void>> delete({required String id});
}
