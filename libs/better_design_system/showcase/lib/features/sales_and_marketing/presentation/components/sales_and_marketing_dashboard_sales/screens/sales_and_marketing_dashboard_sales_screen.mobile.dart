import 'package:better_design_showcase/core/components/page_indicator.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../sales_and_marketing_dashboard_kpi_card.dart';
import '../../sales_and_marketing_dashboard_navbar/sales_and_marketing_dashboard_navbar_secondary.dart';
import '../components/sales_and_marketing_sales_all_timespending_card.dart';
import '../components/sales_and_marketing_sales_month_sales_card.dart';
import '../components/sales_and_marketing_sales_product_sales_statics_card.dart';
import '../components/sales_and_marketing_sales_summary_card.dart';

class SalesAndMarketingDashboardSalesScreenMobile extends StatefulWidget {
  const SalesAndMarketingDashboardSalesScreenMobile({super.key});

  @override
  State<SalesAndMarketingDashboardSalesScreenMobile> createState() =>
      _SalesAndMarketingDashboardSalesScreenMobileState();
}

class _SalesAndMarketingDashboardSalesScreenMobileState
    extends State<SalesAndMarketingDashboardSalesScreenMobile> {
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
                  title: Text('Sales', style: context.textTheme.titleMedium),
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
                        height: 138,
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

                  SalesAndMarketingSalesSummaryCard(isMobile: true),
                  SalesAndMarketingSalesProductSalesStaticsCard(isMobile: true),
                  SalesAndMarketingSalesMonthSalesCard(),
                  SalesAndMarketingSalesAllTimespendingCard(isMobile: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
