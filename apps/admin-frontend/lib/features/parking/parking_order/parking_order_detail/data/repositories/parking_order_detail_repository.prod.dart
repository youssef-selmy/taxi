import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/data/graphql/parking_order_detail.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/data/repositories/parking_order_detail_repository.dart';

@prod
@LazySingleton(as: ParkingOrderDetailRepository)
class ParkingOrderDetailRepositoryImpl implements ParkingOrderDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingOrderDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$parkingOrderDetail>> getParkingOrderDetail({
    required String id,
  }) async {
    final getParkingOrderDetail = await graphQLDatasource.query(
      Options$Query$parkingOrderDetail(
        variables: Variables$Query$parkingOrderDetail(id: id),
      ),
    );
    return getParkingOrderDetail.mapData((f) => f.parkOrder);
  }
}
