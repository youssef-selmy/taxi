import 'package:auto_route/auto_route.dart';

import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class CouponRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: CouponShellRoute.page,
      path: 'coupon',
      children: [
        AutoRoute(page: CampaignListRoute.page, path: "list", initial: true),
        AutoRoute(page: CampaignDetailsRoute.page, path: "view/:campaignId"),
        AutoRoute(page: CreateCampaignRoute.page, path: "create"),
      ],
    ),
  ];
}
