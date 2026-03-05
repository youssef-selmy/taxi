import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/cancel_reason.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/cancel_reason.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/presentation/blocs/cancel_reason.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:better_localization/localizations.dart';

class CancelReasonList extends StatelessWidget {
  const CancelReasonList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<CancelReasonBloc, CancelReasonState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 400,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: AppDataTable(
                      isHeaderTransparent: true,
                      title: context.tr.customers,
                      titleSize: TitleSize.small,
                      searchBarOptions: const TableSearchBarOptions(
                        enabled: true,
                        isCompact: true,
                      ),
                      actions: [
                        AppOutlinedButton(
                          onPressed: () async {
                            await context.router.push(
                              CancelReasonDetailRoute(),
                            );
                            context.read<CancelReasonBloc>().refresh();
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
                          _rowBuilderCustomers(context, data, index),
                      getPageInfo: null,
                      data: state.cancelReasonsCustomers,
                      onPageChanged: (page) {},
                      paging: null,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 400,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: AppDataTable(
                      isHeaderTransparent: true,
                      title: context.tr.drivers,
                      titleSize: TitleSize.small,
                      searchBarOptions: const TableSearchBarOptions(
                        enabled: true,
                        isCompact: true,
                      ),
                      actions: [
                        AppOutlinedButton(
                          onPressed: () async {
                            await context.router.push(
                              CancelReasonDetailRoute(),
                            );
                            context.read<CancelReasonBloc>().refresh();
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
                      data: state.cancelReasonsDrivers,
                      paging: null,
                      onPageChanged: (page) {},
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

  DataRow _rowBuilderCustomers(
    BuildContext context,
    List<Fragment$cancelReason> data,
    int index,
  ) {
    final item = data[index];
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(CancelReasonDetailRoute(cancelReasonId: item.id));
      },
      cells: [
        DataCell(Text(item.title)),
        DataCell(
          Text(
            "${item.timesUsed} ${context.tr.from} ${data.totalTimesUsed} ${context.tr.times}",
          ),
        ),
      ],
    );
  }

  DataRow _rowBuildDrivers(
    BuildContext context,
    List<Fragment$cancelReason> data,
    int index,
  ) {
    final item = data[index];
    return DataRow(
      onSelectChanged: (value) =>
          context.router.push(CancelReasonDetailRoute(cancelReasonId: item.id)),
      cells: [
        DataCell(Text(item.title)),
        DataCell(
          Text(
            "${item.timesUsed} ${context.tr.from} ${data.totalTimesUsed} ${context.tr.times}",
          ),
        ),
      ],
    );
  }
}
