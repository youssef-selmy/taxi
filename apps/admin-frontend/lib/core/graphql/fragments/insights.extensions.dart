import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/charts/chart_colors.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/entities/chart_filter_input.extensions.dart';
import 'package:admin_frontend/core/enums/device_platform_enum.dart';
import 'package:admin_frontend/core/enums/gender.dart';
import 'package:admin_frontend/core/enums/user_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension FragmentCustomerLoginPerApp on Fragment$customerPerApp {
  ChartSeriesData toChartSeriesData(BuildContext context) {
    return ChartSeriesData(name: app.name, value: count.toDouble());
  }
}

extension ListFragmentCustomerLoginPerApp on List<Fragment$customerPerApp> {
  List<ChartSeriesData> toChartSeriesData(BuildContext context) {
    return map((e) => e.toChartSeriesData(context)).toList();
  }
}

extension FragmentRevenuePerAppX on Fragment$RevenuePerApp {
  ChartSeriesData toChartSeriesData(
    Input$ChartFilterInput input,
    BuildContext context,
  ) {
    return ChartSeriesData(
      name: input.interval.format(date),
      value: revenue.toDouble(),
      groupBy: app,
    );
  }
}

extension ListFragmentRevenuePerAppX on List<Fragment$RevenuePerApp> {
  List<ChartSeriesData> toChartSeriesData(
    Input$ChartFilterInput filter,
    BuildContext context,
  ) {
    return map((e) => e.toChartSeriesData(filter, context)).toList();
  }
}

extension FragmentPlatformDistributionX on Fragment$PlatformDistribution {
  ChartSeriesData toChartSeriesData(BuildContext context) {
    return ChartSeriesData(
      name: platform.name(context),
      value: count.toDouble(),
      color: platform.color,
    );
  }
}

extension ListFragmentPlatformDistributionX
    on List<Fragment$PlatformDistribution> {
  double get total {
    return map(
          (e) => e.count,
        ).reduce((value, element) => value > element ? value : element) *
        1.10;
  }

  List<ChartSeriesData> toChartSeriesData(BuildContext context) {
    return map((e) => e.toChartSeriesData(context)).toList();
  }
}

extension FragmentGenderDistributionX on Fragment$GenderDistribution {
  ChartSeriesData toChartSeriesData(BuildContext context) {
    return ChartSeriesData(
      name: gender.name(context),
      value: count.toDouble(),
      color: gender.color,
    );
  }
}

extension ListFragmentGenderDistributionX on List<Fragment$GenderDistribution> {
  double get total {
    return map(
          (e) => e.count,
        ).reduce((value, element) => value > element ? value : element) *
        1.10;
  }

  List<ChartSeriesData> toChartSeriesData(BuildContext context) {
    return map((e) => e.toChartSeriesData(context)).toList();
  }
}

extension FragmentRetentionRateX on Fragment$RetentionRate {
  ChartSeriesData toChartSeriesData(
    Input$ChartFilterInput filter,
    BuildContext context,
  ) {
    return ChartSeriesData(
      name: filter.interval.format(date),
      value: retentionRate.toDouble(),
      color: context.colors.primary,
    );
  }
}

extension ListFragmentRetentionRateX on List<Fragment$RetentionRate> {
  double get total {
    return map(
          (e) => e.retentionRate,
        ).reduce((value, element) => value > element ? value : element) *
        1.10;
  }

  List<ChartSeriesData> toChartSeriesData(
    Input$ChartFilterInput filter,
    BuildContext context,
  ) {
    return map((e) => e.toChartSeriesData(filter, context)).toList();
  }
}

extension FragmentActiveInactiveUsersX on Fragment$ActiveInactiveUsers {
  ChartSeriesData<Enum$UserActivityLevel> toChartSeriesData<
    Enum$UserActivityLevel
  >(Input$ChartFilterInput input, BuildContext context) {
    return ChartSeriesData<Enum$UserActivityLevel>(
      name: input.interval.format(date),
      value: count.toDouble(),
      groupBy: activityLevel as Enum$UserActivityLevel,
    );
  }
}

extension ListFragmentActiveInactiveUsersX
    on List<Fragment$ActiveInactiveUsers> {
  List<ChartSeriesData<Enum$UserActivityLevel>> toChartSeriesData<
    Enum$UserActivityLevel
  >(Input$ChartFilterInput filter, BuildContext context) {
    return map(
      (e) => e.toChartSeriesData<Enum$UserActivityLevel>(filter, context),
    ).toList();
  }

  List<ChartSeriesData<Enum$UserActivityLevel>>
  toChartSeriesDataNonTimed<Enum$UserActivityLevel>(BuildContext context) {
    return map(
      (e) => ChartSeriesData<Enum$UserActivityLevel>(
        name: e.activityLevel.name,
        value: e.count.toDouble(),
        color: activeInactiveColorsAlternative[e.activityLevel.index],
      ),
    ).toList();
  }
}

extension FragmentCountryDistributionX on Fragment$CountryDistribution {
  ChartSeriesData toChartSeriesData() {
    return ChartSeriesData(name: country, value: count.toDouble());
  }
}

extension ListFragmentCountryDistributionX
    on List<Fragment$CountryDistribution> {
  double get total =>
      map(
        (e) => e.count,
      ).reduce((value, element) => value > element ? value : element) *
      1.1;

  List<ChartSeriesData> toChartSeriesData() =>
      map((e) => e.toChartSeriesData()).toList();
}

extension NameCountX on Fragment$nameCount {
  ChartSeriesData toChartSeriesData() {
    return ChartSeriesData(name: name, value: count.toDouble());
  }
}

extension ListNameCountX on List<Fragment$nameCount> {
  List<ChartSeriesData> toChartSeriesData() =>
      map((e) => e.toChartSeriesData()).toList();
}

extension UserTypeCountGQLX on Fragment$userTypeCount {
  ChartSeriesData toChartSeriesData(BuildContext context) {
    return ChartSeriesData(
      name: userType.name(context),
      value: count.toDouble(),
      color: userType.color(context),
    );
  }
}

extension ListUserTypeCountGQLX on List<Fragment$userTypeCount> {
  List<ChartSeriesData> toChartSeriesData(BuildContext context) =>
      map((e) => e.toChartSeriesData(context)).toList();
}

extension UsedUnusedCountPairGqlX on Fragment$usedUnusedCountPair {
  List<ChartSeriesData<String>> toChartSeriesData(BuildContext context) {
    return [
      ChartSeriesData(
        name: context.tr.used,
        value: used.toDouble(),
        color: context.colors.primary,
      ),
      ChartSeriesData(
        name: context.tr.unused,
        value: unused.toDouble(),
        color: context.colors.secondary,
      ),
    ];
  }
}

extension FinancialTimelineX on List<Fragment$financialTimeline> {
  List<ChartSeriesData> toChartSeriesData(BuildContext context) =>
      map((r) => ChartSeriesData(name: r.dateString, value: r.amount)).toList();
}

final mockFinancialTimeline1 = Fragment$financialTimeline(
  dateString: "Jan",
  anyDate: DateTime(2025, 1),
  amount: 100,
);

final mockFinancialTimeline2 = Fragment$financialTimeline(
  dateString: "Feb",
  anyDate: DateTime(2025, 2),
  amount: 200,
);

final mockFinancialTimeline3 = Fragment$financialTimeline(
  dateString: "Mar",
  anyDate: DateTime(2025, 3),
  amount: 160,
);

final mockFinancialTimeline4 = Fragment$financialTimeline(
  dateString: "Apr",
  anyDate: DateTime(2025, 4),
  amount: 250,
);

final mockFinancialTimeline5 = Fragment$financialTimeline(
  dateString: "May",
  anyDate: DateTime(2025, 5),
  amount: 200,
);

final mockFinancialTimelines = [
  mockFinancialTimeline1,
  mockFinancialTimeline2,
  mockFinancialTimeline3,
  mockFinancialTimeline4,
  mockFinancialTimeline5,
];
