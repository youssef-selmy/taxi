import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import '../../sales_and_marketing_dashboard_navbar/sales_and_marketing_dashboard_navbar_primary.dart';
import '../components/sales_and_marketing_conversion_card.dart';
import '../components/sales_and_marketing_dashboard_waiting_list_tiny_card.dart';
import '../components/sales_and_marketing_waiting_list_card.dart';
import '../components/sales_and_marketing_wating_list_sales_card.dart';

class SalesAndMarketingDashboardWaitingListScreenMobile
    extends StatelessWidget {
  const SalesAndMarketingDashboardWaitingListScreenMobile({super.key});

  final _tinyCards =
      SalesAndMarketingDashboardWaitingListTinyCard.tinyStatCards;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 400),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SalesAndMarketingDashboardNavbarPrimary(
                  title: Text(
                    'Waiting List',
                    style: context.textTheme.titleSmall,
                  ),
                  isMobile: true,
                ),
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              Column(
                spacing: 8,
                children:
                    _tinyCards
                        .map(
                          (e) => SalesAndMarketingDashboardWaitingListTinyCard(
                            title: e.title,
                            subtitle: e.subtitle,
                            icon: e.icon,
                          ),
                        )
                        .toList(),
              ),
              SizedBox(height: 24),

              Column(
                spacing: 24,
                children: [
                  SalesAndMarketingWaitingListSalesCard(isMobile: true),
                  SalesAndMarketingConversionCard(),
                  SalesAndMarketingWaitingListCard(isMobile: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
