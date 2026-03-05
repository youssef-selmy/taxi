import 'package:auto_route/auto_route.dart';

import 'package:admin_frontend/core/router/app_router.dart';

@AutoRouterConfig()
class AnnouncementRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: AnnouncementShellRoute.page,
      path: 'announcement',
      children: [
        AutoRoute(
          page: AnnouncementListRoute.page,
          path: "list",
          initial: true,
        ),
        AutoRoute(page: CreateAnnouncementRoute.page, path: "create"),
        AutoRoute(
          page: AnnouncementDetailRoute.page,
          path: "view/:announcementId",
        ),
      ],
    ),
  ];
}
