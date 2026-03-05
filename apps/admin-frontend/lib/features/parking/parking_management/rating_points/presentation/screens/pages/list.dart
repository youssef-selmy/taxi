import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/parking/parking_management/rating_points/presentation/blocs/rating_points.cubit.dart';
import 'package:better_icons/better_icons.dart';

class RatingPointsList extends StatelessWidget {
  const RatingPointsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<RatingPointsBloc, RatingPointsState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 300,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: AppDataTable(
                      isHeaderTransparent: true,
                      title: context.tr.positivePoints,
                      titleSize: TitleSize.small,
                      searchBarOptions: const TableSearchBarOptions(
                        enabled: true,
                        isCompact: true,
                      ),
                      actions: [
                        AppOutlinedButton(
                          onPressed: () {
                            context.router.push(
                              ParkingRatingPointsDetailsRoute(),
                            );
                          },
                          text: context.tr.add,
                          prefixIcon: BetterIcons.addCircleOutline,
                        ),
                      ],
                      columns: [
                        DataColumn(label: Text(context.tr.name)),
                        DataColumn(label: Text(context.tr.timesUsed)),
                      ],
                      getRowCount: (data) => data.length,
                      rowBuilder: (data, index) =>
                          _rowBuilderPositive(context, data, index),
                      getPageInfo: null,
                      data: state.positiveRatingPoints,
                      onPageChanged: (paging) {},
                      paging: null,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: AppDataTable(
                      isHeaderTransparent: true,
                      title: context.tr.negativePoints,
                      titleSize: TitleSize.small,
                      searchBarOptions: const TableSearchBarOptions(
                        enabled: true,
                        isCompact: true,
                      ),
                      actions: [
                        AppOutlinedButton(
                          onPressed: () {
                            context.router.push(
                              ParkingRatingPointsDetailsRoute(),
                            );
                          },
                          text: context.tr.add,
                          prefixIcon: BetterIcons.addCircleOutline,
                        ),
                      ],
                      columns: [
                        DataColumn(label: Text(context.tr.name)),
                        DataColumn(label: Text(context.tr.timesUsed)),
                      ],
                      getRowCount: (data) => data.length,
                      rowBuilder: (data, index) =>
                          _rowBuildDrivers(context, data, index),
                      getPageInfo: null,
                      data: state.negativeRatingPoints,
                      onPageChanged: (paging) {},
                      paging: null,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  DataRow _rowBuilderPositive(
    BuildContext context,
    List<Fragment$parkingFeedbackParameterListItem> data,
    int index,
  ) {
    final item = data[index];
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(
          ParkingRatingPointsDetailsRoute(ratingPointId: item.id),
        );
      },
      cells: [
        DataCell(Text(item.name)),
        DataCell(
          Text(
            "${item.feedbacksCount} ${context.tr.from} ${data.totalFeedbacks} ${context.tr.times}",
          ),
        ),
      ],
    );
  }

  DataRow _rowBuildDrivers(
    BuildContext context,
    List<Fragment$parkingFeedbackParameterListItem> data,
    int index,
  ) {
    final item = data[index];
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(
          ParkingRatingPointsDetailsRoute(ratingPointId: item.id),
        );
      },
      cells: [
        DataCell(Text(item.name)),
        DataCell(
          Text(
            "${item.feedbacksCount} ${context.tr.from} ${data.totalFeedbacks} ${context.tr.times}",
          ),
        ),
      ],
    );
  }
}
