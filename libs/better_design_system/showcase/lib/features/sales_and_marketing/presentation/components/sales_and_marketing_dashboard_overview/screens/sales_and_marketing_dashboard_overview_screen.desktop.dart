import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

import '../../sales_and_marketing_dashboard_navbar/sales_and_marketing_dashboard_navbar_secondary.dart';
import '../../sales_and_marketing_sidebar.dart';
import '../components/sales_and_marketing_overview_allocation_funds_card.dart';
import '../components/sales_and_marketing_overview_customer_growth_card.dart';
import '../components/sales_and_marketing_overview_last_transaction_card.dart';
import '../../sales_and_marketing_dashboard_kpi_card.dart';
import '../components/sales_and_marketing_overview_top_transactions_table_card.dart';

/// Desktop version of the Sales & Marketing Dashboard - Sales screen.
///
/// Displays a comprehensive sales dashboard with KPI cards, allocation funds
/// chart, transaction lists, data table, and customer growth map.
class SalesAndMarketingDashboardOverviewScreenDesktop extends StatelessWidget {
  final Widget? header;

  const SalesAndMarketingDashboardOverviewScreenDesktop({
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
                selectedPage: SalesAndMarketingDashboardPage.overview,
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
                                BetterIcons.dashboardSquare01Filled,
                                size: 32,
                                color: context.colors.primary,
                              ),
                              Text(
                                'Overview',
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

                            // Middle section: Allocation Funds + Last Transaction
                            Row(
                              spacing: 24,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 72,
                                  child:
                                      SalesAndMarketingOverviewAllocationFundsCard(),
                                ),
                                Expanded(
                                  flex: 38,
                                  child:
                                      SalesAndMarketingOverviewLastTransactionCard(),
                                ),
                              ],
                            ),

                            // Bottom section: Top Transactions Table + Customer Growth
                            Row(
                              spacing: 24,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 72,
                                  child: SizedBox(
                                    height: 584,
                                    child:
                                        SalesAndMarketingOverviewTopTransactionsTableCard(),
                                  ),
                                ),
                                Expanded(
                                  flex: 38,
                                  child: SizedBox(
                                    height: 530,
                                    child:
                                        SalesAndMarketingOverviewCustomerGrowthCard(),
                                  ),
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
