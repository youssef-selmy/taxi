import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/email_template.graphql.dart';
import 'package:admin_frontend/features/management_common/email_template/data/graphql/email_template.graphql.dart';
import 'package:admin_frontend/features/management_common/email_template/data/repositories/email_template_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: EmailTemplateRepository)
class EmailTemplateRepositoryImpl implements EmailTemplateRepository {
  final GraphqlDatasource graphQLDatasource;

  EmailTemplateRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$emailTemplateDetails>> create({
    required Input$EmailTemplateInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$createEmailTemplate(
        variables: Variables$Mutation$createEmailTemplate(input: input),
      ),
    );
    return result.mapData((r) => r.createOneEmailTemplate);
  }

  @override
  Future<ApiResponse<Query$emailTemplates>> getAll({
    required Input$OffsetPaging? paging,
    required Input$EmailTemplateFilter filter,
    required List<Input$EmailTemplateSort> sort,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$emailTemplates(
        variables: Variables$Query$emailTemplates(
          paging: paging,
          filter: filter,
          sorting: sort,
        ),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Fragment$emailTemplateDetails>> getOne({
    required String id,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$emailTemplate(
        variables: Variables$Query$emailTemplate(id: id),
      ),
    );
    return result.mapData((r) => r.emailTemplate);
  }

  @override
  Future<ApiResponse<Fragment$emailTemplateDetails>> update({
    required String id,
    required Input$EmailTemplateInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$updateEmailTemplate(
        variables: Variables$Mutation$updateEmailTemplate(id: id, input: input),
      ),
    );
    return result.mapData((r) => r.updateOneEmailTemplate);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$deleteEmailTemplate(
        variables: Variables$Mutation$deleteEmailTemplate(id: id),
      ),
    );
    return result;
  }
}
