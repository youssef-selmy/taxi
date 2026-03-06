import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/molecules/charts/linear_sparkline/linear_sparkline.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_card_container.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

/// Card displaying time worked statistics with responsive layouts.
///
/// Shows total hours worked, daily average, and a time trend chart.
/// The layout adapts between mobile (vertical stacking) and desktop (horizontal layout).
class HrPlatformTimeWorkedCard extends StatelessWidget {
  /// Creates a [HrPlatformTimeWorkedCard].
  ///
  /// The [isMobile] parameter determines the layout style.
  /// Defaults to false (desktop layout).
  const HrPlatformTimeWorkedCard({super.key, this.isMobile = false});

  /// Whether to use mobile layout (vertical) or desktop layout (horizontal).
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return HrPlatformCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          _buildHeader(context),
          _buildContent(context),
          _buildChart(context),
        ],
      ),
    );
  }

  /// Builds the header with title and action buttons.
  Widget _buildHeader(BuildContext context) => Row(
    children: [
      Text('Time Worked', style: context.textTheme.titleSmall),
      const Spacer(),
      AppDropdownField.single(
        prefixIcon: BetterIcons.calendar03Outline,
        type: DropdownFieldType.compact,
        items: [
          AppDropdownItem<String>(value: 'Daily', title: 'Daily'),
          AppDropdownItem<String>(value: 'Weekly', title: 'Weekly'),
          AppDropdownItem<String>(value: 'Monthly', title: 'Monthly'),
        ],
        onChanged: (String? value) {},
        initialValue: 'Monthly',
        isFilled: false,
        fillColor: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        width: 115,
      ),
      const SizedBox(width: 8),
      AppIconButton(
        icon: BetterIcons.moreVerticalCircle01Outline,
        isCircular: true,
        size: ButtonSize.medium,
        style: IconButtonStyle.outline,
        iconColor: context.colors.onSurfaceVariant,
        iconSize: 18,
      ),
    ],
  );

  /// Builds the content section with metrics.
  /// Adapts layout based on [isMobile] flag.
  Widget _buildContent(BuildContext context) {
    if (isMobile) {
      return Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('13 hr 26 min', style: context.textTheme.headlineSmall),
          Row(
            spacing: 8,
            children: [
              Text(
                'Daily Average',
                style: context.textTheme.labelMedium!.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              AppBadge(
                text: '8.1% VS Last Week',
                color: SemanticColor.success,
                prefixIcon: BetterIcons.arrowUp02Outline,
                isRounded: true,
                size: BadgeSize.medium,
              ),
            ],
          ),
          Text(
            '256 hr 45 min Total Time',
            style: context.textTheme.labelLarge!.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ],
      );
    }

    // Desktop layout: horizontal arrangement
    return Row(
      spacing: 8,
      children: [
        Text('13 hr 26 min', style: context.textTheme.headlineSmall),
        Text(
          'Daily Average',
          style: context.textTheme.labelMedium!.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        AppBadge(
          text: '8.1% VS Last Week',
          color: SemanticColor.success,
          prefixIcon: BetterIcons.arrowUp02Outline,
          isRounded: true,
          size: BadgeSize.medium,
        ),
        const Spacer(),
        Text(
          '256 hr 45 min Total Time ',
          style: context.textTheme.labelLarge!.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// Builds the time worked chart.
  Widget _buildChart(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 12, right: 12),
    child: SizedBox(
      height: 200,
      child: AppLinearSparkline(
        data: [
          ChartSeriesData(
            points: _getChartPoints(),
            name: 'Time Worked',
            color: context.colors.insight,
            isCurved: true,
          ),
        ],
        hasLine: true,
        hasArea: true,
        gridEnabled: true,
        showTooltip: true,
        bottomTitleBuilder: (label) => label,
        bottomTitleInterval: 1,
      ),
    ),
  );

  /// Returns the data points for the time worked chart.
  List<ChartPoint> _getChartPoints() => [
    ChartPoint(name: 'Jan', value: 120),
    ChartPoint(name: 'Feb', value: 145),
    ChartPoint(name: 'Mar', value: 168),
    ChartPoint(name: 'Apr', value: 178),
    ChartPoint(name: 'May', value: 195),
    ChartPoint(name: 'Jun', value: 203),
    ChartPoint(name: 'Jul', value: 188),
    ChartPoint(name: 'Aug', value: 172),
    ChartPoint(name: 'Sep', value: 165),
    ChartPoint(name: 'Oct', value: 155),
    ChartPoint(name: 'Nov', value: 140),
    ChartPoint(name: 'Dec', value: 130),
  ];
}
