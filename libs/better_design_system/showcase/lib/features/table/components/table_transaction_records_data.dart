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

class Transactions {
  final String username;
  final IconData typeIcon;
  final Color typeIconColor;
  final String typeText;
  final Widget paymentMethodImage;
  final String paymentMethodText;
  final String statusText;
  final SemanticColor statusColor;
  final IconData statusIcon;
  final String amount;

  Transactions({
    required this.username,
    this.typeIcon = BetterIcons.arrowUpRight01Outline,
    required this.typeIconColor,
    this.typeText = 'Deposit',
    required this.paymentMethodImage,
    required this.paymentMethodText,
    this.statusText = 'Completed',
    this.statusColor = SemanticColor.success,
    this.statusIcon = BetterIcons.checkmarkCircle02Filled,
    required this.amount,
  });
}

class TableTransactionRecordsData extends StatelessWidget {
  const TableTransactionRecordsData({super.key, this.isMobile = false});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final orders = [
      Transactions(
        username: 'Angel Gouse',
        typeIconColor: context.colors.success,
        paymentMethodImage: Assets.images.paymentMethods.visaPng.image(
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
        paymentMethodText: 'Visa ending in 7830',
        statusText: 'Error',
        statusColor: SemanticColor.error,
        statusIcon: BetterIcons.cancelCircleFilled,
        amount: '+ \$100.00',
      ),
      Transactions(
        username: 'Martin Calzoni',
        typeIconColor: context.colors.success,
        paymentMethodImage: Assets.images.paymentMethods.mastercardPng.image(
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
        paymentMethodText: 'MasterCard ending in 2351',
        amount: '+ \$100.00',
      ),
      Transactions(
        username: 'Marcus Bergson',
        typeIconColor: context.colors.error,
        typeIcon: BetterIcons.arrowDownRight01Outline,
        typeText: 'Withdraw',
        paymentMethodImage: Assets.images.paymentMethods.paypalPng.image(
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
        paymentMethodText: 'PayPal',
        amount: '- \$67.24',
      ),
      Transactions(
        username: 'Abram Bator',
        typeIconColor: context.colors.error,
        typeIcon: BetterIcons.arrowDownRight01Outline,
        typeText: 'Withdraw',
        paymentMethodImage: Assets.images.paymentMethods.mastercardPng.image(
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
        paymentMethodText: 'MasterCard ending in 2351',
        statusText: 'Pending',
        statusColor: SemanticColor.warning,
        statusIcon: BetterIcons.loading03Filled,
        amount: '- \$141.14',
      ),
      Transactions(
        username: 'Alfonso Lipshutz',
        typeIconColor: context.colors.error,
        typeIcon: BetterIcons.arrowDownRight01Outline,
        typeText: 'Withdraw',
        paymentMethodImage: Assets.images.paymentMethods.paypalPng.image(
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
        paymentMethodText: 'PayPal',
        amount: '+ \$100.00',
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
                fixedWidth: 170,
                label: Row(
                  children: [
                    Text('Date & Time', style: context.textTheme.bodyMedium),
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
                fixedWidth: 160,
                label: Row(
                  children: [
                    Text('Type', style: context.textTheme.bodyMedium),
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
                fixedWidth: 200,
                label: Row(
                  children: [
                    Text('Amount', style: context.textTheme.bodyMedium),
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
                fixedWidth: 170,
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
              DataColumn2(
                fixedWidth: 180,
                label: Text(
                  'Reference Number',
                  style: context.textTheme.bodyMedium,
                ),
              ),
              DataColumn2(fixedWidth: 52, label: Text('')),
            ],
            rowBuilder: (list, index) {
              final item = list[index];
              return DataRow(
                onSelectChanged: (_) {},
                cells: [
                  DataCell(AppCheckbox(value: false)),
                  DataCell(
                    Text(
                      '5/7/24, 7:29 PM',
                      style: context.textTheme.labelLarge,
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        Icon(
                          item.typeIcon,
                          color: item.typeIconColor,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.typeText,
                          style: context.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Row(
                      spacing: 8,
                      children: [
                        item.paymentMethodImage,
                        Text(
                          item.paymentMethodText,
                          style: context.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 4,
                      children: [
                        Text(
                          item.amount,
                          style: context.textTheme.labelLarge!.copyWith(
                            color:
                                item.amount.startsWith('+')
                                    ? context.colors.success
                                    : context.colors.error,
                          ),
                        ),
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
                    AppBadge(
                      text: item.statusText,
                      color: item.statusColor,
                      prefixIcon: item.statusIcon,
                      size: BadgeSize.large,
                    ),
                  ),
                  DataCell(Text('12345', style: context.textTheme.labelLarge)),
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
