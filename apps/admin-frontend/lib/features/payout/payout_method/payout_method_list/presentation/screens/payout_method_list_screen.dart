import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/payout/payout_method/payout_method_list/presentation/blocs/payout_method_list.cubit.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class PayoutMethodListScreen extends StatelessWidget {
  const PayoutMethodListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PayoutMethodListBloc()..onStarted(),
      child: BlocBuilder<PayoutMethodListBloc, PayoutMethodListState>(
        builder: (context, state) {
          return PageContainer(
            child: Column(
              children: [
                PageHeader(
                  title: context.tr.payoutMethods,
                  subtitle: context.tr.listOfAvailablePayoutMethods,
                  actions: [
                    AppOutlinedButton(
                      prefixIcon: BetterIcons.addCircleOutline,
                      onPressed: () async {
                        await context.router.push(PayoutMethodDetailRoute());
                        context.read<PayoutMethodListBloc>().onStarted();
                      },
                      text: context.tr.add,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<PayoutMethodListBloc, PayoutMethodListState>(
                    builder: (context, state) {
                      return AppDataTable(
                        columns: [
                          DataColumn(label: Text(context.tr.name)),
                          // DataColumn(label: Text(context.translate.processedAmount)),
                        ],
                        getRowCount: (data) => data.nodes.length,
                        rowBuilder: (data, index) =>
                            _rowBuilder(context, data.nodes[index]),
                        getPageInfo: (data) => data.pageInfo,
                        data: state.payoutMethodsState,
                        paging: state.paging,
                        onPageChanged: context
                            .read<PayoutMethodListBloc>()
                            .onPageChanged,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Fragment$payoutMethodListItem node,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              if (node.media != null) ...[
                node.media.widget(width: 32, height: 32),
                const SizedBox(width: 8),
              ],
              Text(node.name),
            ],
          ),
        ),
        // DataCell(
        //   (node.payoutSessionsAggregate.firstOrNull?.sum?.totalAmount ?? 0).toCurrency(context, node.currency),
        // ),
      ],
      onSelectChanged: (_) async {
        await context.router.push(
          PayoutMethodDetailRoute(payoutMethodId: node.id),
        );
        context.read<PayoutMethodListBloc>().onStarted();
      },
    );
  }
}
