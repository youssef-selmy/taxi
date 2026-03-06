import 'package:api_response/api_response.dart';
import 'package:better_design_showcase/core/components/table_footer.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/organisms/data_table/data_table.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

enum _OrderStatus { complete, reject }

class _Order {
  final String orderId;
  final String customerName;
  final String date;
  final String orderamount;
  final String currency;
  final _OrderStatus status;

  _Order({
    required this.orderId,
    required this.customerName,
    required this.date,
    required this.orderamount,
    required this.currency,
    required this.status,
  });
}

class SalesAndMarketingOrdersCard extends StatelessWidget {
  final bool isMobile;
  const SalesAndMarketingOrdersCard({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final orders = [
      _Order(
        orderId: '#123456',
        customerName: 'Angel Gouse',
        date: '21 Oct 2025',
        orderamount: '\$100.01',
        currency: 'USD',
        status: _OrderStatus.complete,
      ),
      _Order(
        orderId: '#123456',
        customerName: 'Martin Calzoni',
        date: '25 Jan 2025',
        orderamount: '\$201.98',
        currency: 'USD',
        status: _OrderStatus.reject,
      ),
      _Order(
        orderId: '#123456',
        customerName: 'Marcus Bergson',
        date: '05 Oct 2025',
        orderamount: '\$98.65',
        currency: 'USD',
        status: _OrderStatus.complete,
      ),
      _Order(
        orderId: '#123456',
        customerName: 'Abram Bator',
        date: '08 Oct 2025',
        orderamount: '\$59.51',
        currency: 'USD',
        status: _OrderStatus.reject,
      ),
      _Order(
        orderId: '#123456',
        customerName: 'Alfonso Lipshutz',
        date: '11 Sep 2025',
        orderamount: '\$78.41',
        currency: 'USD',
        status: _OrderStatus.complete,
      ),
    ];

    final data = ApiResponse<List<_Order>>.loaded(orders);

    return isMobile ? _buildCards(context, orders) : _buildTable(context, data);
  }

  Widget _buildCards(BuildContext context, List<_Order> orders) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Orders', style: context.textTheme.titleSmall),
            AppTextButton(
              size: ButtonSize.medium,
              onPressed: () {},
              text: 'See all',
              suffixIcon: BetterIcons.arrowRight02Outline,
              color: SemanticColor.primary,
            ),
          ],
        ),
        SizedBox(height: 16),

        Column(
          spacing: 8,
          children: List.generate(orders.length, (index) {
            final order = orders[index];
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.colors.surface,
                border: Border.all(color: context.colors.outline),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                spacing: 12,
                children: [
                  Row(
                    spacing: 8,
                    children: <Widget>[
                      Text(order.orderId, style: context.textTheme.labelMedium),
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: context.colors.outlineVariant,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(order.date, style: context.textTheme.labelMedium),
                      Spacer(),
                      _buildStatus(order.status),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildAvatar(
                        context,
                        avatarUrl: ImageFaker().person.images[index],
                        name: order.customerName,
                      ),

                      Row(
                        spacing: 4,
                        children: <Widget>[
                          Text(
                            order.orderamount,
                            style: context.textTheme.labelLarge,
                          ),
                          Text(
                            order.currency,
                            style: context.textTheme.labelLarge?.variant(
                              context,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTable(BuildContext context, ApiResponse<List<_Order>> data) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Orders', style: context.textTheme.titleSmall),
                AppIconButton(
                  onPressed: () {},
                  style: IconButtonStyle.outline,
                  size: ButtonSize.medium,
                  icon: BetterIcons.moreVerticalCircle01Filled,
                ),
              ],
            ),
          ),
          AppDivider(height: 20),
          SizedBox(height: 16),
          SizedBox(
            height: 385,
            child: AppDataTable<List<_Order>, dynamic>(
              data: data,
              getPageInfo:
                  (_) => OffsetPageInfo(
                    hasNextPage: false,
                    hasPreviousPage: false,
                  ),

              getRowCount: (list) => list.length,
              onPageChanged: (_) {},
              paging: OffsetPaging(limit: 10, offset: 0),
              columns: [
                DataColumn2(fixedWidth: 60, label: AppCheckbox(value: false)),
                DataColumn2(
                  fixedWidth: 140,
                  label: Row(
                    children: [
                      Text('Order ID', style: context.textTheme.bodyMedium),
                      SizedBox(width: 4),
                      _buildSortIcon(context),
                    ],
                  ),
                ),
                DataColumn2(
                  fixedWidth: 215,
                  label: Row(
                    children: [
                      Text('Customer', style: context.textTheme.bodyMedium),
                      SizedBox(width: 4),
                      _buildSortIcon(context),
                    ],
                  ),
                ),
                DataColumn2(
                  fixedWidth: 140,
                  label: Row(
                    children: [
                      Text('Date', style: context.textTheme.bodyMedium),
                      SizedBox(width: 4),
                      _buildSortIcon(context),
                    ],
                  ),
                ),

                DataColumn2(
                  fixedWidth: 180,
                  label: Row(
                    children: [
                      Text('Order amount', style: context.textTheme.bodyMedium),
                      SizedBox(width: 4),
                      _buildSortIcon(context),
                    ],
                  ),
                ),
                DataColumn2(
                  fixedWidth: 150,
                  label: Row(
                    children: [
                      Text('Status', style: context.textTheme.bodyMedium),
                      SizedBox(width: 4),
                      _buildSortIcon(context),
                    ],
                  ),
                ),
                DataColumn2(fixedWidth: 90, label: Text('')),
              ],
              rowBuilder: (list, index) {
                final order = list[index];
                return DataRow(
                  onSelectChanged: (_) {},
                  cells: [
                    DataCell(AppCheckbox(value: false)),
                    DataCell(
                      Text(
                        order.orderId,
                        style: context.textTheme.labelLarge?.variant(context),
                      ),
                    ),
                    DataCell(
                      _buildAvatar(
                        context,
                        avatarUrl: ImageFaker().person.images[index],
                        name: order.customerName,
                      ),
                    ),
                    DataCell(
                      Text(order.date, style: context.textTheme.labelLarge),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 4,
                        children: [
                          Text(
                            order.orderamount,
                            style: context.textTheme.labelLarge,
                          ),
                          Text(
                            order.currency,
                            style: context.textTheme.bodySmall?.variant(
                              context,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(_buildStatus(order.status)),
                    DataCell(
                      AppIconButton(
                        icon: BetterIcons.moreVerticalCircle01Outline,
                        isCircular: true,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          AppTableFooter(),
        ],
      ),
    );
  }

  Widget _buildSortIcon(BuildContext context) {
    return Icon(
      BetterIcons.unfoldMoreFilled,
      color: context.colors.onSurfaceVariantLow,
      size: 20,
    );
  }

  Widget _buildAvatar(
    BuildContext context, {
    required String avatarUrl,
    required String name,
  }) {
    return Row(
      spacing: 8,
      children: [
        AppAvatar(imageUrl: avatarUrl, size: AvatarSize.size40px),
        Text(name, style: context.textTheme.labelLarge),
      ],
    );
  }

  Widget _buildStatus(_OrderStatus status) {
    return AppTag(
      prefixIcon: switch (status) {
        _OrderStatus.complete => BetterIcons.checkmarkCircle02Filled,
        _OrderStatus.reject => BetterIcons.cancelCircleFilled,
      },
      text: switch (status) {
        _OrderStatus.complete => 'Complete',
        _OrderStatus.reject => 'Reject',
      },
      color: switch (status) {
        _OrderStatus.complete => SemanticColor.success,
        _OrderStatus.reject => SemanticColor.error,
      },
    );
  }
}
