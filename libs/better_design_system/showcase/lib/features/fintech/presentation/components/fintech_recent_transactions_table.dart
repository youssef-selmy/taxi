import 'package:api_response/api_response.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/data_table/data_table.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

class PaymentMethod {
  final IconData icon;
  final String name;

  PaymentMethod({required this.icon, required this.name});
}

class Transaction {
  final String username;
  final String date;
  final Widget avatar;
  final String amount;
  final String account;
  final PaymentMethod paymentMethod;
  Transaction({
    required this.username,
    required this.avatar,
    required this.date,
    required this.amount,
    required this.account,
    required this.paymentMethod,
  });
}

class FintechRecentTransactionsTable extends StatelessWidget {
  const FintechRecentTransactionsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      Transaction(
        username: 'Angel Gouse',
        avatar: Assets.images.avatars.illustration01.image(
          width: 40,
          height: 40,
        ),
        account: 'AP',
        amount: '\$100.00',
        date: '5/7/24, 7:29 PM',
        paymentMethod: PaymentMethod(
          icon: BetterIcons.globe02Filled,
          name: 'Visa ending in 7830',
        ),
      ),
      Transaction(
        username: 'Martin Calzoni',
        avatar: Assets.images.avatars.illustration02.image(
          width: 40,
          height: 40,
        ),
        account: 'Checking',
        amount: '\$100.00',
        date: '5/7/24, 7:29 PM',
        paymentMethod: PaymentMethod(
          icon: BetterIcons.arrowUp02Outline,
          name: 'Visa ending in 7830',
        ),
      ),
      Transaction(
        username: 'Marcus Bergson',
        avatar: Assets.images.avatars.illustration03.image(
          width: 40,
          height: 40,
        ),
        account: 'Ops Payroll',
        amount: '\$100.00',
        date: '5/7/24, 7:29 PM',
        paymentMethod: PaymentMethod(
          icon: BetterIcons.arrowDown02Outline,
          name: 'Visa ending in 7830',
        ),
      ),
      Transaction(
        username: 'Abram Bator',
        avatar: Assets.images.avatars.illustration04.image(
          width: 40,
          height: 40,
        ),
        account: 'Checking',
        amount: '\$100.00',
        date: '5/7/24, 7:29 PM',
        paymentMethod: PaymentMethod(
          icon: BetterIcons.bankFilled,
          name: 'Visa ending in 7830',
        ),
      ),
    ];

    final data = ApiResponse<List<Transaction>>.loaded(orders);

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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  spacing: 8,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        border: Border.all(color: context.colors.outline),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        BetterIcons.arrowUpDownOutline,
                        size: 24,
                        color: context.colors.onSurface,
                      ),
                    ),
                    Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Recent Transactions',
                          style: context.textTheme.titleSmall,
                        ),
                        Text(
                          'Display the recent transactions in the table below.',
                          style: context.textTheme.bodyMedium?.variant(context),
                        ),
                      ],
                    ),
                  ],
                ),

                Row(
                  spacing: 16,
                  children: <Widget>[
                    SizedBox(
                      width: 270,
                      child: AppTextField(
                        fillColor: context.colors.surface,
                        density: TextFieldDensity.dense,
                        hint: 'Search',
                        prefixIcon: Icon(
                          BetterIcons.search01Filled,
                          color: context.colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                    AppOutlinedButton(
                      onPressed: () {},
                      text: 'View All',
                      color: SemanticColor.neutral,
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppDivider(height: 20),
          SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: AppDataTable<List<Transaction>, dynamic>(
              minWidth: 1400,
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
                DataColumn(
                  label: Row(
                    children: [
                      Text('To / From', style: context.textTheme.bodyMedium),
                      SizedBox(width: 4),
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
                DataColumn(
                  label: Row(
                    children: [
                      Text('Amount', style: context.textTheme.bodyMedium),
                      SizedBox(width: 4),
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
                      Text('Account', style: context.textTheme.bodyMedium),
                      SizedBox(width: 4),
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
                      Text(
                        'Payment Method',
                        style: context.textTheme.bodyMedium,
                      ),
                      SizedBox(width: 4),
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
                    DataCell(AppCheckbox(value: false)),
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
                      Text(item.amount, style: context.textTheme.labelLarge),
                    ),
                    DataCell(
                      Text(item.account, style: context.textTheme.labelLarge),
                    ),
                    DataCell(
                      Row(
                        spacing: 8,
                        children: [
                          Icon(
                            item.paymentMethod.icon,
                            color: context.colors.onSurfaceVariantLow,
                            size: 24,
                          ),
                          Text(
                            item.paymentMethod.name,
                            style: context.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
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
        ],
      ),
    );
  }
}
