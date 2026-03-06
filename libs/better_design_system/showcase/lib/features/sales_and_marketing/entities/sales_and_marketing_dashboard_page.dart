import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

enum SalesAndMarketingDashboardGroup { groupA, groupB }

enum SalesAndMarketingDashboardPage {
  dashboard,
  salesOverview,
  crmOverview,
  waitingList,
  reports,
  products,
  calendar,
  overview,
  analytics,
  product,
  sales,
  payment,
  refunds,
  invoices,
  support,
  setting,
}

class SalesAndMarketingDashboardPageConfig {
  final SalesAndMarketingDashboardPage page;
  final SalesAndMarketingDashboardGroup group;
  final String title;
  final (IconData outline, IconData filled) icon;

  const SalesAndMarketingDashboardPageConfig({
    required this.page,
    required this.group,
    required this.title,
    required this.icon,
  });
}

final groupAPages = <SalesAndMarketingDashboardPageConfig>[
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.dashboard,
    group: SalesAndMarketingDashboardGroup.groupA,
    title: 'Dashboard',
    icon: (
      BetterIcons.dashboardSquare01Outline,
      BetterIcons.dashboardSquare01Filled,
    ),
  ),
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.salesOverview,
    group: SalesAndMarketingDashboardGroup.groupA,
    title: 'Sales Overview',
    icon: (BetterIcons.arrowUpDownOutline, BetterIcons.arrowUpDownFilled),
  ),
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.crmOverview,
    group: SalesAndMarketingDashboardGroup.groupA,
    title: 'CRM Overview',
    icon: (BetterIcons.userCircle02Outline, BetterIcons.userCircle02Filled),
  ),
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.waitingList,
    group: SalesAndMarketingDashboardGroup.groupA,
    title: 'Waiting List',
    icon: (BetterIcons.userGroup02Outline, BetterIcons.userGroup03Filled),
  ),
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.reports,
    group: SalesAndMarketingDashboardGroup.groupA,
    title: 'Reports',
    icon: (BetterIcons.noteOutline, BetterIcons.noteFilled),
  ),
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.products,
    group: SalesAndMarketingDashboardGroup.groupA,
    title: 'Products',
    icon: (BetterIcons.packageOutline, BetterIcons.packageFilled),
  ),
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.calendar,
    group: SalesAndMarketingDashboardGroup.groupA,
    title: 'Calendar',
    icon: (BetterIcons.calendar03Outline, BetterIcons.calendar03Filled),
  ),
];

final groupBPages = <SalesAndMarketingDashboardPageConfig>[
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.overview,
    group: SalesAndMarketingDashboardGroup.groupB,
    title: 'Overview',
    icon: (
      BetterIcons.dashboardSquare01Outline,
      BetterIcons.dashboardSquare01Filled,
    ),
  ),
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.analytics,
    group: SalesAndMarketingDashboardGroup.groupB,
    title: 'Analytics',
    icon: (BetterIcons.analytics01Outline, BetterIcons.analytics01Filled),
  ),
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.product,
    group: SalesAndMarketingDashboardGroup.groupB,
    title: 'Product',
    icon: (BetterIcons.store01Outline, BetterIcons.store01Filled),
  ),
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.sales,
    group: SalesAndMarketingDashboardGroup.groupB,
    title: 'Sales',
    icon: (
      BetterIcons.shoppingBasket03Outline,
      BetterIcons.shoppingBasket03Filled,
    ),
  ),
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.payment,
    group: SalesAndMarketingDashboardGroup.groupB,
    title: 'Payment',
    icon: (BetterIcons.wallet01Outline, BetterIcons.wallet01Filled),
  ),
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.refunds,
    group: SalesAndMarketingDashboardGroup.groupB,
    title: 'Refunds',
    icon: (BetterIcons.chart03Outline, BetterIcons.chart03Filled),
  ),
  SalesAndMarketingDashboardPageConfig(
    page: SalesAndMarketingDashboardPage.invoices,
    group: SalesAndMarketingDashboardGroup.groupB,
    title: 'Invoices',
    icon: (BetterIcons.invoice01Outline, BetterIcons.invoice01Filled),
  ),
];

final allDashboardPages = [...groupAPages, ...groupBPages];

List<SalesAndMarketingDashboardPageConfig> pagesByGroup(
  SalesAndMarketingDashboardGroup group,
) => allDashboardPages.where((p) => p.group == group).toList();
