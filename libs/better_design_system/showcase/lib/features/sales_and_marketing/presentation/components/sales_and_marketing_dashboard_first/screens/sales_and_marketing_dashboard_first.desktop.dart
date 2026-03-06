import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../sales_and_marketing_dashboard_navbar/sales_and_marketing_dashboard_navbar_primary.dart';
import '../components/sales_and_marketing_dashboard_first_tiny_stat_card.dart';
import '../components/sales_and_marketing_platform_card.dart';
import '../components/sales_and_marketing_region_card.dart';
import '../components/sales_and_marketing_registered_users_card.dart';
import '../components/sales_and_marketing_revenue_over_time_card.dart';
import '../components/sales_and_marketing_sessions_by_country_card.dart';
import '../../sales_and_marketing_sidebar.dart';

class SalesAndMarketingDashboardFirstDesktop extends StatelessWidget {
  final Widget? header;
  const SalesAndMarketingDashboardFirstDesktop({super.key, this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SalesAndMarketingSidebar(),
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
                            'Dashboard',
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
                                ...SalesAndMarketingDashboardFirstTinyStatCard
                                    .tinyStatCards
                                    .map((card) => Expanded(child: card)),
                              ],
                            ),
                            Row(
                              spacing: 24,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 73,
                                  child: SizedBox(
                                    height: 395,
                                    child:
                                        SalesAndMarketingRevenueOverTimeCard(),
                                  ),
                                ),
                                Expanded(
                                  flex: 36,
                                  child: SizedBox(
                                    height: 395,
                                    child:
                                        SalesAndMarketingSessionsByCountryCard(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 24,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 380,
                                    child: SalesAndMarketingRegionCard(),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 380,
                                    child: SalesAndMarketingPlatformCard(),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 380,
                                    child:
                                        SalesAndMarketingRegisteredUsersCard(),
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
