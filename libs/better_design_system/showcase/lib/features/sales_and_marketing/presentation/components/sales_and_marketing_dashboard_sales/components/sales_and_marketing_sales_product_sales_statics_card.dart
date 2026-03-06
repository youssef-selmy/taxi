import 'package:better_design_showcase/core/components/pie_chart.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingSalesProductSalesStaticsCard extends StatelessWidget {
  final bool isMobile;
  const SalesAndMarketingSalesProductSalesStaticsCard({
    super.key,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'Product Sales Statics',
                    style: context.textTheme.titleSmall,
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      AppBadge(
                        prefixIcon: BetterIcons.arrowUp02Outline,
                        text: '+5.6%',
                        size: BadgeSize.small,
                        isRounded: true,
                        color: SemanticColor.success,
                      ),
                      Text(
                        'From last month',
                        style: context.textTheme.labelSmall?.variant(context),
                      ),
                    ],
                  ),
                ],
              ),

              AppIconButton(
                onPressed: () {},
                icon: BetterIcons.moreVerticalCircle01Outline,
                size: ButtonSize.medium,
                style: IconButtonStyle.outline,
              ),
            ],
          ),

          SizedBox(height: isMobile ? 16 : 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flex(
                direction: isMobile ? Axis.horizontal : Axis.vertical,
                spacing: isMobile ? 16 : 24,
                children: [
                  _buildChartLegend(
                    context,
                    badgeColor: SemanticColor.primary,
                    title: 'Product 1',
                    price: '\$48,257',
                    salesCount: '2.691',
                    isMobile: isMobile,
                  ),
                  _buildChartLegend(
                    context,
                    badgeColor: SemanticColor.warning,
                    title: 'Product 2',
                    price: '\$24,257',
                    salesCount: '1.563',
                    isMobile: isMobile,
                  ),
                ],
              ),

              if (!isMobile) AppPieChart(size: Size(210, 225)),
            ],
          ),

          if (isMobile) ...[
            SizedBox(height: 20),
            AppPieChart(size: Size(210, 225)),
          ],
        ],
      ),
    );
  }

  Column _buildChartLegend(
    BuildContext context, {
    required SemanticColor badgeColor,
    required String title,
    required String price,
    required bool isMobile,
    required String salesCount,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          spacing: 6,
          children: <Widget>[
            BetterDotBadge(color: badgeColor, dotBadgeSize: DotBadgeSize.large),
            Text(title, style: context.textTheme.labelMedium),
          ],
        ),
        SizedBox(height: 8),
        Row(
          spacing: 8,
          children: [
            Text(
              price,
              style:
                  isMobile
                      ? context.textTheme.titleSmall
                      : context.textTheme.headlineSmall,
            ),
            if (isMobile) _buldSalesText(salesCount, context),
          ],
        ),
        if (!isMobile) ...[
          SizedBox(height: 4),
          _buldSalesText(salesCount, context),
        ],
      ],
    );
  }

  Widget _buldSalesText(String salesCount, BuildContext context) => Row(
    spacing: 4,
    children: [
      Text(salesCount, style: context.textTheme.labelMedium),
      Text('Sales', style: context.textTheme.labelMedium?.variant(context)),
    ],
  );
}
