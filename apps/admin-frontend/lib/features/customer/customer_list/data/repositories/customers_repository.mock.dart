import 'dart:math';

import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.fragment.graphql.dart';
import 'package:admin_frontend/features/customer/customer_list/data/graphql/customers_statistics.graphql.dart';
import 'package:admin_frontend/features/customer/customer_list/data/repositories/customers_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CustomersRepository)
class CustomersRepositoryMock implements CustomersRepository {
  @override
  Future<ApiResponse<Fragment$CustomersListConnection>> getCustomers({
    Input$OffsetPaging? paging,
    Input$RiderFilter? filter,
    List<Input$RiderSort>? sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Fragment$CustomersListConnection(
        nodes: mockCustomerListItems,
        totalCount: 8,
        pageInfo: Fragment$OffsetPageInfo(
          hasNextPage: true,
          hasPreviousPage: true,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$CustomersStatistics>>
  getCustomersStatistics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$CustomersStatistics(
        customersPerApp: [
          Fragment$customerPerApp(app: Enum$AppType.Taxi, count: 3567),
          Fragment$customerPerApp(app: Enum$AppType.Shop, count: 8341),
          Fragment$customerPerApp(app: Enum$AppType.Parking, count: 6341),
        ],
        revenuePerApp: mockRevenuePerApp,
        customerPlatformDistribution: [
          Fragment$PlatformDistribution(
            platform: Enum$DevicePlatform.Web,
            count: 3895,
          ),
          Fragment$PlatformDistribution(
            platform: Enum$DevicePlatform.Android,
            count: 5716,
          ),
          Fragment$PlatformDistribution(
            platform: Enum$DevicePlatform.Ios,
            count: 7341,
          ),
        ],
        topSpendingCustomers: mockLeaderboardItems,
        genderDistribution: [
          Fragment$GenderDistribution(count: 2561, gender: Enum$Gender.Female),
          Fragment$GenderDistribution(count: 3814, gender: Enum$Gender.Male),
        ],
        retentionRate: mockRetentionRate,
        activeInactiveUsers: mockActiveInactiveUsers,
        countryDistribution: mockCountryDistribution,
      ),
    );
  }

  List<Fragment$RevenuePerApp> get mockRevenuePerApp => [
    for (var app in Enum$AppType.values.where(
      (app) => app != Enum$AppType.$unknown,
    ))
      for (var i = 1; i <= 12; i++)
        Fragment$RevenuePerApp(
          app: app,
          date: DateTime(2024, i, 1),
          revenue: (Random().nextInt(10) * 1000) + 20000,
        ),
  ];

  List<Fragment$ActiveInactiveUsers> get mockActiveInactiveUsers => [
    for (var i = 1; i <= 12; i++)
      Fragment$ActiveInactiveUsers(
        date: DateTime(2024, i, 1),
        activityLevel: Enum$UserActivityLevel.Active,
        count: 500 + Random().nextInt(500),
      ),
    for (var i = 1; i <= 12; i++)
      Fragment$ActiveInactiveUsers(
        date: DateTime(2024, i, 1),
        activityLevel: Enum$UserActivityLevel.Inactive,
        count: 500 + Random().nextInt(500),
      ),
  ];

  List<Fragment$RetentionRate> get mockRetentionRate => [
    for (var i = 1; i <= 12; i++)
      Fragment$RetentionRate(
        date: DateTime(2024, i, 1),
        retentionRate: Random().nextInt(20) + 80,
      ),
  ];

  List<Fragment$CountryDistribution> get mockCountryDistribution => [
    Fragment$CountryDistribution(count: 2561, country: "US"),
    Fragment$CountryDistribution(count: 3814, country: "DE"),
    Fragment$CountryDistribution(count: 2319, country: "FR"),
    Fragment$CountryDistribution(count: 1234, country: "UK"),
    Fragment$CountryDistribution(count: 1234, country: "IT"),
  ];

  @override
  Future<ApiResponse<List<Fragment$RevenuePerApp>>> getRevenuePerApp({
    required Input$ChartFilterInput filter,
  }) async {
    return ApiResponse.loaded(mockRevenuePerApp);
  }
}
