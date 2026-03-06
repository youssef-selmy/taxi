import 'package:api_response/api_response.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_showcase/core/components/table_footer.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/molecules/charts/bar_sparkline/bar_sparkline.dart';
import 'package:better_design_system/molecules/charts/chart_series_data.dart';
import 'package:better_design_system/organisms/data_table/data_table.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

class Transactions {
  final String username;
  final Widget avatar;
  final String activity;
  final SemanticColor activityColor;
  final IconData? activityIcon;
  final String userStatus;
  Transactions({
    required this.username,
    required this.avatar,
    required this.activity,
    required this.activityColor,
    this.activityIcon,
    this.userStatus = 'Active',
  });
}

class TableCustomersData extends StatelessWidget {
  const TableCustomersData({super.key, this.isMobile = false});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final orders = [
      Transactions(
        username: 'Angel Gouse',
        avatar: Assets.images.avatars.illustration01.image(
          width: 40,
          height: 40,
        ),
        activity: 'Online',
        activityColor: SemanticColor.primary,
      ),
      Transactions(
        username: 'Martin Calzoni',
        avatar: Assets.images.avatars.illustration02.image(
          width: 40,
          height: 40,
        ),
        activity: 'Online',
        activityColor: SemanticColor.primary,
      ),
      Transactions(
        username: 'Marcus Bergson',
        avatar: Assets.images.avatars.illustration03.image(
          width: 40,
          height: 40,
        ),
        activity: 'Online',
        activityColor: SemanticColor.primary,
      ),
      Transactions(
        username: 'Abram Bator',
        avatar: Assets.images.avatars.illustration04.image(
          width: 40,
          height: 40,
        ),
        activity: 'Last activity 2h ago',
        activityColor: SemanticColor.neutral,
        activityIcon: BetterIcons.clock01Filled,
        userStatus: 'Blocked',
      ),
      Transactions(
        username: 'Alfonso Lipshutz',
        avatar: Assets.images.avatars.illustration05.image(
          width: 40,
          height: 40,
        ),
        activity: 'Last activity 2h ago',
        activityColor: SemanticColor.neutral,
        activityIcon: BetterIcons.clock01Filled,
        userStatus: 'Blocked',
      ),
    ];

    final data = ApiResponse<List<Transactions>>.loaded(orders);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 385,
          width: double.infinity,
          child: AppDataTable<List<Transactions>, dynamic>(
            minWidth: 1500,
            data: data,
            getPageInfo:
                (_) =>
                    OffsetPageInfo(hasNextPage: false, hasPreviousPage: false),
            getRowCount: (list) => list.length,
            onPageChanged: (_) {},
            paging: OffsetPaging(limit: 10, offset: 0),
            columns: [
              DataColumn2(fixedWidth: 48, label: AppCheckbox(value: false)),
              DataColumn2(
                fixedWidth: 74,
                label: Text('', style: context.textTheme.bodyMedium),
              ),
              DataColumn2(
                fixedWidth: 271.5,
                label: Row(
                  children: [
                    Text('User', style: context.textTheme.bodyMedium),
                    SizedBox(width: 4),
                    Icon(
                      BetterIcons.unfoldMoreFilled,
                      color: context.colors.onSurfaceVariantLow,
                      size: 20,
                    ),
                  ],
                ),
              ),
              DataColumn2(
                fixedWidth: 210,
                label: Row(
                  children: [
                    Text('Activity', style: context.textTheme.bodyMedium),
                    SizedBox(width: 4),
                    Icon(
                      BetterIcons.unfoldMoreFilled,
                      color: context.colors.onSurfaceVariantLow,
                      size: 20,
                    ),
                  ],
                ),
              ),
              DataColumn2(
                fixedWidth: 180,
                label: Text(
                  'Mobile Number',
                  style: context.textTheme.bodyMedium,
                ),
              ),
              DataColumn2(
                fixedWidth: 160,
                label: Text(
                  'Wallet Amount',
                  style: context.textTheme.bodyMedium,
                ),
              ),
              DataColumn2(
                fixedWidth: 252,
                label: Row(
                  children: [
                    Text('Total Order', style: context.textTheme.bodyMedium),
                    const SizedBox(width: 4),
                    Icon(
                      BetterIcons.unfoldMoreFilled,
                      color: context.colors.onSurfaceVariantLow,
                      size: 20,
                    ),
                  ],
                ),
              ),
              DataColumn2(fixedWidth: 56, label: Text('')),
            ],
            rowBuilder: (list, index) {
              final item = list[index];
              return DataRow(
                onSelectChanged: (_) {},
                cells: [
                  DataCell(AppCheckbox(value: false)),
                  DataCell(
                    Text(
                      '#${index + 1}',
                      style: context.textTheme.labelLarge!.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: item.avatar,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item.username,
                              style: context.textTheme.labelLarge,
                            ),
                            Text(
                              item.userStatus,
                              style: context.textTheme.bodySmall!.copyWith(
                                color:
                                    item.userStatus == 'Active'
                                        ? context.colors.onSurfaceVariantLow
                                        : context.colors.error,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    AppBadge(
                      text: item.activity,
                      color: item.activityColor,
                      prefixIcon: item.activityIcon,
                      size: BadgeSize.large,
                    ),
                  ),
                  DataCell(
                    Text(
                      '+1 (888) 888-888',
                      style: context.textTheme.labelLarge,
                    ),
                  ),
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 4,
                      children: [
                        Text('\$100.00', style: context.textTheme.labelLarge),
                        Text(
                          'USD',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Row(
                      spacing: 12,
                      children: [
                        Text('236 Orders', style: context.textTheme.labelLarge),
                        SizedBox(
                          width: 100,
                          height: 40,
                          child: AppBarSparkline(
                            data: [
                              ChartSeriesData(
                                name: 'Orders',
                                color: context.colors.success,
                                points: [
                                  ChartPoint(name: '1', value: 30),
                                  ChartPoint(name: '2', value: 50),
                                  ChartPoint(name: '3', value: 70),
                                  ChartPoint(name: '4', value: 100),
                                  ChartPoint(name: '5', value: 60),
                                  ChartPoint(name: '6', value: 45),
                                  ChartPoint(name: '7', value: 80),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    AppIconButton(
                      icon: BetterIcons.moreVerticalCircle01Outline,
                      size: ButtonSize.medium,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const AppTableFooter(),
      ],
    );
  }
}
