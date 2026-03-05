import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/data/graphql/cancel_reason_insights.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/data/repositories/cancel_reason_insights_repository.dart';

@prod
@LazySingleton(as: CancelReasonInsightsRepository)
class CancelReasonInsightsRepositoryImpl
    implements CancelReasonInsightsRepository {
  final GraphqlDatasource graphQLDatasource;

  CancelReasonInsightsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$cancelReasonInsights>>
  getCancelReasonInsights() async {
    final insights = await graphQLDatasource.query(
      Options$Query$cancelReasonInsights(),
    );
    return insights;
  }
}
