import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/enums/sos_sort_field.dart';
import 'package:admin_frontend/core/enums/sos_status_enum.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/sos/data/graphql/sos.graphql.dart';
import 'package:admin_frontend/features/taxi/sos/features/sos_list/presentation/blocs/sos.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class SosListScreen extends StatefulWidget {
  const SosListScreen({super.key});

  @override
  State<SosListScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SosBloc()..onStarted(),
      child: PageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              title: context.tr.sos,
              subtitle: context.tr.distressSignalsSubmittedByUsers,
              actions: [
                AppOutlinedButton(
                  onPressed: () {
                    context.router.push(const SosReasonsRoute());
                  },
                  text: context.tr.sosReasons,
                  color: SemanticColor.neutral,
                ),
              ],
            ),
            const SizedBox(height: 16),
            BlocBuilder<SosBloc, SosState>(
              builder: (context, state) {
                return Expanded(
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AppDataTable(
                        columns: [
                          DataColumn(label: Text(context.tr.dateAndTime)),
                          DataColumn(label: Text(context.tr.status)),
                          DataColumn2(label: Text(context.tr.reasons)),
                          DataColumn2(
                            label: Text(context.tr.comment),
                            size: ColumnSize.L,
                          ),
                        ],
                        sortOptions: AppSortDropdown<Input$DistressSignalSort>(
                          selectedValues: state.sortFields,
                          onChanged: context.read<SosBloc>().onSortingChanged,
                          items: [
                            Input$DistressSignalSort(
                              field: Enum$DistressSignalSortFields.id,
                              direction: Enum$SortDirection.ASC,
                            ),
                            Input$DistressSignalSort(
                              field: Enum$DistressSignalSortFields.id,
                              direction: Enum$SortDirection.DESC,
                            ),
                            Input$DistressSignalSort(
                              field: Enum$DistressSignalSortFields.status,
                              direction: Enum$SortDirection.ASC,
                            ),
                            Input$DistressSignalSort(
                              field: Enum$DistressSignalSortFields.status,
                              direction: Enum$SortDirection.DESC,
                            ),
                          ],
                          labelGetter: (sort) => sort.field.tableViewSortLabel(
                            context,
                            sort.direction,
                          ),
                        ),
                        filterOptions: [
                          AppFilterDropdown<Enum$SOSStatus>(
                            title: context.tr.status,
                            selectedValues: state.filterStatus,
                            onChanged: context.read<SosBloc>().onFilterChanged,
                            items: Enum$SOSStatus.values
                                .where((e) => e != Enum$SOSStatus.$unknown)
                                .map(
                                  (status) => FilterItem(
                                    label: status.name(context),
                                    value: status,
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                        getRowCount: (data) =>
                            data.distressSignals.nodes.length,
                        rowBuilder: (Query$distressSignals data, int index) =>
                            rowBuilder(data, index, context),
                        getPageInfo: (data) => data.distressSignals.pageInfo,
                        data: state.distressSignals,
                        paging: state.paging,
                        onPageChanged: context.read<SosBloc>().onPageChanged,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  DataRow rowBuilder(
    Query$distressSignals data,
    int index,
    BuildContext context,
  ) {
    final distressSignals = data.distressSignals.nodes[index];
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(SosDetailRoute(sosId: distressSignals.id));
      },
      cells: [
        DataCell(
          Text(
            distressSignals.createdAt.formatDateTime,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colors.onSurface,
            ),
          ),
        ),
        DataCell(distressSignals.status.chip(context)),
        DataCell(
          distressSignals.reason?.name.isEmpty ?? true
              ? Text(context.tr.notSet, style: context.textTheme.labelMedium)
              : Text(
                  distressSignals.reason!.name,
                  style: context.textTheme.labelMedium,
                ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: distressSignals.comment == null
                ? Text(
                    context.tr.noComment,
                    style: context.textTheme.labelMedium?.variant(context),
                  )
                : Text(
                    distressSignals.comment!,
                    style: context.textTheme.labelMedium?.variant(context),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ),
      ],
    );
  }
}
