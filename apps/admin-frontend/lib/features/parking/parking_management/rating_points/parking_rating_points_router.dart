import 'package:auto_route/auto_route.dart';

import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class ParkingRatingPointsRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ParkingRatingPointsShellRoute.page,
      path: 'rating-points',
      children: [
        AutoRoute(
          page: ParkingRatingPointsRoute.page,
          path: 'list',
          initial: true,
        ),
        AutoRoute(
          page: ParkingRatingPointsDetailsRoute.page,
          path: "view/:ratingPointId",
        ),
      ],
    ),
  ];
}
