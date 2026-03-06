import 'package:api_response/api_response.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:better_design_system/organisms/data_table/data_table.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

enum TransactionStatus { complete, reject }

class PaymentMethod {
  final Widget icon;
  final String number;

  PaymentMethod({required this.icon, required this.number});
}

class Transaction {
  final String date;
  final String amount;
  final String transaction;
  final PaymentMethod paymentMethod;
  final TransactionStatus status;
  Transaction({
    required this.date,
    required this.amount,
    required this.transaction,
    required this.paymentMethod,
    required this.status,
  });
}

class FintechTransactionsTable extends StatelessWidget {
  const FintechTransactionsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      Transaction(
        date: '5/7/24, 7:29 PM',
        amount: '\$100.00',
        transaction: 'You sent money to Sara',
        paymentMethod: PaymentMethod(
          icon: Assets.images.paymentMethods.mastercardPng.image(
            height: 24,
            width: 24,
            fit: BoxFit.cover,
          ),
          number: 'Visa ending in 7830',
        ),
        status: TransactionStatus.complete,
      ),
      Transaction(
        amount: '\$100.00',
        date: '5/7/24, 7:29 PM',
        transaction: 'You sent money to Sara',
        paymentMethod: PaymentMethod(
          icon: Assets.images.paymentMethods.mastercardPng.image(
            height: 24,
            width: 24,
            fit: BoxFit.cover,
          ),
          number: 'Visa ending in 7830',
        ),
        status: TransactionStatus.reject,
      ),
      Transaction(
        amount: '\$100.00',
        date: '5/7/24, 7:29 PM',
        transaction: 'You sent money to Sara',
        paymentMethod: PaymentMethod(
          icon: Assets.images.paymentMethods.mastercardPng.image(
            height: 24,
            width: 24,
            fit: BoxFit.cover,
          ),
          number: 'Visa ending in 7830',
        ),
        status: TransactionStatus.complete,
      ),
      Transaction(
        amount: '\$100.00',
        date: '5/7/24, 7:29 PM',
        transaction: 'You sent money to Sara',
        paymentMethod: PaymentMethod(
          icon: Assets.images.paymentMethods.mastercardPng.image(
            height: 24,
            width: 24,
            fit: BoxFit.cover,
          ),
          number: 'Visa ending in 7830',
        ),
        status: TransactionStatus.reject,
      ),
      Transaction(
        amount: '\$100.00',
        date: '5/7/24, 7:29 PM',
        transaction: 'You sent money to Sara',
        paymentMethod: PaymentMethod(
          icon: Assets.images.paymentMethods.mastercardPng.image(
            height: 24,
            width: 24,
            fit: BoxFit.cover,
          ),
          number: 'Visa ending in 7830',
        ),
        status: TransactionStatus.complete,
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
                    Text('Transactions', style: context.textTheme.titleSmall),
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
                      Text('Transaction', style: context.textTheme.bodyMedium),
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
                DataColumn(
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
                DataColumn(label: Text('')),
              ],
              rowBuilder: (list, index) {
                final item = list[index];
                return DataRow(
                  onSelectChanged: (_) {},
                  cells: [
                    DataCell(AppCheckbox(value: false)),
                    DataCell(
                      Text(item.date, style: context.textTheme.labelLarge),
                    ),
                    DataCell(
                      Text(item.amount, style: context.textTheme.labelLarge),
                    ),
                    DataCell(
                      Text(
                        item.transaction,
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                    DataCell(
                      Row(
                        spacing: 8,
                        children: [
                          item.paymentMethod.icon,
                          Text(
                            item.paymentMethod.number,
                            style: context.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      AppTag(
                        prefixIcon:
                            item.status == TransactionStatus.complete
                                ? BetterIcons.checkmarkCircle02Filled
                                : BetterIcons.cancelCircleFilled,

                        text:
                            (item.status == TransactionStatus.complete
                                ? 'Complete'
                                : 'Reject'),
                        color:
                            item.status == TransactionStatus.complete
                                ? SemanticColor.success
                                : SemanticColor.error,
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
