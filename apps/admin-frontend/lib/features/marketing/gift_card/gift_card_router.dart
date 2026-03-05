import 'package:auto_route/auto_route.dart';

import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class GiftCardRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: GiftCardShellRoute.page,
      path: 'gift-card',
      children: [
        RedirectRoute(path: "", redirectTo: "list"),
        AutoRoute(page: GiftCardListRoute.page, path: "list"),
        AutoRoute(page: CreateGiftBatchRoute.page, path: "create"),
        AutoRoute(page: GiftCardDetailsRoute.page, path: "view/:giftCardId"),
      ],
    ),
  ];
}
