import 'package:auto_route/auto_route.dart';

import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class ShopCategoriesRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: ShopCategoriesShellRoute.page,
      path: 'shop-categories',
      children: [
        AutoRoute(page: ShopCategoryListRoute.page, path: '', initial: true),
        AutoRoute(
          page: ShopCategoryDetailRoute.page,
          path: 'detail/:shopCategoryId',
        ),
      ],
    ),
  ];
}
