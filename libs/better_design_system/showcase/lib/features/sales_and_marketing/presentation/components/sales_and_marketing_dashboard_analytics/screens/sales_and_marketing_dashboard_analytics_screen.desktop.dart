import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import '../../sales_and_marketing_dashboard_kpi_card.dart';
import '../../sales_and_marketing_dashboard_navbar/sales_and_marketing_dashboard_navbar_secondary.dart';
import '../../sales_and_marketing_sidebar.dart';
import '../components/sales_and_marketing_analytics_last_transaction_card.dart';
import '../components/sales_and_marketing_analytics_recent_sales_order_card.dart';
import '../components/sales_and_marketing_analytics_sales_order_summary_card.dart';
import '../components/sales_and_marketing_analytics_top_spending_item_card.dart';

class SalesAndMarketingDashboardAnalyticsScreenDesktop extends StatelessWidget {
  final Widget? header;

  const SalesAndMarketingDashboardAnalyticsScreenDesktop({
    super.key,
    this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SalesAndMarketingSidebar(
                dashboardGroup: SalesAndMarketingDashboardGroup.groupB,
                selectedPage: SalesAndMarketingDashboardPage.analytics,
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Navbar
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: SalesAndMarketingDashboardNavbarSecondary(
                          title: Row(
                            spacing: 12,
                            children: [
                              Icon(
                                BetterIcons.analytics01Filled,
                                size: 32,
                                color: context.colors.primary,
                              ),
                              Text(
                                'Analytics',
                                style: context.textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppDivider(),

                      // Main content
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          spacing: 24,
                          children: [
                            // KPI Cards row
                            Row(
                              spacing: 24,
                              children:
                                  SalesAndMarketingDashboardKpiCard.kpiCards
                                      .map((card) => Expanded(child: card))
                                      .toList(),
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 24,
                              children: [
                                Expanded(
                                  flex: 72,
                                  child:
                                      SalesAndMarketingAnalyticsSalesOrderSummaryCard(),
                                ),
                                Expanded(
                                  flex: 37,
                                  child: SizedBox(
                                    height: 350,
                                    child:
                                        SalesAndMarketingAnalyticsLastTransactionCard(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 24,
                              children: [
                                Expanded(
                                  flex: 72,
                                  child:
                                      SalesAndMarketingAnalyticsRecentSalesOrderCard(),
                                ),
                                Expanded(
                                  flex: 37,
                                  child:
                                      SalesAndMarketingAnalyticsTopSpendingItemCard(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
