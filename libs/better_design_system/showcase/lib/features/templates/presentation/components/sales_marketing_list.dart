import 'package:auto_route/auto_route.dart';
import 'package:better_assets/gen/assets.gen.dart' as better_assets;
import 'package:better_design_showcase/core/router/app_router.dart';
import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

class AppSalesMarketingList extends StatelessWidget {
  const AppSalesMarketingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding:
              context.isMobile
                  ? const EdgeInsets.all(8)
                  : const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: context.colors.success,
                      shape: BoxShape.circle,
                    ),
                    child: better_assets.Assets.images.iconsTwotone.chart03.svg(
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        context.colors.onSuccess,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Sales & Marketing',
                    style: context.textTheme.titleMedium,
                  ),
                  const Spacer(),
                  AppTextButton(
                    onPressed: () {
                      context.router.push(SalesAndMarketingRoute());
                    },
                    text: 'View Template',
                    suffixIcon: BetterIcons.arrowRight02Outline,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: context.colors.surfaceVariantLow,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: context.colors.outline),
                  boxShadow: [BetterShadow.shadow8.toBoxShadow(context)],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child:
                          Assets.images.showcase.salesMarketingFirstDashboard
                              .image(),
                    ),
                    if (!context.isMobile) ...[
                      const SizedBox(width: 16),
                      Flexible(
                        child:
                            Assets.images.showcase.salesMarketingSecondDashboard
                                .image(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
