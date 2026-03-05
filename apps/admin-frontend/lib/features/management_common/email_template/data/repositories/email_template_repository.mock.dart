import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/email_template.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/email_template.graphql.mock.dart';
import 'package:admin_frontend/features/management_common/email_template/data/graphql/email_template.graphql.dart';
import 'package:admin_frontend/features/management_common/email_template/data/repositories/email_template_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: EmailTemplateRepository)
class EmailTemplateRepositoryMock implements EmailTemplateRepository {
  @override
  Future<ApiResponse<Fragment$emailTemplateDetails>> create({
    required Input$EmailTemplateInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockEmailTemplateDetails);
  }

  @override
  Future<ApiResponse<Query$emailTemplates>> getAll({
    required Input$OffsetPaging? paging,
    required Input$EmailTemplateFilter filter,
    required List<Input$EmailTemplateSort> sort,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$emailTemplates(
        emailTemplates: Query$emailTemplates$emailTemplates(
          nodes: mockEmailTemplateList,
          pageInfo: mockPageInfo,
          totalCount: mockEmailTemplateList.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$emailTemplateDetails>> getOne({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockEmailTemplateDetails);
  }

  @override
  Future<ApiResponse<Fragment$emailTemplateDetails>> update({
    required String id,
    required Input$EmailTemplateInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockEmailTemplateDetails);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded(null);
  }
}
