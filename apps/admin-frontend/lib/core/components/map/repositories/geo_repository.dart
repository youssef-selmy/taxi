import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:generic_map/generic_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';

abstract class GeoRepository {
  Future<ApiResponse<List<Fragment$Place>>> getPlaces({
    required String query,
    required Input$PointInput? location,
    required String language,
    required MapProviderEnum mapProvider,
  });

  Future<ApiResponse<Fragment$Place>> getAddressForLocation({
    required LatLng latLng,
    required String language,
    required MapProviderEnum mapProvider,
  });
}
