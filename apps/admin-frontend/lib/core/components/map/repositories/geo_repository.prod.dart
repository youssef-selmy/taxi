import 'package:admin_frontend/core/components/map/search_places.graphql.dart';
import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:generic_map/generic_map.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

import 'package:admin_frontend/core/components/map/repositories/geo_repository.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';

@prod
@LazySingleton(as: GeoRepository)
class GeoRepositoryImpl implements GeoRepository {
  final GraphqlDatasource _graphqlDatasource;

  GeoRepositoryImpl(this._graphqlDatasource);
  @override
  Future<ApiResponse<List<Fragment$Place>>> getPlaces({
    required String query,
    required Input$PointInput? location,
    required String language,
    required MapProviderEnum mapProvider,
  }) async {
    final places = await _graphqlDatasource.query(
      Options$Query$SearchPlaces(
        variables: Variables$Query$SearchPlaces(
          query: query,
          language: language,
          location: location,
        ),
      ),
    );
    return places.mapData((data) => data.getPlaces);
  }

  @override
  Future<ApiResponse<Fragment$Place>> getAddressForLocation({
    required LatLng latLng,
    required String language,
    required MapProviderEnum mapProvider,
  }) async {
    final place = await _graphqlDatasource.query(
      Options$Query$ReverseGeocode(
        variables: Variables$Query$ReverseGeocode(
          lat: latLng.latitude,
          lng: latLng.longitude,
          language: language,
        ),
      ),
    );
    return place.mapData((data) => data.reverseGeocode);
  }
}
