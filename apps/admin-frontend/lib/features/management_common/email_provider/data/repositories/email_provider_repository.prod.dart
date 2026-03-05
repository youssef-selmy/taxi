import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/email_provider.graphql.dart';
import 'package:admin_frontend/features/management_common/email_provider/data/graphql/email_provider.graphql.dart';
import 'package:admin_frontend/features/management_common/email_provider/data/repositories/email_provider_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: EmailProviderRepository)
class EmailProviderRepositoryImpl implements EmailProviderRepository {
  final GraphqlDatasource graphQLDatasource;

  EmailProviderRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$emailProviderDetails>> create({
    required Input$EmailProviderInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$createEmailProvider(
        variables: Variables$Mutation$createEmailProvider(input: input),
      ),
    );
    return result.mapData((r) => r.createOneEmailProvider);
  }

  @override
  Future<ApiResponse<Query$emailProviders>> getAll({
    required Input$OffsetPaging? paging,
    required Input$EmailProviderFilter filter,
    required List<Input$EmailProviderSort> sort,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$emailProviders(
        variables: Variables$Query$emailProviders(
          paging: paging,
          filter: filter,
          sorting: sort,
        ),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Fragment$emailProviderDetails>> getOne({
    required String id,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$emailProvider(
        variables: Variables$Query$emailProvider(id: id),
      ),
    );
    return result.mapData((r) => r.emailProvider);
  }

  @override
  Future<ApiResponse<Fragment$emailProviderDetails>> update({
    required String id,
    required Input$EmailProviderInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$updateEmailProvider(
        variables: Variables$Mutation$updateEmailProvider(id: id, input: input),
      ),
    );
    return result.mapData((r) => r.updateOneEmailProvider);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$deleteEmailProvider(
        variables: Variables$Mutation$deleteEmailProvider(id: id),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Fragment$emailProviderDetails>> markAsDefault({
    required String id,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$markEmailProviderAsDefault(
        variables: Variables$Mutation$markEmailProviderAsDefault(id: id),
      ),
    );
    return result.mapData((r) => r.markEmailProviderAsDefault);
  }
}
