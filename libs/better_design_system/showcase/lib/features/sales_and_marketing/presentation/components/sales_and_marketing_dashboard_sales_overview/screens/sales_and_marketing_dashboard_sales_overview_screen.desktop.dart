import 'package:better_design_showcase/features/sales_and_marketing/presentation/components/sales_and_marketing_dashboard_sales_overview/components/sales_and_marketing_sales_card.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/widgets.dart';
import '../../sales_and_marketing_dashboard_navbar/sales_and_marketing_dashboard_navbar_primary.dart';
import '../../sales_and_marketing_sidebar.dart';
import '../components/sales_and_marketing_average_order_card.dart';
import '../components/sales_and_marketing_dashboard_sales_overview_tiny_stat_card.dart';
import '../components/sales_and_marketing_orders_card.dart';

class SalesAndMarketingDashboardSalesOverviewScreenDesktop
    extends StatelessWidget {
  final Widget? header;
  const SalesAndMarketingDashboardSalesOverviewScreenDesktop({
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
                selectedPage: SalesAndMarketingDashboardPage.salesOverview,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: SalesAndMarketingDashboardNavbarPrimary(
                          title: Text(
                            'Sales Overview',
                            style: context.textTheme.headlineSmall,
                          ),
                        ),
                      ),
                      AppDivider(),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          spacing: 24,
                          children: [
                            Row(
                              spacing: 24,
                              children: [
                                ...SalesAndMarketingDashboardSalesOverviewTinyStatCard
                                    .tinyStatCards
                                    .map((card) => Expanded(child: card)),
                              ],
                            ),
                            SalesAndMarketingSalesCard(),
                            SalesAndMarketingOrdersCard(),
                            SalesAndMarketingAverageOrderCard(),
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
