import 'package:api_response/api_response.dart';
import 'package:better_design_showcase/core/components/table_footer.dart';
import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/data_table/data_table.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

class _Product {
  final AssetGenImage productImage;
  final String productName;
  final String customerName;
  final String customerNumber;
  final String qty;
  final String price;

  _Product({
    required this.productImage,
    required this.productName,
    required this.customerName,
    required this.customerNumber,
    required this.qty,
    required this.price,
  });
}

class SalesAndMarketingAnalyticsRecentSalesOrderCard extends StatelessWidget {
  final bool isMobile;

  SalesAndMarketingAnalyticsRecentSalesOrderCard({
    super.key,
    this.isMobile = false,
  });

  final products = [
    _Product(
      productImage: Assets.images.products.image03,
      productName: 'Nike Streakfly',
      customerName: 'Francis Marsh',
      customerNumber: '203-852-7175',
      qty: '1 Pcs',

      price: '\$15.00',
    ),
    _Product(
      productImage: Assets.images.products.image11,
      productName: 'Nike Air Force',
      customerName: 'Warren Byrd',
      customerNumber: '580-353-0267',
      qty: '1 Pcs',

      price: '\$19.00',
    ),

    _Product(
      productImage: Assets.images.products.image12,
      productName: 'Samba OG Skor',
      customerName: 'Lizzie Motsinger',
      customerNumber: '708-345-3951',
      qty: '1 Pcs',

      price: '\$11.00',
    ),
    _Product(
      productImage: Assets.images.products.image13,
      productName: 'Nike Pegasus 41',
      customerName: 'Jerry Elliott',
      customerNumber: '708-345-3951',
      qty: '1 Pcs',
      price: '\$12.90',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final data = ApiResponse<List<_Product>>.loaded(products);
    return isMobile
        ? _buildCards(context, products)
        : _buildTable(context, data);
  }

  Widget _buildCards(BuildContext context, List<_Product> products) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Sales Order', style: context.textTheme.titleSmall),
            AppTextButton(
              size: ButtonSize.medium,
              onPressed: () {},
              text: 'See all',
              suffixIcon: BetterIcons.arrowRight02Outline,
              color: SemanticColor.primary,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          spacing: 8,
          children:
              products.map((product) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    border: Border.all(color: context.colors.outline),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    spacing: 12,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                product.customerName,
                                style: context.textTheme.labelLarge,
                              ),
                              Text(
                                product.customerNumber,
                                style: context.textTheme.bodySmall?.variant(
                                  context,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            product.price,
                            style: context.textTheme.labelLarge,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildProductAvatar(
                            product.productName,
                            product.productImage,
                            context,
                          ),
                          Text(
                            product.qty,
                            style: context.textTheme.labelLarge?.variant(
                              context,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildTable(BuildContext context, ApiResponse<List<_Product>> data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          _buildHeader(context),
          SizedBox(
            height: 350,
            child: AppDataTable<List<_Product>, dynamic>(
              minWidth: 1400,
              data: data,
              getPageInfo:
                  (_) => OffsetPageInfo(
                    hasNextPage: false,
                    hasPreviousPage: false,
                  ),
              getRowCount: (list) => list.length,
              onPageChanged: (_) {},
              paging: OffsetPaging(limit: 4, offset: 0),
              columns: [
                DataColumn2(
                  fixedWidth: 180,
                  label: Text('Item', style: context.textTheme.bodyMedium),
                ),
                DataColumn2(
                  fixedWidth: 180,
                  label: Text('Customer', style: context.textTheme.bodyMedium),
                ),
                DataColumn2(
                  fixedWidth: 100,
                  label: Text('Qty', style: context.textTheme.bodyMedium),
                ),
                DataColumn2(
                  fixedWidth: 110,
                  label: Text('Price', style: context.textTheme.bodyMedium),
                ),

                const DataColumn2(fixedWidth: 120, label: SizedBox.shrink()),
              ],
              rowBuilder: (list, index) {
                final product = list[index];
                return DataRow(
                  onSelectChanged: (_) {},
                  cells: [
                    DataCell(
                      _buildProductAvatar(
                        product.productName,
                        product.productImage,
                        context,
                      ),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Text(
                            product.customerName,
                            style: context.textTheme.labelLarge,
                          ),
                          Text(
                            product.customerNumber,
                            style: context.textTheme.bodySmall?.variant(
                              context,
                            ),
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Text(product.qty, style: context.textTheme.labelLarge),
                    ),
                    DataCell(
                      Text(product.price, style: context.textTheme.labelLarge),
                    ),

                    DataCell(
                      AppOutlinedButton(
                        text: 'Details',
                        color: SemanticColor.neutral,
                        size: ButtonSize.medium,
                        onPressed: () {},
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

  Widget _buildProductAvatar(
    String title,
    AssetGenImage image,
    BuildContext context,
  ) {
    return Row(
      spacing: 8,
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(6),
          child: image.image(width: 40, height: 40),
        ),
        Text(title, style: context.textTheme.labelLarge?.variantLow(context)),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Recent Sales Order', style: context.textTheme.titleSmall),
          Row(
            children: [
              SizedBox(
                width: 270,
                child: AppTextField(
                  isFilled: false,
                  density: TextFieldDensity.noDense,
                  hint: 'Search',
                  prefixIcon: Icon(
                    BetterIcons.search01Filled,
                    color: context.colors.onSurfaceVariant,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: 16),
              AppIconButton(
                onPressed: () {},
                style: IconButtonStyle.outline,
                size: ButtonSize.medium,
                icon: BetterIcons.filterHorizontalOutline,
              ),
              SizedBox(width: 12),
              AppIconButton(
                onPressed: () {},
                style: IconButtonStyle.outline,
                size: ButtonSize.medium,
                icon: BetterIcons.moreVerticalCircle01Filled,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
