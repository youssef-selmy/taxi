import 'package:api_response/api_response.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_showcase/core/components/table_footer.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/organisms/data_table/data_table.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

class PaymentMethod {
  final IconData icon;
  final String name;

  PaymentMethod({required this.icon, required this.name});
}

class Transactions {
  final String username;
  final Widget avatar;
  Transactions({required this.username, required this.avatar});
}

class TableTransactionsData extends StatelessWidget {
  const TableTransactionsData({super.key, this.isMobile = false});
  final String orderDate = '5/7/24, 7:29 PM';
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
      ),
      Transactions(
        username: 'Martin Calzoni',
        avatar: Assets.images.avatars.illustration02.image(
          width: 40,
          height: 40,
        ),
      ),
      Transactions(
        username: 'Marcus Bergson',
        avatar: Assets.images.avatars.illustration03.image(
          width: 40,
          height: 40,
        ),
      ),
      Transactions(
        username: 'Abram Bator',
        avatar: Assets.images.avatars.illustration04.image(
          width: 40,
          height: 40,
        ),
      ),
      Transactions(
        username: 'Alfonso Lipshutz',
        avatar: Assets.images.avatars.illustration05.image(
          width: 40,
          height: 40,
        ),
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
            minWidth: 1400,
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
                    Text('Customer', style: context.textTheme.bodyMedium),
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
                fixedWidth: 200,
                label: Row(
                  children: [
                    Text('Date', style: context.textTheme.bodyMedium),
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
                fixedWidth: 150,
                label: Row(
                  children: [
                    Text('Price', style: context.textTheme.bodyMedium),
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
                fixedWidth: 271.5,
                label: Row(
                  children: [
                    Text('Payment Method', style: context.textTheme.bodyMedium),
                    const SizedBox(width: 4),
                    Icon(
                      BetterIcons.unfoldMoreFilled,
                      color: context.colors.onSurfaceVariantLow,
                      size: 20,
                    ),
                  ],
                ),
              ),
              DataColumn2(
                fixedWidth: 160,
                label: Row(
                  children: [
                    Text('Status', style: context.textTheme.bodyMedium),
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
                        Text(
                          item.username,
                          style: context.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Text(
                      '5/7/24, 7:29 PM',
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
                      spacing: 8,
                      children: [
                        Assets.images.paymentMethods.visaPng.image(
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          'Visa ending in 7830',
                          style: context.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    AppBadge(
                      text: 'Completed',
                      color: SemanticColor.success,
                      size: BadgeSize.large,
                      prefixIcon: BetterIcons.checkmarkCircle02Filled,
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
