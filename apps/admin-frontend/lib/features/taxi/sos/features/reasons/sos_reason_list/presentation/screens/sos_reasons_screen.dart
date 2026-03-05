import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/sos/data/graphql/sos.graphql.dart';
import 'package:admin_frontend/features/taxi/sos/features/reasons/sos_reason_list/presentation/blocs/sos_reasons.cubit.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class SosReasonsScreen extends StatelessWidget {
  const SosReasonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SosReasonsBloc()..onStarted(),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              showBackButton: true,
              title: context.tr.sosReasons,
              subtitle: context.tr.listOfSosReasons,
            ),
            const SizedBox(height: 16),
            BlocBuilder<SosReasonsBloc, SosReasonsState>(
              builder: (context, state) {
                return Expanded(
                  child: AppDataTable(
                    actions: _tableActionButtons(context),
                    searchBarOptions: TableSearchBarOptions(
                      onChanged: context.read<SosReasonsBloc>().onSearchChanged,
                    ),
                    columns: [
                      DataColumn2(label: Text(context.tr.name)),
                      DataColumn2(label: Text(context.tr.numberOfTimesUsed)),
                    ],
                    getRowCount: (data) => data.sosReasons.nodes.length,
                    rowBuilder: (data, int index) =>
                        rowBuilder(data, index, context),
                    getPageInfo: (data) => data.sosReasons.pageInfo,
                    data: state.sosReasons,
                    paging: state.paging,
                    onPageChanged: context.read<SosReasonsBloc>().onPageChanged,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

DataRow rowBuilder(Query$sosReasons data, int index, BuildContext context) {
  final sosReasson = data.sosReasons.nodes[index];
  return DataRow(
    onSelectChanged: (value) {
      context.router.push(AddSosReasonRoute(sosReassonId: sosReasson.id));
    },
    cells: [
      DataCell(Text(sosReasson.name)),
      DataCell(Text('${sosReasson.sos.totalCount} Times')),
    ],
  );
}

List<Widget> _tableActionButtons(BuildContext context) {
  return [
    AppOutlinedButton(
      onPressed: () {
        context.router.push(AddSosReasonRoute());
      },
      prefixIcon: BetterIcons.addCircleOutline,
      text: context.tr.add,
    ),
  ];
}
