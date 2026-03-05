import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:generic_map/generic_map.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

import 'package:admin_frontend/core/components/map/repositories/geo_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';

@dev
@LazySingleton(as: GeoRepository)
class GeoRepositoryMock implements GeoRepository {
  @override
  Future<ApiResponse<List<Fragment$Place>>> getPlaces({
    required String query,
    required Input$PointInput? location,
    required String language,
    required MapProviderEnum mapProvider,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return ApiResponse.loaded([
      Fragment$Place(
        title: "Place 1",
        address: "Address 1",
        point: Fragment$Coordinate(lat: 37.789, lng: -122.369),
      ),
      Fragment$Place(
        title: "Place 2",
        address: "Address 2",
        point: Fragment$Coordinate(lat: 37.789, lng: -122.289),
      ),
    ]);
  }

  @override
  Future<ApiResponse<Fragment$Place>> getAddressForLocation({
    required LatLng latLng,
    required String language,
    required MapProviderEnum mapProvider,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return ApiResponse.loaded(
      Fragment$Place(
        title: "Location",
        address: "123 Main Street, Anytown, USA",
        point: Fragment$Coordinate(lat: latLng.latitude, lng: latLng.longitude),
      ),
    );
  }
}
