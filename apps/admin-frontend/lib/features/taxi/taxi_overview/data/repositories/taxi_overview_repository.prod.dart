import 'dart:async';

import 'package:admin_frontend/core/graphql/fragments/driver_location.fragment.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/data/graphql/taxi_overview.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/data/repositories/taxi_overview_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:rxdart/rxdart.dart';

@prod
@LazySingleton(as: TaxiOverviewRepository)
class TaxiOverviewRepositoryImpl implements TaxiOverviewRepository {
  final BehaviorSubject<ApiResponse<List<Fragment$LocationCluster>>>
  _onlineDriversClustersController =
      BehaviorSubject<ApiResponse<List<Fragment$LocationCluster>>>();

  @override
  Stream<ApiResponse<List<Fragment$LocationCluster>>>
  get onlineDriversClusters => _onlineDriversClustersController.stream;

  final BehaviorSubject<ApiResponse<List<Fragment$LocationWithId>>>
  _singleOnlineDriversController =
      BehaviorSubject<ApiResponse<List<Fragment$LocationWithId>>>();

  @override
  Stream<ApiResponse<List<Fragment$LocationWithId>>> get singleOnlineDrivers =>
      _singleOnlineDriversController.stream;

  StreamSubscription<Subscription$driverLocationClusters>?
  _onlineDriverClustersSubscription;

  StreamSubscription<Subscription$driverLocationUpdate>?
  _singleOnlineDriversSubscription;

  @override
  void startSubscribingToDriverClusters({
    required List<String> h3Indexes,
    required int h3Resolution,
  }) {
    _onlineDriverClustersSubscription?.cancel();
    final subscription = graphQLDatasource.subscribe(
      Options$Subscription$driverLocationClusters(
        fetchPolicy: FetchPolicy.noCache,
        variables: Variables$Subscription$driverLocationClusters(
          h3Indexes: h3Indexes,
          h3Resolution: h3Resolution,
        ),
      ),
    );
    _onlineDriverClustersSubscription = subscription.listen((event) {
      final clusters = event.driverLocationClusterUpdate;
      final currentData =
          _onlineDriversClustersController.valueOrNull?.data ??
          <Fragment$LocationCluster>[];

      // Create a map of current clusters by h3Index for efficient lookup
      final currentClustersMap = <String, Fragment$LocationCluster>{
        for (final cluster in currentData) cluster.h3Index: cluster,
      };

      // Update clusters with deltas
      final updatedClusters = <Fragment$LocationCluster>[];
      for (final deltaCluster in clusters) {
        final existingCluster = currentClustersMap[deltaCluster.h3Index];
        if (existingCluster != null) {
          // Update existing cluster with new count
          updatedClusters.add(deltaCluster);
          currentClustersMap.remove(deltaCluster.h3Index);
        } else {
          // Add new cluster
          updatedClusters.add(deltaCluster);
        }
      }

      // Add remaining unchanged clusters
      updatedClusters.addAll(currentClustersMap.values);

      _onlineDriversClustersController.add(ApiResponse.loaded(updatedClusters));
    });
  }

  @override
  void stopSubscribingToDriverClusters() {
    _onlineDriverClustersSubscription?.cancel();
    _onlineDriverClustersSubscription = null;
  }

  final GraphqlDatasource graphQLDatasource;

  TaxiOverviewRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$overviewKPIs>> getKPIs({
    required String currency,
  }) async {
    final kpisOrError = await graphQLDatasource.query(
      Options$Query$overviewKPIs(
        variables: Variables$Query$overviewKPIs(currency: currency),
      ),
    );
    return kpisOrError;
  }

  @override
  Future<ApiResponse<Query$onlineDrivers>> getOnlineDrivers({
    required Input$BoundsInput bounds,
  }) async {
    final onlineDriversOrError = await graphQLDatasource.query(
      Options$Query$onlineDrivers(
        variables: Variables$Query$onlineDrivers(
          bounds: bounds,
          center: Input$PointInput(
            lat: (bounds.northEast.lat + bounds.southWest.lat) / 2,
            lng: (bounds.northEast.lng + bounds.southWest.lng) / 2,
          ),
        ),
      ),
    );
    final clusters =
        onlineDriversOrError.data?.driverLocationsByViewport.clusters ?? [];
    final singles =
        onlineDriversOrError.data?.driverLocationsByViewport.singles ?? [];
    _onlineDriversClustersController.add(ApiResponse.loaded(clusters));
    _singleOnlineDriversController.add(ApiResponse.loaded(singles));
    return onlineDriversOrError;
  }

  @override
  Future<ApiResponse<Query$pendingDrivers>> getPendingDrivers() async {
    final pendingDriversOrError = await graphQLDatasource.query(
      Options$Query$pendingDrivers(),
    );
    return pendingDriversOrError;
  }

  @override
  Future<ApiResponse<Query$pendingSupportRequests>>
  getPendingSupportRequets() async {
    final pendingSupportRequestsOrError = await graphQLDatasource.query(
      Options$Query$pendingSupportRequests(),
    );
    return pendingSupportRequestsOrError;
  }

  @override
  Future<ApiResponse<List<Fragment$leaderboardItem>>> getTopEarningDrivers({
    required String currency,
  }) async {
    final topEarningDriversOrError = await graphQLDatasource.query(
      Options$Query$topEarningDrivers(
        variables: Variables$Query$topEarningDrivers(currency: currency),
      ),
    );
    return topEarningDriversOrError.mapData((r) => r.topEarningDrivers);
  }

  @override
  Future<ApiResponse<List<Fragment$leaderboardItem>>>
  getTopSpendingCustomers() async {
    final topSpendingCustomersOrError = await graphQLDatasource.query(
      Options$Query$topSpendingCustomers(),
    );
    return topSpendingCustomersOrError.mapData((r) => r.topSpendingCustomers);
  }

  @override
  void startSubscribingToDriverLocations({required List<String> driverIds}) {
    if (driverIds.isEmpty) {
      _singleOnlineDriversController.add(ApiResponse.loaded([]));
      return;
    }
    final subscription = graphQLDatasource.subscribe(
      Options$Subscription$driverLocationUpdate(
        fetchPolicy: FetchPolicy.noCache,
        variables: Variables$Subscription$driverLocationUpdate(
          driverIds: driverIds,
        ),
      ),
    );
    _singleOnlineDriversSubscription?.cancel();
    _singleOnlineDriversSubscription = subscription.listen((event) {
      final newLocation = event.driverLocationUpdated;
      // this is the delta. apply the new location to the existing list
      final currentData =
          _singleOnlineDriversController.value.data ??
          <Fragment$LocationWithId>[];
      final newData = currentData.map((location) {
        return location.driverId == newLocation.driverId
            ? newLocation
            : location; // replace the location with the new one if it exists
      }).toList();
      _singleOnlineDriversController.add(ApiResponse.loaded(newData));
    });
  }

  @override
  void stopSubscribingToDriverLocations() {
    _singleOnlineDriversSubscription?.cancel();
    _singleOnlineDriversSubscription = null;
  }
}
