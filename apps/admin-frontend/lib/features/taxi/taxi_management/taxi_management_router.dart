import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class TaxiManagementRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: TaxiManagementRoute.page,
      path: "management-taxi",
      children: [
        AutoRoute(
          page: CancelReaonParentRoute.page,
          path: "cancel-reasons",
          children: [
            AutoRoute(
              page: CancelReasonRoute.page,
              path: "list",
              initial: true,
            ),
            AutoRoute(
              page: CancelReasonDetailRoute.page,
              path: "view/:cancelReasonId",
            ),
          ],
        ),
        AutoRoute(
          page: TaxiRatingPointsParentRoute.page,
          path: 'taxi-rating-points',
          children: [
            AutoRoute(
              page: TaxiRatingPointsRoute.page,
              path: "list",
              initial: true,
            ),
            AutoRoute(
              page: TaxiRatingPointsDetailsRoute.page,
              path: "view/:ratingPointId",
            ),
          ],
        ),
        AutoRoute(
          page: VehiclesShellRoute.page,
          path: "vehicles",
          children: [
            AutoRoute(page: VehicleListRoute.page, path: "list", initial: true),
            AutoRoute(
              page: VehicleModelDetailsRoute.page,
              path: "model/:modelId",
            ),
            AutoRoute(
              page: VehicleColorDetailsRoute.page,
              path: "color/:colorId",
            ),
          ],
        ),
        AutoRoute(
          page: PricingParentRoute.page,
          path: "pricing",
          children: [
            AutoRoute(page: PricingRoute.page, path: "list", initial: true),
            AutoRoute(page: PricingDetailsRoute.page, path: "view/:pricingId"),
            AutoRoute(
              page: PricingCategoryDetailsRoute.page,
              path: "category/:pricingCategoryId",
            ),
            AutoRoute(
              page: ZonePriceCategoryDetailsRoute.page,
              path: "zone-overrides-category/:zonePriceCategoryId",
            ),
            AutoRoute(
              page: ZonePriceDetailsRoute.page,
              path: "zone-overrides/:zonePriceId",
            ),
          ],
        ),
      ],
    ),
  ];

  static List<NavigationSubItem<PageRouteInfo>> navigationItems(
    BuildContext context,
  ) {
    return [
      NavigationSubItem(
        title: context.tr.cancelReasons,
        value: CancelReaonParentRoute(),
      ),
      NavigationSubItem(title: context.tr.pricing, value: PricingParentRoute()),
      NavigationSubItem(
        title: context.tr.ratingPoints,
        value: TaxiRatingPointsParentRoute(),
      ),
      NavigationSubItem(
        title: context.tr.vehicles,
        value: VehiclesShellRoute(),
      ),
    ];
  }
}
