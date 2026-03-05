import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_complaints/data/graphql/taxi_order_detail_complaints.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_complaints/data/repositories/taxi_order_detail_complaints_repository.dart';

@prod
@LazySingleton(as: TaxiOrderDetailComplaintsRepository)
class TaxiOrderDetailComplaintsRepositoryImpl
    implements TaxiOrderDetailComplaintsRepository {
  final GraphqlDatasource graphQLDatasource;

  TaxiOrderDetailComplaintsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$taxiOrderSupportRequests>> getTaxiOrderComplaints({
    required String id,
  }) async {
    final getTaxiOrderComplaints = await graphQLDatasource.query(
      Options$Query$taxiOrderSupportRequests(
        variables: Variables$Query$taxiOrderSupportRequests(orderId: id),
      ),
    );
    return getTaxiOrderComplaints;
  }
}
