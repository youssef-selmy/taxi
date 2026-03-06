import 'package:api_response/api_response.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_showcase/core/components/table_footer.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
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
  final String orderDate;
  final Widget avatar;
  final String totalAmount;
  final String shippingStatus;
  final SemanticColor shippingStatusColor;
  final String paymentStatus;
  final SemanticColor paymentStatusColor;
  Transactions({
    required this.username,
    required this.avatar,
    required this.orderDate,
    required this.totalAmount,
    required this.shippingStatus,
    required this.shippingStatusColor,
    required this.paymentStatus,
    required this.paymentStatusColor,
  });
}

class PaginationOrdersTable extends StatelessWidget {
  const PaginationOrdersTable({super.key, this.isMobile = false});
  final String orderDate = '21 Jun 2024';
  final String price = '\$1.000';
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final orders = [
      Transactions(
        username: 'Kevin Carlson',
        avatar: Assets.images.avatars.real01.image(width: 40, height: 40),
        totalAmount: price,
        orderDate: orderDate,
        shippingStatus: 'Delivery',
        shippingStatusColor: SemanticColor.success,
        paymentStatus: 'Paid',
        paymentStatusColor: SemanticColor.success,
      ),
      Transactions(
        username: 'Felicita Acosta',
        avatar: Assets.images.avatars.real02.image(width: 40, height: 40),
        totalAmount: price,
        orderDate: orderDate,
        shippingStatus: 'Payment under review',
        shippingStatusColor: SemanticColor.neutral,
        paymentStatus: 'Under review',
        paymentStatusColor: SemanticColor.neutral,
      ),
      Transactions(
        username: 'Zachary Hawks',
        avatar: Assets.images.avatars.real03.image(width: 40, height: 40),
        totalAmount: price,
        orderDate: orderDate,
        shippingStatus: 'No payment received',
        shippingStatusColor: SemanticColor.error,
        paymentStatus: 'Abandoned',
        paymentStatusColor: SemanticColor.error,
      ),
      Transactions(
        username: 'Timothy Johnson',
        avatar: Assets.images.avatars.real04.image(width: 40, height: 40),
        totalAmount: price,
        orderDate: orderDate,
        shippingStatus: 'Sending',
        shippingStatusColor: SemanticColor.warning,
        paymentStatus: 'On the spot',
        paymentStatusColor: SemanticColor.warning,
      ),
      Transactions(
        username: 'Alberta Clark',
        avatar: Assets.images.avatars.real05.image(width: 40, height: 40),
        totalAmount: price,
        orderDate: orderDate,
        shippingStatus: 'Preparing',
        shippingStatusColor: SemanticColor.neutral,
        paymentStatus: 'Paid',
        paymentStatusColor: SemanticColor.success,
      ),
      Transactions(
        username: 'Megan Pettus',
        avatar: Assets.images.avatars.real06.image(width: 40, height: 40),
        totalAmount: price,
        orderDate: orderDate,
        shippingStatus: 'Canceled',
        shippingStatusColor: SemanticColor.error,
        paymentStatus: 'Canceled',
        paymentStatusColor: SemanticColor.error,
      ),
      Transactions(
        username: 'Linda J. Bell',
        avatar: Assets.images.avatars.real07.image(width: 40, height: 40),
        totalAmount: price,
        orderDate: orderDate,
        shippingStatus: 'Preparing',
        shippingStatusColor: SemanticColor.neutral,
        paymentStatus: 'Paid',
        paymentStatusColor: SemanticColor.success,
      ),
    ];

    final data = ApiResponse<List<Transactions>>.loaded(orders);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 580,
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
              DataColumn2(
                fixedWidth: 100,
                label: Text('Order ID', style: context.textTheme.bodyMedium),
              ),
              DataColumn2(
                fixedWidth: 220,
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
                fixedWidth: 198,
                label: Row(
                  children: [
                    Text('Order Date', style: context.textTheme.bodyMedium),
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
                fixedWidth: 198,
                label: Row(
                  children: [
                    Text('Total Amount', style: context.textTheme.bodyMedium),
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
                fixedWidth: 198,
                label: Row(
                  children: [
                    Text('Payment Status', style: context.textTheme.bodyMedium),
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
                fixedWidth: 198,
                label: Row(
                  children: [
                    Text(
                      'Shipping status',
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      BetterIcons.unfoldMoreFilled,
                      color: context.colors.onSurfaceVariantLow,
                      size: 20,
                    ),
                  ],
                ),
              ),
              DataColumn2(fixedWidth: 48, label: Text('')),
            ],
            rowBuilder: (list, index) {
              final item = list[index];
              return DataRow(
                onSelectChanged: (_) {},
                cells: [
                  DataCell(
                    Text(
                      '12345678',
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
                    Text(item.orderDate, style: context.textTheme.labelLarge),
                  ),
                  DataCell(
                    Text(item.totalAmount, style: context.textTheme.labelLarge),
                  ),
                  DataCell(
                    Row(
                      children: [
                        AppBadge(
                          text: item.paymentStatus,
                          color: item.paymentStatusColor,
                          size: BadgeSize.large,
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    AppBadge(
                      text: item.shippingStatus,
                      color: item.shippingStatusColor,
                      size: BadgeSize.large,
                    ),
                  ),
                  DataCell(
                    AppIconButton(
                      icon: BetterIcons.moreHorizontalCircle01Filled,
                      size: ButtonSize.small,
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
