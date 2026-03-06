import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/chart_customer_churn_rate_card.dart';
import '../components/chart_feature_usage_by_users_card.dart';
import '../components/chart_linear_card.dart';
import '../components/chart_total_orders_card.dart';

@RoutePage()
class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(previousTitle: 'Blocks', currentTitle: 'Chart'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Chart',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: 1080,
                title: 'Customer Churn Rate Card',
                desktopSourceCode:
                    'blocks/chart/chart_customer_churn_rate_card.txt',
                desktopWidget: ChartCustomerChurnRateCard(),
              ),

              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: 1080,
                title: 'Linear Card',
                desktopSourceCode: 'blocks/chart/chart_linear_card.txt',
                desktopWidget: ChartLinearCard(),
              ),

              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: 1080,
                title: 'Feature Usage By Users Card',
                desktopSourceCode:
                    'blocks/chart/chart_feature_usage_by_users_card.txt',
                desktopWidget: ChartFeatureUsageByUsersCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1080,
                title: 'Total Orders Card',
                desktopSourceCode: 'blocks/chart/chart_total_orders_card.txt',
                desktopWidget: ChartTotalOrdersCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
