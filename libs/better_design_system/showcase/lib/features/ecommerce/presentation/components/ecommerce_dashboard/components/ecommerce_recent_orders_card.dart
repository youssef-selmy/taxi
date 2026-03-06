import 'package:api_response/api_response.dart';
import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/organisms/data_table/data_table.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceRecentOrdersCard extends StatelessWidget {
  const EcommerceRecentOrdersCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(BetterIcons.shoppingBag02Outline, size: 24),
              const SizedBox(width: 8),
              Text('Recent Orders', style: context.textTheme.titleSmall),
              const Spacer(),
              AppTextButton(
                onPressed: () {},
                text: 'View more',
                size: ButtonSize.small,
                suffixIcon: BetterIcons.arrowRight02Outline,
                color: SemanticColor.primary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppClickableCard(
            padding: EdgeInsets.zero,
            type: ClickableCardType.elevated,
            elevation: BetterShadow.shadow4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _OrderItem(
                    id: '#SD009',
                    date: '23 May, 2025',
                    customer: 'Jakob Kenter',
                    price: '\$211.24',
                    currency: 'USD',
                    product1: 'Nike Air Force',
                    product2: 'Winter Hoodie',
                    showMore: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17.5),
                    child: AppDivider(),
                  ),
                  _OrderItem(
                    id: '#SD009',
                    date: '23 May, 2025',
                    customer: 'Terry Septimus',
                    price: '\$125.16',
                    currency: 'USD',
                    product1: 'Nike Air Force',
                    product2: 'Winter Hoodie',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17.5),
                    child: AppDivider(),
                  ),
                  _OrderItem(
                    id: '#SD009',
                    date: '23 May, 2025',
                    customer: 'Craig Torff',
                    price: '\$250.00',
                    currency: 'USD',
                    product1: 'Nike Air Force',
                    product2: 'Winter Hoodie',
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return AppClickableCard(
      padding: EdgeInsets.zero,
      type: ClickableCardType.elevated,
      elevation: BetterShadow.shadow16,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(BetterIcons.shoppingBag02Outline, size: 24),
                const SizedBox(width: 8),
                Text('Recent Orders', style: context.textTheme.titleSmall),
                const Spacer(),
                AppTextButton(
                  onPressed: () {},
                  text: 'View more',
                  size: ButtonSize.small,
                  suffixIcon: BetterIcons.arrowRight02Outline,
                  color: SemanticColor.primary,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 255,
              child: AppDataTable(
                data: ApiResponse.loaded([]),
                getPageInfo:
                    (_) => OffsetPageInfo(
                      hasNextPage: false,
                      hasPreviousPage: false,
                    ),
                getRowCount: (_) => 3,
                onPageChanged: (_) {},
                paging: OffsetPaging(limit: 10, offset: 0),
                columns: [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("Date")),
                  DataColumn(label: Text("Product Name")),
                  DataColumn(label: Text("Customer")),
                  DataColumn(label: Text("Price")),
                ],
                rowBuilder: (p0, p1) {
                  return DataRow(
                    onSelectChanged: (_) {},
                    cells: [
                      DataCell(Text("#SD009")),
                      DataCell(Text("23 May, 2025")),
                      DataCell(Text("Nike Air Force..")),
                      DataCell(Text("Jakob Kenter")),
                      DataCell(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("\$120.00"),
                            Text(
                              "USD",
                              style: TextStyle(
                                color: context.colors.onSurfaceVariantLow,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  const _OrderItem({
    required this.id,
    required this.date,
    required this.customer,
    required this.price,
    required this.currency,
    required this.product1,
    required this.product2,
    this.showMore = false,
  });

  final String id;
  final String date;
  final String customer;
  final String price;
  final String currency;
  final String product1;
  final String product2;
  final bool showMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              id,
              style: context.textTheme.labelMedium!.copyWith(
                color: context.colors.onSurfaceVariantLow,
              ),
            ),
            Text(
              date,
              style: context.textTheme.labelMedium!.copyWith(
                color: context.colors.onSurfaceVariantLow,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(customer, style: context.textTheme.labelLarge),
            const Spacer(),
            Text(price, style: context.textTheme.labelLarge),
            const SizedBox(width: 4),
            Text(
              currency,
              style: context.textTheme.labelLarge!.copyWith(
                color: context.colors.onSurfaceVariantLow,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Assets.images.products.image16.image(
                width: 32,
                height: 32,
              ),
            ),
            const SizedBox(width: 8),
            Text(product1, style: context.textTheme.labelMedium),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Assets.images.products.hoodie.image(width: 32, height: 32),
            ),
            const SizedBox(width: 8),
            Text(product2, style: context.textTheme.labelMedium),
          ],
        ),
        if (showMore) const SizedBox(height: 12),
        if (showMore)
          Text(
            '+1 more item',
            style: context.textTheme.labelMedium!.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
      ],
    );
  }
}
