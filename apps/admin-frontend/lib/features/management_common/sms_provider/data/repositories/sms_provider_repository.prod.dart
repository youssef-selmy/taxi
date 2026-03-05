import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/sms_provider.graphql.dart';
import 'package:admin_frontend/features/management_common/sms_provider/data/graphql/sms_provider.graphql.dart';
import 'package:admin_frontend/features/management_common/sms_provider/data/repositories/sms_provider_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: SmsProviderRepository)
class SmsProviderRepositoryImpl implements SmsProviderRepository {
  final GraphqlDatasource graphQLDatasource;

  SmsProviderRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$smsProviderDetails>> create({
    required Input$SMSProviderInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$createSMSProvider(
        variables: Variables$Mutation$createSMSProvider(input: input),
      ),
    );
    return result.mapData((r) => r.createOneSMSProvider);
  }

  @override
  Future<ApiResponse<Query$smsProviders>> getAll({
    required Input$OffsetPaging? paging,
    required Input$SMSProviderFilter filter,
    required List<Input$SMSProviderSort> sort,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$smsProviders(
        variables: Variables$Query$smsProviders(
          paging: paging,
          filter: filter,
          sorting: sort,
        ),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Fragment$smsProviderDetails>> getOne({
    required String id,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$smsProvider(variables: Variables$Query$smsProvider(id: id)),
    );
    return result.mapData((r) => r.smsProvider);
  }

  @override
  Future<ApiResponse<Fragment$smsProviderDetails>> update({
    required String id,
    required Input$SMSProviderInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$updateSMSProvider(
        variables: Variables$Mutation$updateSMSProvider(id: id, input: input),
      ),
    );
    return result.mapData((r) => r.updateOneSMSProvider);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$deleteSMSProvider(
        variables: Variables$Mutation$deleteSMSProvider(id: id),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Fragment$smsProviderDetails>> markAsDefault({
    required String id,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$markSMSProviderAsDefault(
        variables: Variables$Mutation$markSMSProviderAsDefault(id: id),
      ),
    );
    return result.mapData((r) => r.markSMSProviderAsDefault);
  }
}
