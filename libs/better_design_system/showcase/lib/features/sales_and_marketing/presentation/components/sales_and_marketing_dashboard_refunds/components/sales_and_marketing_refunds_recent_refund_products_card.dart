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
  final String reason;
  final String price;

  _Product({
    required this.productImage,
    required this.productName,
    required this.customerName,
    required this.customerNumber,
    required this.reason,
    required this.price,
  });
}

class SalesAndMarketingRefundsRecentRefundProductsCard extends StatelessWidget {
  final bool isMobile;

  SalesAndMarketingRefundsRecentRefundProductsCard({
    super.key,
    this.isMobile = false,
  });

  final products = [
    _Product(
      productImage: Assets.images.products.image03,
      productName: 'Nike Streakfly',
      customerName: 'Francis Marsh',
      customerNumber: '203-852-7175',
      reason: 'Product Not as Expected',
      price: '\$15.00',
    ),
    _Product(
      productImage: Assets.images.products.image11,
      productName: 'Nike Air Force',
      customerName: 'Warren Byrd',
      customerNumber: '580-353-0267',
      reason: 'Product Not as Expected',
      price: '\$19.00',
    ),

    _Product(
      productImage: Assets.images.products.image12,
      productName: 'Samba OG Skor',
      customerName: 'Lizzie Motsinger',
      customerNumber: '708-345-3951',
      reason: 'Product Not as Expected',

      price: '\$11.00',
    ),
    _Product(
      productImage: Assets.images.products.image13,
      productName: 'Nike Pegasus 41',
      customerName: 'Jerry Elliott',
      customerNumber: '708-345-3951',
      reason: 'Product Not as Expected',
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
            Text('Recent Refund Products', style: context.textTheme.titleSmall),
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
                      _buildProductAvatar(
                        product.productName,
                        product.productImage,
                        context,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: context.colors.onSurface.withValues(
                            alpha: 0.12,
                          ),
                        ),
                        child: Row(
                          spacing: 4,
                          children: [
                            Icon(
                              BetterIcons.alertCircleFilled,
                              size: 16,
                              color: context.colors.onSurfaceVariant,
                            ),
                            Text(
                              product.reason,
                              style: context.textTheme.labelMedium?.variant(
                                context,
                              ),
                            ),
                          ],
                        ),
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
              // minWidth: 1400,
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
                  label: Text('Item', style: context.textTheme.bodyMedium),
                ),
                DataColumn(
                  label: Text('Customer', style: context.textTheme.bodyMedium),
                ),
                DataColumn(
                  label: Text('Reason', style: context.textTheme.bodyMedium),
                ),
                DataColumn(
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
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                      Text(product.reason, style: context.textTheme.labelLarge),
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
          Text('Recent Refund Products', style: context.textTheme.titleSmall),
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
