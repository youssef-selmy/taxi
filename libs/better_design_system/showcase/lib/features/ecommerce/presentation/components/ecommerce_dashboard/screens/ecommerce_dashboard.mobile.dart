import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/components/ecommerce_customers_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_mobile_top_bar.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/components/ecommerce_new_customers_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/components/ecommerce_recent_orders_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/components/ecommerce_revenue_card.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/components/ecommerce_user_activity_card.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceDashboardMobile extends StatelessWidget {
  const EcommerceDashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                EcommerceMobileTopBar.dashboardPanel(
                  prefixIcon: BetterIcons.menu01Outline,
                  title: 'Dashboard',
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 116,
                  ),
                  child: Column(
                    children: [
                      const EcommerceCustomersCard(),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8,
                          children: [
                            _buildIndicatorDot(context, isActive: true),
                            _buildIndicatorDot(context),
                            _buildIndicatorDot(context),
                          ],
                        ),
                      ),
                      const EcommerceRevenueCard(isMobile: true),
                      const SizedBox(height: 20),
                      const EcommerceUserActivityCard(),
                      const SizedBox(height: 20),
                      const EcommerceNewCustomersCard(),
                      const SizedBox(height: 20),
                      EcommerceRecentOrdersCard(isMobile: true),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicatorDot(BuildContext context, {bool isActive = false}) {
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        border: isActive ? null : Border.all(color: context.colors.outline),
        color:
            isActive ? context.colors.primary : context.colors.surfaceVariant,
        shape: BoxShape.circle,
      ),
    );
  }
}
