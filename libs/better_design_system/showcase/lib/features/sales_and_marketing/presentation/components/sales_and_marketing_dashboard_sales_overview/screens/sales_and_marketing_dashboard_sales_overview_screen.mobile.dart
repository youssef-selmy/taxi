import 'package:better_design_showcase/core/components/page_indicator.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/widgets.dart';

import '../../sales_and_marketing_dashboard_first/components/sales_and_marketing_dashboard_first_tiny_stat_card.dart';
import '../../sales_and_marketing_dashboard_navbar/sales_and_marketing_dashboard_navbar_primary.dart';
import '../components/sales_and_marketing_average_order_card.dart';
import '../components/sales_and_marketing_orders_card.dart';
import '../components/sales_and_marketing_sales_card.dart';

class SalesAndMarketingDashboardSalesOverviewScreenMobile
    extends StatefulWidget {
  const SalesAndMarketingDashboardSalesOverviewScreenMobile({super.key});

  @override
  State<SalesAndMarketingDashboardSalesOverviewScreenMobile> createState() =>
      _SalesAndMarketingDashboardSalesOverviewScreenMobileState();
}

class _SalesAndMarketingDashboardSalesOverviewScreenMobileState
    extends State<SalesAndMarketingDashboardSalesOverviewScreenMobile> {
  final _cards = SalesAndMarketingDashboardFirstTinyStatCard.tinyStatCards;
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
      constraints: const BoxConstraints(maxWidth: 400),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SalesAndMarketingDashboardNavbarPrimary(
                  title: Text(
                    'Sales Overview',
                    style: context.textTheme.titleSmall,
                  ),
                  isMobile: true,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      density: TextFieldDensity.noDense,
                      hint: 'Search',
                      prefixIcon: Icon(
                        BetterIcons.search01Filled,
                        color: context.colors.onSurfaceVariant,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 132,
                child: PageView.builder(
                  padEnds: true,
                  pageSnapping: true,
                  controller: _pageController,
                  itemCount: _cards.length,
                  itemBuilder: (context, index) {
                    return AnimatedPadding(
                      duration: const Duration(milliseconds: 250),
                      padding: EdgeInsets.zero,
                      child: Row(children: [Expanded(child: _cards[index])]),
                    );
                  },
                ),
              ),
              AppPageIndicator(
                pageCount: _cards.length,
                currentPage: _currentPage,
              ),
              SalesAndMarketingSalesCard(isMobile: true),
              SalesAndMarketingAverageOrderCard(isMobile: true),
              SalesAndMarketingOrdersCard(isMobile: true),
            ],
          ),
        ),
      ),
    );
  }
}
