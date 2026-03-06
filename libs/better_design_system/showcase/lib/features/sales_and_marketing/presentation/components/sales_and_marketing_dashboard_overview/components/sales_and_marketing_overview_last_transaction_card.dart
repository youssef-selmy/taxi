import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

/// Last Transaction card showing recent customer transactions.
///
/// Displays a list of the most recent transactions with customer
/// avatars, names, transaction types, and amounts.
class SalesAndMarketingOverviewLastTransactionCard extends StatelessWidget {
  final bool isMobile;
  const SalesAndMarketingOverviewLastTransactionCard({
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
              if (!isMobile)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildHeader(context),
                ),
              // Transaction list
              isMobile
                  ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 16,
                      children: [
                        ..._transactions.map(
                          (transaction) => _TransactionItem(
                            name: transaction['name'] as String,
                            description: transaction['description'] as String,
                            amount: transaction['amount'] as String,
                            imageUrl: transaction['imageUrl'],
                          ),
                        ),
                      ],
                    ),
                  )
                  : SizedBox(
                    height: 308,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        spacing: 16,
                        children: [
                          ..._transactions.map(
                            (transaction) => _TransactionItem(
                              name: transaction['name'] as String,
                              description: transaction['description'] as String,
                              amount: transaction['amount'] as String,
                              imageUrl: transaction['imageUrl'],
                            ),
                          ),
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
      'amount': '\$22.50',
      'imageUrl': ImageFaker().person.one,
    },
    {
      'name': 'Marvin Epps',
      'description': 'Complete Order',
      'amount': '\$22.50',
      'imageUrl': ImageFaker().person.two,
    },
    {
      'name': 'Ronald Bolling',
      'description': 'Complete Order',
      'amount': '\$22.50',
      'imageUrl': ImageFaker().person.three,
    },
    {
      'name': 'Dottie Glisson',
      'description': 'Complete Order',
      'amount': '\$22.50',
      'imageUrl': ImageFaker().person.four,
    },
    {
      'name': 'Harriet R. Grimm',
      'description': 'Complete Order',
      'amount': '\$22.50',
      'imageUrl': ImageFaker().person.five,
    },
    {
      'name': 'Audrey Russo',
      'description': 'Complete Order',
      'amount': '\$22.50',
      'imageUrl': ImageFaker().person.six,
    },
  ];
}

class _TransactionItem extends StatelessWidget {
  final String name;
  final String description;
  final String amount;
  final String? imageUrl;

  const _TransactionItem({
    required this.name,
    required this.description,
    required this.amount,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        AppAvatar(size: AvatarSize.size40px, imageUrl: imageUrl),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(name, style: context.textTheme.labelLarge),
              Text(
                description,
                style: context.textTheme.bodySmall?.variant(context),
              ),
            ],
          ),
        ),
        Text(amount, style: context.textTheme.titleSmall),
      ],
    );
  }
}
