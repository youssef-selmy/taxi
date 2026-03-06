import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class SalesAndMarketingSessionsByCountryCard extends StatelessWidget {
  const SalesAndMarketingSessionsByCountryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
        color: context.colors.surface,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Sessions by Country',
                    style: context.textTheme.labelLarge,
                  ),
                  Text(
                    'Showing data for top sessions',
                    style: context.textTheme.bodySmall?.variant(context),
                  ),
                ],
              ),

              AppIconButton(
                icon: BetterIcons.moreVerticalCircle01Outline,
                size: ButtonSize.medium,
              ),
            ],
          ),

          SizedBox(height: 4),
          AppDivider(height: 20),
          SizedBox(height: 16),

          Column(
            spacing: 32,
            children: [
              _getSessionsItem(
                context,
                image: Assets.images.countries.germany.image(
                  height: 32,
                  width: 32,
                ),
                title: 'Germany',
                count: 1157,
                percent: 80,
              ),
              _getSessionsItem(
                context,
                image: Assets.images.countries.china.image(
                  height: 32,
                  width: 32,
                ),
                title: 'China',
                count: 902,
                percent: 60,
              ),
              _getSessionsItem(
                context,
                image: Assets.images.countries.unitedStates.image(
                  height: 32,
                  width: 32,
                ),
                title: 'United States',
                count: 706,
                percent: 40,
              ),
              _getSessionsItem(
                context,
                image: Assets.images.countries.netherlands.image(
                  height: 32,
                  width: 32,
                ),
                title: 'Netherlands',
                count: 459,
                percent: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getSessionsItem(
    BuildContext context, {
    required Widget image,
    required String title,
    required num count,
    required double percent,
  }) {
    return Row(
      children: <Widget>[
        image,
        SizedBox(width: 12),
        Expanded(
          child: Column(
            spacing: 8,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: context.textTheme.labelMedium),
                  Row(
                    spacing: 8,
                    children: [
                      Text(
                        '$count',
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                      Container(
                        height: 12,
                        width: 1,
                        decoration: BoxDecoration(
                          color: context.colors.outline,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      Text(
                        '$percent%',
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                    ],
                  ),
                ],
              ),
              AppLinearProgressBar(
                linearProgressBarStatus: LinearProgressBarStatus.uploading,
                progress: percent / 100,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
