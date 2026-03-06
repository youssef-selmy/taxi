import 'package:api_response/api_response.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
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
  final String orderId;
  final String username;
  final String date;
  final Widget avatar;
  final String amount;
  final String status;
  final SemanticColor statusColor;
  final IconData statusIcon;
  final String paymentStatus;
  final SemanticColor paymentStatusColor;
  Transactions({
    required this.orderId,
    required this.username,
    required this.avatar,
    required this.date,
    required this.amount,
    required this.status,
    required this.statusColor,
    required this.statusIcon,
    required this.paymentStatus,
    required this.paymentStatusColor,
  });
}

class EcommerceOrdersTable extends StatelessWidget {
  const EcommerceOrdersTable({super.key, this.isMobile = false});
  final String date = '30 May, 2025';
  final String price = '\$244.00';
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final orders = [
      Transactions(
        orderId: '#SD009',
        username: 'Corey George',
        avatar: Assets.images.avatars.illustration01.image(
          width: 40,
          height: 40,
        ),
        amount: price,
        date: date,
        status: 'Completed',
        statusColor: SemanticColor.success,
        statusIcon: BetterIcons.checkmarkCircle02Filled,
        paymentStatus: 'Completed',
        paymentStatusColor: SemanticColor.success,
      ),
      Transactions(
        orderId: '#SD008',
        username: 'Ahmad Rosser',
        avatar: Assets.images.avatars.illustration02.image(
          width: 40,
          height: 40,
        ),
        amount: price,
        date: date,
        status: 'Shipping',
        statusColor: SemanticColor.warning,
        statusIcon: BetterIcons.truckFilled,
        paymentStatus: 'Cash on Delivery',
        paymentStatusColor: SemanticColor.neutral,
      ),
      Transactions(
        orderId: '#SD007',
        username: 'Ahmad Siphron',
        avatar: Assets.images.avatars.illustration03.image(
          width: 40,
          height: 40,
        ),
        amount: price,
        date: date,
        status: 'Shipping',
        statusColor: SemanticColor.warning,
        statusIcon: BetterIcons.truckFilled,
        paymentStatus: 'Cash on Delivery',
        paymentStatusColor: SemanticColor.neutral,
      ),
      Transactions(
        orderId: '#SD006',
        username: 'Ashlynn Septimus',
        avatar: Assets.images.avatars.illustration04.image(
          width: 40,
          height: 40,
        ),
        amount: price,
        date: date,
        status: 'Completed',
        statusColor: SemanticColor.success,
        statusIcon: BetterIcons.checkmarkCircle02Filled,
        paymentStatus: 'Completed',
        paymentStatusColor: SemanticColor.success,
      ),
      Transactions(
        orderId: '#SD005',
        username: 'Ann Stanton',
        avatar: Assets.images.avatars.illustration03.image(
          width: 40,
          height: 40,
        ),
        amount: price,
        date: date,
        status: 'Completed',
        statusColor: SemanticColor.success,
        statusIcon: BetterIcons.checkmarkCircle02Filled,
        paymentStatus: 'Completed',
        paymentStatusColor: SemanticColor.success,
      ),
      Transactions(
        orderId: '#SD004',
        username: 'Jocelyn Franci',
        avatar: Assets.images.avatars.illustration04.image(
          width: 40,
          height: 40,
        ),
        amount: price,
        date: date,
        status: 'Canceled',
        statusColor: SemanticColor.error,
        statusIcon: BetterIcons.cancelCircleFilled,
        paymentStatus: 'Not Completed',
        paymentStatusColor: SemanticColor.neutral,
      ),
      Transactions(
        orderId: '#SD003',
        username: 'Ann Levin',
        avatar: Assets.images.avatars.illustration03.image(
          width: 40,
          height: 40,
        ),
        amount: price,
        date: date,
        status: 'Completed',
        statusColor: SemanticColor.success,
        statusIcon: BetterIcons.checkmarkCircle02Filled,
        paymentStatus: 'Completed',
        paymentStatusColor: SemanticColor.success,
      ),
    ];

    final data = ApiResponse<List<Transactions>>.loaded(orders);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 515,
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
              DataColumn2(fixedWidth: 60, label: AppCheckbox(value: false)),
              DataColumn2(
                fixedWidth: 145,
                label: Row(
                  children: [
                    Text('Order ID', style: context.textTheme.bodyMedium),
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
                fixedWidth: 225,
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
                fixedWidth: 200,
                label: Row(
                  children: [
                    Text('Status', style: context.textTheme.bodyMedium),
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
                fixedWidth: 150,
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Payment Status', style: context.textTheme.bodyMedium),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ],
            rowBuilder: (list, index) {
              final item = list[index];
              return DataRow(
                onSelectChanged: (_) {},
                cells: [
                  DataCell(AppCheckbox(value: false)),
                  DataCell(
                    Text(
                      item.orderId,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: context.colors.onSurfaceVariantLow,
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
                    Text(item.date, style: context.textTheme.labelLarge),
                  ),
                  DataCell(
                    AppBadge(
                      text: item.status,
                      color: item.statusColor,
                      prefixIcon: item.statusIcon,
                      isRounded: true,
                      size: BadgeSize.large,
                    ),
                  ),
                  DataCell(
                    Text(item.amount, style: context.textTheme.labelLarge),
                  ),
                  DataCell(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppBadge(
                          text: item.paymentStatus,
                          color: item.paymentStatusColor,
                          isRounded: true,
                          size: BadgeSize.large,
                          style: BadgeStyle.outline,
                        ),
                        const SizedBox(width: 4),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
