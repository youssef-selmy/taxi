import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingSalesMonthSalesCard extends StatelessWidget {
  const SalesAndMarketingSalesMonthSalesCard({super.key});

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
        spacing: 24,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text('4 Moth Sales', style: context.textTheme.titleSmall),
                  Text(
                    'Snowing top sales',
                    style: context.textTheme.bodySmall?.variant(context),
                  ),
                ],
              ),

              AppIconButton(
                onPressed: () {},
                icon: BetterIcons.moreVerticalCircle01Outline,
                size: ButtonSize.medium,
              ),
            ],
          ),

          _buildProgressBar(context, title: 'Accessories', percent: 88),
          _buildProgressBar(context, title: 'Table', percent: 69),
          _buildProgressBar(context, title: 'Home Office', percent: 50),
          _buildProgressBar(context, title: 'Clothes', percent: 28),
          _buildProgressBar(context, title: 'Medicine', percent: 11),
        ],
      ),
    );
  }

  Widget _buildProgressBar(
    BuildContext context, {
    required String title,
    required double percent,
  }) {
    return Column(
      spacing: 8,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title, style: context.textTheme.labelMedium),
            Text(
              '${percent.toStringAsFixed(0)}%',
              style: context.textTheme.labelMedium,
            ),
          ],
        ),
        AppLinearProgressBar(
          linearProgressBarStatus: LinearProgressBarStatus.uploading,
          progress: percent / 100,
        ),
      ],
    );
  }
}
