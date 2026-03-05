import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_complaints/data/graphql/parking_order_detail_complaints.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_complaints/data/repositories/parking_order_detail_complaints_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkingOrderDetailComplaintsRepository)
class ParkingOrderDetailComplaintsRepositoryImpl
    implements ParkingOrderDetailComplaintsRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingOrderDetailComplaintsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$getParkingOrderSupportRequest>>
  getParkingOrderDetailCpmplaints({required String parkingOrderId}) async {
    final getParkingOrderComplaints = await graphQLDatasource.query(
      Options$Query$getParkingOrderSupportRequest(
        variables: Variables$Query$getParkingOrderSupportRequest(
          parkingId: Input$IDFilterComparison(eq: parkingOrderId),
        ),
      ),
    );
    return getParkingOrderComplaints;
  }
}
