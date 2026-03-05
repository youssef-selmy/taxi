import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_detail/data/graphql/payout_method_detail.graphql.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_detail/data/repositories/payout_method_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: PayoutMethodDetailRepository)
class PayoutMethodDetailRepositoryImpl implements PayoutMethodDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  PayoutMethodDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$payoutMethodDetail>> createPayoutMethod({
    required Input$CreatePayoutMethodInput input,
  }) async {
    final payoutMethodOrError = await graphQLDatasource.mutate(
      Options$Mutation$createPayoutMethod(
        variables: Variables$Mutation$createPayoutMethod(input: input),
      ),
    );
    return payoutMethodOrError.mapData((r) => r.createOnePayoutMethod);
  }

  @override
  Future<ApiResponse<void>> deletePayoutMethod({required String id}) async {
    final deleteResultOrError = await graphQLDatasource.mutate(
      Options$Mutation$deletePayoutMethod(
        variables: Variables$Mutation$deletePayoutMethod(id: id),
      ),
    );
    return deleteResultOrError;
  }

  @override
  Future<ApiResponse<Fragment$payoutMethodDetail>> getPayoutMethod({
    required String id,
  }) async {
    final payoutMethodOrError = await graphQLDatasource.query(
      Options$Query$payoutMethod(
        variables: Variables$Query$payoutMethod(id: id),
      ),
    );
    return payoutMethodOrError.mapData((r) => r.payoutMethod);
  }

  @override
  Future<ApiResponse<Fragment$payoutMethodDetail>> updatePayoutMethod({
    required String id,
    required Input$CreatePayoutMethodInput update,
  }) async {
    final payoutMethodOrError = await graphQLDatasource.mutate(
      Options$Mutation$updatePayoutMethod(
        variables: Variables$Mutation$updatePayoutMethod(
          id: id,
          update: update,
        ),
      ),
    );
    return payoutMethodOrError.mapData((r) => r.updateOnePayoutMethod);
  }
}
