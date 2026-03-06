import 'package:better_design_showcase/core/components/page_indicator.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../sales_and_marketing_dashboard_navbar/sales_and_marketing_dashboard_navbar_secondary.dart';
import '../components/sales_and_marketing_overview_allocation_funds_card.dart';
import '../components/sales_and_marketing_overview_customer_growth_card.dart';
import '../components/sales_and_marketing_overview_last_transaction_card.dart';
import '../../sales_and_marketing_dashboard_kpi_card.dart';
import '../components/sales_and_marketing_overview_top_transactions_table_card.dart';

/// Mobile/Tablet version of the Sales & Marketing Dashboard - Sales screen.
///
/// Provides a responsive layout for smaller screens with stacked components
/// instead of side-by-side layout.
class SalesAndMarketingDashboardOverviewScreenMobile extends StatefulWidget {
  final Widget? header;

  const SalesAndMarketingDashboardOverviewScreenMobile({
    super.key,
    this.header,
  });

  @override
  State<SalesAndMarketingDashboardOverviewScreenMobile> createState() =>
      _SalesAndMarketingDashboardOverviewScreenMobileState();
}

class _SalesAndMarketingDashboardOverviewScreenMobileState
    extends State<SalesAndMarketingDashboardOverviewScreenMobile> {
  final _cards = SalesAndMarketingDashboardKpiCard.kpiCards;
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() => _currentPage = page);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Navbar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SalesAndMarketingDashboardNavbarSecondary(
                  isMobile: true,
                  title: Text('Overview', style: context.textTheme.titleMedium),
                ),
              ),
              // Main content
              SizedBox(height: 8),
              Column(
                spacing: 24,
                children: [
                  // KPI Cards - stacked vertically on mobile
                  Column(
                    spacing: 16,
                    children: <Widget>[
                      SizedBox(
                        height: 135,
                        child: PageView.builder(
                          padEnds: true,
                          pageSnapping: true,
                          controller: _pageController,
                          itemCount: _cards.length,
                          itemBuilder: (context, index) {
                            return AnimatedPadding(
                              duration: const Duration(milliseconds: 250),
                              padding: EdgeInsets.zero,
                              child: Row(
                                children: [Expanded(child: _cards[index])],
                              ),
                            );
                          },
                        ),
                      ),
                      AppPageIndicator(
                        pageCount: _cards.length,
                        currentPage: _currentPage,
                      ),
                    ],
                  ),

                  // Allocation Funds card
                  SalesAndMarketingOverviewAllocationFundsCard(isMobile: true),

                  // // Last Transaction card
                  SalesAndMarketingOverviewLastTransactionCard(isMobile: true),

                  // // Top Transactions Table
                  SalesAndMarketingOverviewTopTransactionsTableCard(
                    isMobile: true,
                  ),

                  // // Customer Growth card
                  SalesAndMarketingOverviewCustomerGrowthCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
