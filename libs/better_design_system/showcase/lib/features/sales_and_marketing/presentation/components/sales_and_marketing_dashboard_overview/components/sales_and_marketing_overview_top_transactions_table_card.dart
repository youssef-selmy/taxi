import 'package:api_response/api_response.dart';
import 'package:better_design_showcase/core/components/table_footer.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/data_table/data_table.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

/// Status of a transaction.
enum _TransactionStatus { completed, onDelivery, canceled }

/// Transaction data model.
class _Transaction {
  final String id;
  final String category;
  final String date;
  final String price;
  final _TransactionStatus status;

  _Transaction({
    required this.id,
    required this.category,
    required this.date,
    required this.price,
    required this.status,
  });
}

/// Top Transactions table card displaying transaction details.
///
/// Shows a paginated data table with transaction information including
/// customer ID, category, date, price, and status badges. Supports both
/// desktop table view and mobile card view for responsive design.
///
/// Example:
/// ```dart
/// TopTransactionsTableCard(isMobile: false)
/// ```
class SalesAndMarketingOverviewTopTransactionsTableCard
    extends StatelessWidget {
  /// Whether to display the mobile card layout instead of desktop table.
  final bool isMobile;

  /// Creates a [SalesAndMarketingOverviewTopTransactionsTableCard].
  const SalesAndMarketingOverviewTopTransactionsTableCard({
    super.key,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final transactions = [
      _Transaction(
        id: '#123456',
        category: 'Table',
        date: '21 Oct 2025',
        price: '\$100.00',
        status: _TransactionStatus.completed,
      ),
      _Transaction(
        id: '#123457',
        category: 'Chair',
        date: '22 Oct 2025',
        price: '\$85.00',
        status: _TransactionStatus.onDelivery,
      ),
      _Transaction(
        id: '#123458',
        category: 'Desk',
        date: '23 Oct 2025',
        price: '\$250.00',
        status: _TransactionStatus.canceled,
      ),
      _Transaction(
        id: '#123459',
        category: 'Lamp',
        date: '24 Oct 2025',
        price: '\$45.00',
        status: _TransactionStatus.completed,
      ),
      _Transaction(
        id: '#123460',
        category: 'Sofa',
        date: '25 Oct 2025',
        price: '\$500.00',
        status: _TransactionStatus.completed,
      ),
      _Transaction(
        id: '#123461',
        category: 'Cabinet',
        date: '26 Oct 2025',
        price: '\$180.00',
        status: _TransactionStatus.onDelivery,
      ),
      _Transaction(
        id: '#123462',
        category: 'Bookshelf',
        date: '27 Oct 2025',
        price: '\$120.00',
        status: _TransactionStatus.canceled,
      ),
      _Transaction(
        id: '#123463',
        category: 'Ottoman',
        date: '28 Oct 2025',
        price: '\$75.00',
        status: _TransactionStatus.completed,
      ),
    ];

    final data = ApiResponse<List<_Transaction>>.loaded(transactions);

    return isMobile
        ? _buildCards(context, transactions)
        : _buildTable(context, data);
  }

  Widget _buildCards(BuildContext context, List<_Transaction> transactions) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Top Transactions', style: context.textTheme.titleSmall),
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
              transactions.map((transaction) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    border: Border.all(color: context.colors.outline),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            transaction.category,
                            style: context.textTheme.labelLarge,
                          ),

                          Row(
                            spacing: 4,
                            children: [
                              Text(
                                transaction.price,
                                style: context.textTheme.labelLarge,
                              ),
                              Text(
                                'USD',
                                style: context.textTheme.labelMedium?.variant(
                                  context,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      AppDivider(height: 28, isDashed: true),
                      Column(
                        spacing: 12,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Customer ID:',
                                style: context.textTheme.bodyMedium?.variant(
                                  context,
                                ),
                              ),
                              Text(
                                transaction.id,
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date:',
                                style: context.textTheme.bodyMedium?.variant(
                                  context,
                                ),
                              ),
                              Text(
                                transaction.date,
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status:',
                                style: context.textTheme.bodyMedium?.variant(
                                  context,
                                ),
                              ),
                              _buildStatusBadge(transaction.status),
                            ],
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

  Widget _buildTable(
    BuildContext context,
    ApiResponse<List<_Transaction>> data,
  ) {
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
            height: 424,
            child: AppDataTable<List<_Transaction>, dynamic>(
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
                DataColumn2(fixedWidth: 50, label: AppCheckbox(value: false)),
                DataColumn2(
                  fixedWidth: 140,
                  label: Text(
                    'Customer ID',
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                DataColumn2(
                  fixedWidth: 120,
                  label: Text('Category', style: context.textTheme.bodyMedium),
                ),
                DataColumn2(
                  fixedWidth: 135,
                  label: Text('Date', style: context.textTheme.bodyMedium),
                ),
                DataColumn2(
                  fixedWidth: 110,
                  label: Text('Price', style: context.textTheme.bodyMedium),
                ),
                DataColumn2(
                  fixedWidth: 150,
                  label: Text('Status', style: context.textTheme.bodyMedium),
                ),
                const DataColumn2(fixedWidth: 90, label: SizedBox.shrink()),
              ],
              rowBuilder: (list, index) {
                final transaction = list[index];
                return DataRow(
                  onSelectChanged: (_) {},
                  cells: [
                    DataCell(AppCheckbox(value: false)),
                    DataCell(
                      Text(
                        transaction.id,
                        style: context.textTheme.labelLarge?.variantLow(
                          context,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        transaction.category,
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                    DataCell(
                      Text(
                        transaction.date,
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                    DataCell(
                      Text(
                        transaction.price,
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                    DataCell(_buildStatusBadge(transaction.status)),
                    DataCell(
                      AppIconButton(
                        icon: BetterIcons.moreVerticalCircle01Outline,
                        size: ButtonSize.small,
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Top Transactions', style: context.textTheme.titleSmall),
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

  Widget _buildStatusBadge(_TransactionStatus status) {
    return AppBadge(
      text: _getStatusText(status),
      size: BadgeSize.medium,
      color: _getStatusColor(status),
      hasDot: true,
    );
  }

  String _getStatusText(_TransactionStatus status) => switch (status) {
    _TransactionStatus.completed => 'Completed',
    _TransactionStatus.onDelivery => 'On Delivery',
    _TransactionStatus.canceled => 'Canceled',
  };

  SemanticColor _getStatusColor(_TransactionStatus status) => switch (status) {
    _TransactionStatus.completed => SemanticColor.success,
    _TransactionStatus.onDelivery => SemanticColor.insight,
    _TransactionStatus.canceled => SemanticColor.error,
  };
}
