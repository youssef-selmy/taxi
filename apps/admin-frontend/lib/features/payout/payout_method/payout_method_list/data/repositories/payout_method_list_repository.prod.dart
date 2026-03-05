import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_list/data/graphql/payout_method_list.graphql.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_list/data/repositories/payout_method_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: PayoutMethodListRepository)
class PayoutMethodListRepositoryImpl implements PayoutMethodListRepository {
  final GraphqlDatasource graphQLDatasource;

  PayoutMethodListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$payoutMethods$payoutMethods>> getPayoutMethods({
    required Input$OffsetPaging? paging,
    required Input$PayoutMethodFilter filter,
    required List<Input$PayoutMethodSort> sorting,
  }) async {
    final payoutMethodsOrError = await graphQLDatasource.query(
      Options$Query$payoutMethods(
        variables: Variables$Query$payoutMethods(
          paging: paging,
          sorting: sorting,
          filter: filter,
        ),
      ),
    );
    return payoutMethodsOrError.mapData((r) => r.payoutMethods);
  }
}
