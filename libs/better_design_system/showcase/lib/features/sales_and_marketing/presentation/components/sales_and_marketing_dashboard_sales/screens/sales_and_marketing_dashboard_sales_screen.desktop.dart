import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import '../../sales_and_marketing_dashboard_kpi_card.dart';
import '../../sales_and_marketing_dashboard_navbar/sales_and_marketing_dashboard_navbar_secondary.dart';
import '../../sales_and_marketing_sidebar.dart';
import '../components/sales_and_marketing_sales_all_timespending_card.dart';
import '../components/sales_and_marketing_sales_month_sales_card.dart';
import '../components/sales_and_marketing_sales_product_sales_statics_card.dart';
import '../components/sales_and_marketing_sales_summary_card.dart';

class SalesAndMarketingDashboardSalesScreenDesktop extends StatelessWidget {
  final Widget? header;

  const SalesAndMarketingDashboardSalesScreenDesktop({super.key, this.header});

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
                selectedPage: SalesAndMarketingDashboardPage.sales,
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
                                BetterIcons.shoppingBasket03Filled,
                                size: 32,
                                color: context.colors.primary,
                              ),
                              Text(
                                'Sales',
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
                                  flex: 68,
                                  child: SizedBox(
                                    height: 348,
                                    child: SalesAndMarketingSalesSummaryCard(),
                                  ),
                                ),
                                Expanded(
                                  flex: 41,
                                  child:
                                      SalesAndMarketingSalesProductSalesStaticsCard(),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 24,
                              children: [
                                Expanded(
                                  flex: 36,
                                  child: SizedBox(
                                    height: 352,
                                    child:
                                        SalesAndMarketingSalesMonthSalesCard(),
                                  ),
                                ),
                                Expanded(
                                  flex: 73,
                                  child: SizedBox(
                                    height: 352,
                                    child:
                                        SalesAndMarketingSalesAllTimespendingCard(),
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
