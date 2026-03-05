import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/marketing/gift_card/data/graphql/gift_card.graphql.dart';
import 'package:admin_frontend/features/marketing/gift_card/presentation/blocs/gift_card_list.cubit.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class GiftCardListScreen extends StatelessWidget {
  const GiftCardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GiftCardListBloc()..onStarted(),
      child: BlocBuilder<GiftCardListBloc, GiftCardListState>(
        builder: (context, state) {
          return PageContainer(
            child: Column(
              children: [
                PageHeader(
                  title: context.tr.giftCards,
                  subtitle: context.tr.giftCardsSubtitle,
                  showBackButton: false,
                  actions: [
                    AppOutlinedButton(
                      text: context.tr.add,
                      prefixIcon: BetterIcons.addCircleOutline,
                      onPressed: () async {
                        await context.router.push(const CreateGiftBatchRoute());
                        context.read<GiftCardListBloc>().onStarted();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<GiftCardListBloc, GiftCardListState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: AppDataTable(
                          minWidth: 500,
                          columns: [
                            DataColumn(label: Text(context.tr.name)),
                            DataColumn(label: Text(context.tr.amount)),
                            DataColumn(label: Text(context.tr.dateAndTime)),
                          ],
                          getRowCount: (data) => data.giftBatches.nodes.length,
                          rowBuilder: (data, index) =>
                              _rowBuilder(context, data, index),
                          getPageInfo: (data) => data.giftBatches.pageInfo,
                          data: state.batches,
                          paging: state.paging,
                          onPageChanged: context
                              .read<GiftCardListBloc>()
                              .onPageChanged,
                        ),
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

  DataRow _rowBuilder(BuildContext context, Query$giftBatches data, int index) {
    final batch = data.giftBatches.nodes[index];
    return DataRow(
      onSelectChanged: (selected) {
        context.router.push(GiftCardDetailsRoute(batchId: batch.id));
      },
      cells: [
        DataCell(Text(batch.name)),
        DataCell(
          Row(
            children: [
              batch.amount.toCurrency(context, batch.currency),
              const SizedBox(width: 4),
              Text(
                "x${batch.giftCodesAggregate.firstOrNull?.count?.id.toString() ?? "0"}",
              ),
            ],
          ),
        ),
        DataCell(Text((batch.availableFrom, batch.expireAt).toRange(context))),
      ],
    );
  }
}
