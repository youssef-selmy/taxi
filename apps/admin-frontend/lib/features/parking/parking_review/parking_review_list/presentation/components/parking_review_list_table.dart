import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_status/dropdown_status.dart';
import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/enums/parking_review_sort_field.dart';
import 'package:admin_frontend/core/enums/parking_vehicle_type_enum.dart';
import 'package:admin_frontend/core/enums/review_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/parking_review/parking_review_list/data/graphql/parking_review_list.graphql.dart';
import 'package:admin_frontend/features/parking/parking_review/parking_review_list/presentation/blocs/parking_review_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkingReviewListTable extends StatelessWidget {
  const ParkingReviewListTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkingReviewListBloc>();
    return BlocBuilder<ParkingReviewListBloc, ParkingReviewListState>(
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
                context.tr.parking,
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
          sortOptions: AppSortDropdown<Input$ParkingFeedbackSort>(
            selectedValues: state.sortFields,
            onChanged: bloc.onSortingChanged,
            items: [
              Input$ParkingFeedbackSort(
                field: Enum$ParkingFeedbackSortFields.id,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ParkingFeedbackSort(
                field: Enum$ParkingFeedbackSortFields.id,
                direction: Enum$SortDirection.DESC,
              ),
              Input$ParkingFeedbackSort(
                field: Enum$ParkingFeedbackSortFields.parkSpotId,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ParkingFeedbackSort(
                field: Enum$ParkingFeedbackSortFields.parkSpotId,
                direction: Enum$SortDirection.DESC,
              ),
              Input$ParkingFeedbackSort(
                field: Enum$ParkingFeedbackSortFields.customerId,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ParkingFeedbackSort(
                field: Enum$ParkingFeedbackSortFields.customerId,
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
          getRowCount: (data) => data.parkingFeedbacks.nodes.length,
          rowBuilder: (data, int index) =>
              rowBuilder(context, state.parkingReviewsState.data!, index),
          getPageInfo: (data) => data.parkingFeedbacks.pageInfo,
          data: state.parkingReviewsState,
          paging: state.paging,
          onPageChanged: bloc.onPageChanged,
        );
      },
    );
  }
}

DataRow rowBuilder(
  BuildContext context,
  Query$parkingFeedbacks data,
  int index,
) {
  final bloc = context.read<ParkingReviewListBloc>();
  final parkingReview = data.parkingFeedbacks.nodes[index];
  return DataRow(
    cells: [
      DataCell(
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Column(
            children: [
              const SizedBox(height: 12),
              parkingReview.order.carOwner?.tableView(context) ??
                  const SizedBox.shrink(),
            ],
          ),
        ),
      ),
      DataCell(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            RatingIndicator(rating: parkingReview.score),
            const SizedBox(height: 8),
            AppTag(
              text: parkingReview.order.vehicleType.text(context),
              color: SemanticColor.neutral,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(parkingReview.comment ?? ''),
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (parkingReview.parameters
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
                          children: parkingReview.parameters
                              .where((e) => e.isGood == true)
                              .map((e) => e.view(context))
                              .toList(),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                  ],
                  if (parkingReview.parameters
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
                          children: parkingReview.parameters
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
            parkingReview.order.parkSpot.tableView(context),
          ],
        ),
      ),
      DataCell(
        Column(
          children: [
            const SizedBox(height: 12),
            Text(
              parkingReview.createdAt.formatDateTime,
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
              items: Enum$ReviewStatus.values.toDropDownItems(context),
              initialValue: parkingReview.status,
              onChanged: (p0) => bloc.updateFeedbackStatus(
                feedbackId: parkingReview.id,
                status: p0!,
              ),
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppFilledButton(
                  size: ButtonSize.medium,
                  onPressed: () {
                    bloc.updateFeedbackStatus(
                      feedbackId: parkingReview.id,
                      status: Enum$ReviewStatus.Approved,
                    );
                  },
                  text: context.tr.approve,
                ),
                const SizedBox(width: 12),
                AppTextButton(
                  size: ButtonSize.medium,
                  onPressed: () {
                    bloc.updateFeedbackStatus(
                      feedbackId: parkingReview.id,
                      status: Enum$ReviewStatus.ApprovedUnpublished,
                    );
                  },
                  text: context.tr.hideReview,
                ),
                const SizedBox(width: 12),
                AppTextButton(
                  size: ButtonSize.medium,
                  color: SemanticColor.error,
                  onPressed: () {
                    bloc.updateFeedbackStatus(
                      feedbackId: parkingReview.id,
                      status: Enum$ReviewStatus.Rejected,
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
