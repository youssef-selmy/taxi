import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/navigation_item.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_localization/localizations.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/marketing/announcement/announcement_router.dart';
import 'package:admin_frontend/features/marketing/coupon/coupon_router.dart';
import 'package:admin_frontend/features/marketing/gift_card/gift_card_router.dart';

@AutoRouterConfig()
class MarketingRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MarketingShellRoute.page,
      path: 'marketing',
      children: [
        ...CouponRouter().routes,
        ...GiftCardRouter().routes,
        ...AnnouncementRouter().routes,
      ],
    ),
  ];

  static NavigationItem<PageRouteInfo> navigationItem(BuildContext context) {
    return NavigationItem(
      title: context.tr.marketing,
      value: MarketingShellRoute(),
      icon: (BetterIcons.pieChart09Outline, BetterIcons.pieChart09Filled),
      subItems: [
        NavigationSubItem(title: context.tr.coupons, value: CouponShellRoute()),
        NavigationSubItem(
          title: context.tr.giftCards,
          value: GiftCardShellRoute(),
        ),
        NavigationSubItem(
          title: context.tr.announcements,
          value: AnnouncementShellRoute(),
        ),
      ],
    );
  }
}
