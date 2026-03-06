import 'package:better_design_showcase/gen/assets.gen.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';

class SalesAndMarketingAnalyticsTopSpendingItemCard extends StatelessWidget {
  final bool isMobile;
  const SalesAndMarketingAnalyticsTopSpendingItemCard({
    super.key,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        if (isMobile) _buildHeader(context),
        Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.colors.outline),
          ),
          child: Column(
            children: [
              if (!isMobile) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildHeader(context),
                ),
                SizedBox(height: 16),
                AppDivider(height: 1),
              ],

              // Transaction list
              isMobile
                  ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ..._transactions
                            .map(
                              (transaction) => _TransactionItem(
                                name: transaction['name'] as String,
                                description:
                                    transaction['description'] as String,
                                amount: transaction['count'] as String,
                                imageUrl:
                                    transaction['imageUrl'] as AssetGenImage,
                              ),
                            )
                            .toList()
                            .separated(separator: AppDivider(height: 28)),
                      ],
                    ),
                  )
                  : SizedBox(
                    height: 308,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ..._transactions
                              .map(
                                (transaction) => _TransactionItem(
                                  name: transaction['name'] as String,
                                  description:
                                      transaction['description'] as String,
                                  amount: transaction['count'] as String,
                                  imageUrl:
                                      transaction['imageUrl'] as AssetGenImage,
                                ),
                              )
                              .toList()
                              .separated(separator: AppDivider(height: 28)),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Last Transaction', style: context.textTheme.titleSmall),
        SizedBox(
          width: 105,
          child: AppDropdownField.single(
            items: [
              AppDropdownItem(value: 'Today', title: 'Today'),

              AppDropdownItem(value: 'Yesterday', title: 'Yesterday'),
            ],
            isFilled: false,
            initialValue: 'Today',
            type: DropdownFieldType.compact,
            prefixIcon: BetterIcons.calendar03Outline,
          ),
        ),
      ],
    );
  }

  static final _transactions = [
    {
      'name': 'James Kennedy',
      'description': 'Complete Order',
      'count': '1631',
      'imageUrl': Assets.images.products.image03,
    },
    {
      'name': 'Marvin Epps',
      'description': 'Complete Order',
      'count': '1555',
      'imageUrl': Assets.images.products.image16,
    },
    {
      'name': 'Ronald Bolling',
      'description': 'Complete Order',
      'count': '1320',
      'imageUrl': Assets.images.products.image11,
    },
    {
      'name': 'Dottie Glisson',
      'description': 'Complete Order',
      'count': '987',
      'imageUrl': Assets.images.products.image12,
    },
    {
      'name': 'Harriet R. Grimm',
      'description': 'Complete Order',
      'count': '750',
      'imageUrl': Assets.images.products.image13,
    },
    {
      'name': 'Audrey Russo',
      'description': 'Complete Order',
      'count': '699',
      'imageUrl': Assets.images.products.image14,
    },
  ];
}

class _TransactionItem extends StatelessWidget {
  final String name;
  final String description;
  final String amount;
  final AssetGenImage imageUrl;

  const _TransactionItem({
    required this.name,
    required this.description,
    required this.amount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(8),
          child: imageUrl.image(width: 40, height: 40, fit: BoxFit.cover),
        ),
        Expanded(child: Text(name, style: context.textTheme.labelLarge)),
        Text(amount, style: context.textTheme.titleSmall),
      ],
    );
  }
}
