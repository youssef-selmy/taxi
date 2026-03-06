import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/components/ecommerce_customers_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/components/ecommerce_new_customers_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/components/ecommerce_recent_orders_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/components/ecommerce_revenue_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_sidebar.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_navbar.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/components/ecommerce_total_orders_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/components/ecommerce_total_sales_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/components/ecommerce_user_activity_card.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class EcommerceDashboardDesktop extends StatelessWidget {
  const EcommerceDashboardDesktop({super.key, this.header});

  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EcommerceSidebar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      EcommerceNavbar.dashboardPanelRounded(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 24,
                        ),
                        child: Text(
                          'Dashboard',
                          style: context.textTheme.headlineSmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 32,
                          right: 32,
                          bottom: 24,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 16,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                spacing: 16,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 16,
                                    children: [
                                      Expanded(child: EcommerceCustomersCard()),
                                      Expanded(
                                        child: EcommerceTotalSalesCard(),
                                      ),
                                      Expanded(
                                        child: EcommerceTotalOrdersCard(),
                                      ),
                                    ],
                                  ),
                                  EcommerceRevenueCard(),
                                  EcommerceRecentOrdersCard(),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                spacing: 16,
                                children: [
                                  EcommerceUserActivityCard(),
                                  EcommerceNewCustomersCard(),
                                ],
                              ),
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
