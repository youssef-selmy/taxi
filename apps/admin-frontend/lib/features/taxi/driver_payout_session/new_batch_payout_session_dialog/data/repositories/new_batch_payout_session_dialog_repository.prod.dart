import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/new_batch_payout_session_dialog/data/graphql/new_batch_payout_session_dialog.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/new_batch_payout_session_dialog/data/repositories/new_batch_payout_session_dialog_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: NewBatchPayoutSessionDialogRepository)
class NewBatchPayoutSessionDialogRepositoryImpl
    implements NewBatchPayoutSessionDialogRepository {
  final GraphqlDatasource graphQLDatasource;

  NewBatchPayoutSessionDialogRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$payoutMethods>> getPayoutMethods() async {
    final payoutMethodsOrError = await graphQLDatasource.query(
      Options$Query$payoutMethods(),
    );
    return payoutMethodsOrError;
  }

  @override
  Future<ApiResponse<void>> createBatchPayoutSession({
    required Input$CreatePayoutSessionInput input,
  }) async {
    final createPayoutSessionResultOrError = await graphQLDatasource.mutate(
      Options$Mutation$createBatchPayoutSession(
        variables: Variables$Mutation$createBatchPayoutSession(input: input),
      ),
    );
    return createPayoutSessionResultOrError;
  }
}
