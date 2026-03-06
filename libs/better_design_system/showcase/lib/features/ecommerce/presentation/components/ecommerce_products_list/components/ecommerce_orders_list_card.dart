import 'package:api_response/api_response.dart';
import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar.dart';
import 'package:better_design_system/organisms/data_table/data_table.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

class Order {
  final String id;
  final String product;
  final String productImage;
  final double price;
  final String createdAt;
  final int quantity;
  final int stockPercent; // for progress bar
  final String status;
  final SemanticColor badgeColor;
  final SemanticColor progressBarColor;

  Order({
    required this.id,
    required this.product,
    required this.productImage,
    required this.price,
    required this.createdAt,
    required this.quantity,
    required this.stockPercent,
    required this.status,
    required this.badgeColor,
    required this.progressBarColor,
  });
}

class EcommerceOrdersListCard extends StatelessWidget {
  const EcommerceOrdersListCard({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      Order(
        id: '#PRD001',
        product: 'Classic T-Shirt',
        productImage: Assets.images.products.classicTShirt.path,
        price: 45.99,
        createdAt: '24 May, 2025',
        quantity: 25,
        stockPercent: 25,
        progressBarColor: SemanticColor.secondary,
        status: 'Published',
        badgeColor: SemanticColor.success,
      ),
      Order(
        id: '#PRD002',
        product: 'Hoodie',
        productImage: Assets.images.products.hoodie.path,
        price: 120.0,
        createdAt: '22 May, 2025',
        quantity: 15,
        stockPercent: 15,
        progressBarColor: SemanticColor.error,
        status: 'Draft',
        badgeColor: SemanticColor.neutral,
      ),
      Order(
        id: '#PRD003',
        product: 'Nike Airforce',
        productImage: Assets.images.products.shoe01.path,
        price: 19.5,
        createdAt: '20 May, 2025',
        quantity: 72,
        stockPercent: 72,
        progressBarColor: SemanticColor.primary,
        status: 'Published',
        badgeColor: SemanticColor.success,
      ),
      Order(
        id: '#PRD004',
        product: 'Polo Shirt',
        productImage: Assets.images.products.poloShirt.path,
        price: 75.0,
        createdAt: '18 May, 2025',
        quantity: 72,
        stockPercent: 72,
        progressBarColor: SemanticColor.primary,
        status: 'Published',
        badgeColor: SemanticColor.success,
      ),
      Order(
        id: '#PRD005',
        product: 'Cargo Pants',
        productImage: Assets.images.products.cargoPants.path,
        price: 250.0,
        createdAt: '15 May, 2025',
        quantity: 25,
        stockPercent: 25,
        progressBarColor: SemanticColor.secondary,
        status: 'Published',
        badgeColor: SemanticColor.success,
      ),
      Order(
        id: '#PRD006',
        product: 'Puffer Jacket',
        productImage: Assets.images.products.pufferJacket.path,
        price: 90.0,
        createdAt: '10 May, 2025',
        quantity: 15,
        stockPercent: 15,
        progressBarColor: SemanticColor.error,
        status: 'Draft',
        badgeColor: SemanticColor.neutral,
      ),
    ];

    final data = ApiResponse<List<Order>>.loaded(orders);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 450,
          width: double.infinity,
          child: AppDataTable<List<Order>, dynamic>(
            data: data,
            minWidth: 1400,
            getPageInfo:
                (_) =>
                    OffsetPageInfo(hasNextPage: false, hasPreviousPage: false),
            getRowCount: (list) => list.length,
            onPageChanged: (_) {},
            paging: OffsetPaging(limit: 10, offset: 0),
            columns: [
              DataColumn(
                label: Row(
                  children: [
                    AppCheckbox(value: false),
                    SizedBox(width: 16),
                    Text("ID"),
                  ],
                ),
              ),
              DataColumn(
                label: Row(
                  children: [
                    Text("Product"),
                    SizedBox(width: 3.3),
                    Icon(
                      BetterIcons.unfoldMoreFilled,
                      color: context.colors.onSurfaceVariantLow,
                      size: 20,
                    ),
                  ],
                ),
              ),
              DataColumn(
                label: Row(
                  children: [
                    Text("Price"),
                    SizedBox(width: 3.3),
                    Icon(
                      BetterIcons.unfoldMoreFilled,
                      color: context.colors.onSurfaceVariantLow,
                      size: 20,
                    ),
                  ],
                ),
              ),
              DataColumn(
                label: Row(
                  children: [
                    Text("Created at"),
                    SizedBox(width: 3.3),
                    Icon(
                      BetterIcons.unfoldMoreFilled,
                      color: context.colors.onSurfaceVariantLow,
                      size: 20,
                    ),
                  ],
                ),
              ),
              DataColumn(
                label: Row(
                  children: [
                    Text("Quantity"),
                    SizedBox(width: 3.3),
                    Icon(
                      BetterIcons.unfoldMoreFilled,
                      color: context.colors.onSurfaceVariantLow,
                      size: 20,
                    ),
                  ],
                ),
              ),
              DataColumn(
                label: Row(
                  children: [
                    Text("Status"),
                    SizedBox(width: 3.3),
                    Icon(
                      BetterIcons.unfoldMoreFilled,
                      color: context.colors.onSurfaceVariantLow,
                      size: 20,
                    ),
                  ],
                ),
              ),
              DataColumn(label: Text('')),
            ],
            rowBuilder: (list, index) {
              final item = list[index];
              return DataRow(
                onSelectChanged: (_) {},
                cells: [
                  DataCell(
                    Row(
                      children: [
                        AppCheckbox(value: false),
                        SizedBox(width: 16),
                        Text(
                          item.id,
                          style: TextStyle(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            item.productImage,
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(item.product),
                      ],
                    ),
                  ),
                  DataCell(
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [Text('\$${item.price.toStringAsFixed(2)}')],
                    ),
                  ),
                  DataCell(
                    Text(
                      item.createdAt,
                      style: TextStyle(color: context.colors.onSurfaceVariant),
                    ),
                  ),
                  DataCell(
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLinearProgressBar(
                          size: LinearProgressBarSize.medium,
                          progress: item.stockPercent / 100,
                          color: item.progressBarColor,
                          linearProgressBarStatus:
                              LinearProgressBarStatus.uploading,
                        ),
                        Text(
                          '${item.quantity} in stock',
                          style: TextStyle(
                            color: context.colors.onSurfaceVariantLow,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    AppBadge(
                      text: item.status,
                      color: item.badgeColor,
                      isRounded: true,
                      size: BadgeSize.large,
                    ),
                  ),
                  DataCell(
                    AppIconButton(
                      icon: BetterIcons.checkmarkCircle02Outline,
                      isCircular: true,
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
