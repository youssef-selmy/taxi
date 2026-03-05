import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_status/dropdown_status.dart';
import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/enums/review_status.dart';
import 'package:admin_frontend/core/enums/shop_review_sort_fields.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.extensions.dart';
import 'package:admin_frontend/features/shop/shop_review/shop_review_list/data/graphql/shop_review_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_review/shop_review_list/presentation/blocs/shop_review_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ShopReviewListTable extends StatelessWidget {
  const ShopReviewListTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShopReviewListBloc>();
    return BlocBuilder<ShopReviewListBloc, ShopReviewListState>(
      builder: (context, state) {
        return AppDataTable(
          dataRowHeight: 200,
          minWidth: 1200,
          searchBarOptions: TableSearchBarOptions(
            onChanged: bloc.onSearchFilterChanged,
          ),
          columns: [
            DataColumn2(
              label: Text(
                context.tr.customer,
                style: context.textTheme.labelMedium?.variant(context),
              ),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text(
                context.tr.review,
                style: context.textTheme.labelMedium?.variant(context),
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                context.tr.shop,
                style: context.textTheme.labelMedium?.variant(context),
              ),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text(
                context.tr.submittedOn,
                style: context.textTheme.labelMedium?.variant(context),
              ),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text(
                context.tr.status,
                style: context.textTheme.labelMedium?.variant(context),
              ),
              size: ColumnSize.L,
            ),
          ],
          sortOptions: AppSortDropdown<Input$ShopFeedbackSort>(
            selectedValues: state.sortFields,
            onChanged: bloc.onSortingChanged,
            items: [
              Input$ShopFeedbackSort(
                field: Enum$ShopFeedbackSortFields.id,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ShopFeedbackSort(
                field: Enum$ShopFeedbackSortFields.id,
                direction: Enum$SortDirection.DESC,
              ),
              Input$ShopFeedbackSort(
                field: Enum$ShopFeedbackSortFields.shopId,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ShopFeedbackSort(
                field: Enum$ShopFeedbackSortFields.shopId,
                direction: Enum$SortDirection.DESC,
              ),
              Input$ShopFeedbackSort(
                field: Enum$ShopFeedbackSortFields.customerId,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ShopFeedbackSort(
                field: Enum$ShopFeedbackSortFields.customerId,
                direction: Enum$SortDirection.DESC,
              ),
            ],
            labelGetter: (item) =>
                item.field.tableViewSortLabel(context, item.direction),
          ),
          filterOptions: [
            AppFilterDropdown<Enum$ReviewStatus>(
              title: context.tr.status,
              selectedValues: state.filterStatus,
              onChanged: bloc.onStatusFilterChanged,
              items: Enum$ReviewStatus.values.toFilterItems(context),
            ),
          ],
          getRowCount: (data) => data.shopFeedbacks.nodes.length,
          rowBuilder: (data, int index) =>
              rowBuilder(context, state.shopReviewsState.data!, index),
          getPageInfo: (data) => data.shopFeedbacks.pageInfo,
          data: state.shopReviewsState,
          paging: state.paging,
          onPageChanged: bloc.onPageChanged,
        );
      },
    );
  }
}

DataRow rowBuilder(BuildContext context, Query$shopFeedbacks data, int index) {
  final bloc = context.read<ShopReviewListBloc>();
  final shopReview = data.shopFeedbacks.nodes[index];
  return DataRow(
    cells: [
      DataCell(
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, top: 12),
            child: shopReview.orderCart.order.customer.tableView(context),
          ),
        ),
      ),
      DataCell(
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            RatingIndicator(rating: shopReview.score),
            const SizedBox(height: 8),
            SingleChildScrollView(
              child: Row(
                children: [
                  ...shopReview.orderCart.products.map(
                    (orderCartItem) => AppTag(
                      text: orderCartItem.itemVariant?.product.name ?? "-",
                      color: SemanticColor.neutral,
                    ),
                  ),
                ].separated(separator: const SizedBox(width: 4)),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(shopReview.comment ?? ''),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (shopReview.parameters
                      .where((e) => e.isGood == true)
                      .isNotEmpty) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr.goodPoints,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colors.success,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: shopReview.parameters
                              .where((e) => e.isGood == true)
                              .map((e) => e.view(context))
                              .toList(),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                  ],
                  if (shopReview.parameters
                      .where((e) => e.isGood == false)
                      .isNotEmpty) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr.badPoints,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colors.error,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: shopReview.parameters
                              .where((e) => e.isGood == false)
                              .map((e) => e.view(context))
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
      DataCell(
        Column(
          children: [
            const SizedBox(height: 12),
            shopReview.orderCart.shop.tableView(context),
          ],
        ),
      ),
      DataCell(
        Column(
          children: [
            const SizedBox(height: 12),
            Text(
              shopReview.createdAt.formatDateTime,
              style: context.textTheme.labelMedium,
            ),
          ],
        ),
      ),
      DataCell(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            AppDropdownStatus(
              initialValue: shopReview.status,
              onChanged: (status) =>
                  bloc.onUpdateFeedbackStatus(shopReview.id, status!),
              items: Enum$ReviewStatus.values.toDropDownItems(context),
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppFilledButton(
                  size: ButtonSize.medium,
                  onPressed: () {
                    bloc.onUpdateFeedbackStatus(
                      shopReview.id,
                      Enum$ReviewStatus.Approved,
                    );
                  },
                  text: context.tr.approve,
                ),
                const SizedBox(width: 12),
                AppTextButton(
                  size: ButtonSize.medium,
                  onPressed: () {
                    bloc.onUpdateFeedbackStatus(
                      shopReview.id,
                      Enum$ReviewStatus.ApprovedUnpublished,
                    );
                  },
                  text: context.tr.hideReview,
                ),
                const SizedBox(width: 12),
                AppTextButton(
                  size: ButtonSize.medium,
                  color: SemanticColor.error,
                  onPressed: () {
                    bloc.onUpdateFeedbackStatus(
                      shopReview.id,
                      Enum$ReviewStatus.Rejected,
                    );
                  },
                  text: context.tr.reject,
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    ],
  );
}
