import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_card/chart_indicator.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/components/charts/ring_chart.dart';
import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/gift_card.graphql.dart';
import 'package:admin_frontend/features/marketing/gift_card/presentation/blocs/gift_card_details.cubit.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class GiftCardDetailsScreen extends StatelessWidget {
  final String? batchId;

  const GiftCardDetailsScreen({
    super.key,
    @QueryParam("id") required this.batchId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.surface,
      child: SingleChildScrollView(
        padding: context.pagePadding,
        child: BlocProvider(
          create: (context) =>
              GiftCardDetailsBloc()..onStarted(batchId: batchId!),
          child: BlocConsumer<GiftCardDetailsBloc, GiftCardDetailsState>(
            listener: (context, state) {
              final bloc = context.read<GiftCardDetailsBloc>();

              if (state.export.data != null) {
                // open url to download file
                launchUrlString(state.export.data!);
                bloc.resetExportState();
              }
            },
            builder: (context, state) {
              final bloc = context.read<GiftCardDetailsBloc>();
              return switch (state.batch) {
                ApiResponseInitial() => const SizedBox.shrink(),
                ApiResponseError(:final message) => Center(
                  child: Text(message),
                ),
                ApiResponseLoading() || ApiResponseLoaded() => Column(
                  children: [
                    PageHeader(
                      title: "${context.tr.giftBatch} #${batchId ?? "0"}",
                      subtitle: context.tr.giftCardBatchStatsAndCodeExport,
                      showBackButton: true,
                      onBackButtonPressed: () =>
                          context.router.replace(GiftCardListRoute()),
                    ),
                    const SizedBox(height: 32),
                    LayoutGrid(
                      columnSizes: List.generate(
                        context.isDesktop ? 2 : 1,
                        (_) => 1.fr,
                      ),
                      rowSizes: List.generate(
                        context.isDesktop ? 1 : 2,
                        (_) => auto,
                      ),
                      rowGap: 16,
                      columnGap: 16,
                      children: [
                        _detailsCard(context, state),
                        _usageChartCard(context, state),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 400,
                      child: AppDataTable(
                        actions: [
                          AppFilledButton(
                            text: context.tr.export,
                            prefixIcon: BetterIcons.share08Outline,
                            onPressed: () {
                              bloc.onExportGiftCodes();
                            },
                          ),
                        ],
                        title: context.tr.giftCardCodes,
                        titleSize: TitleSize.small,
                        columns: [
                          DataColumn(label: Text(context.tr.giftCardCode)),
                          DataColumn(label: Text(context.tr.status)),
                        ],
                        getRowCount: (data) => data.nodes.length,
                        rowBuilder: (data, index) =>
                            _rowBuilder(context, data.nodes[index]),
                        getPageInfo: (data) => data.pageInfo,
                        data: state.giftCodes,
                        paging: state.paging,
                        onPageChanged: bloc.onGiftCodesPageChanged,
                      ),
                    ),
                  ],
                ),
              };
            },
          ),
        ),
      ),
    );
  }

  Card _detailsCard(BuildContext context, GiftCardDetailsState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            LargeHeader(
              title: context.tr.details,
              subtitle: context.tr.giftCardBatchOverview,
            ),
            const SizedBox(height: 16),
            detailItem(
              context: context,
              title: context.tr.name,
              subtitle: state.batch.data?.giftBatch.id ?? "----",
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.tr.amount,
                  style: context.textTheme.labelMedium?.variant(context),
                ),
                (state.batch.data?.giftBatch.amount ?? 0).toCurrency(
                  context,
                  state.batch.data?.giftBatch.currency ?? Env.defaultCurrency,
                ),
              ],
            ),
            const Divider(),
            detailItem(
              context: context,
              title: context.tr.quantity,
              subtitle:
                  "${((state.batch.data?.giftBatch.usedCodesCount.firstOrNull?.count?.id ?? 0) + (state.batch.data?.giftBatch.unusedCodesCount.firstOrNull?.count?.id ?? 0))}",
            ),
            const Divider(),
            detailItem(
              context: context,
              title: context.tr.dateAndTime,
              subtitle: (
                state.batch.data?.giftBatch.availableFrom,
                state.batch.data?.giftBatch.expireAt,
              ).toRange(context),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _usageChartCard(BuildContext context, GiftCardDetailsState state) {
    return SizedBox(
      height: 400,
      child: ChartCard(
        title: context.tr.giftCardUsage,
        subtitle: context.tr.giftCardUsageSubtitle,
        footer: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: ChartIndicator(
                    color: context.colors.primary,
                    title: context.tr.used,
                  ),
                ),
                Text(
                  state
                          .batch
                          .data
                          ?.giftBatch
                          .usedCodesCount
                          .firstOrNull
                          ?.count
                          ?.id
                          .toString() ??
                      "0",
                  style: context.textTheme.labelMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ChartIndicator(
                    color: context.colors.secondary,
                    title: context.tr.unused,
                  ),
                ),
                Text(
                  state
                          .batch
                          .data
                          ?.giftBatch
                          .unusedCodesCount
                          .firstOrNull
                          ?.count
                          ?.id
                          .toString() ??
                      "0",
                  style: context.textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
        child: RingChart(
          data: [
            ChartSeriesData(
              name: context.tr.used,
              value:
                  (state
                              .batch
                              .data
                              ?.giftBatch
                              .usedCodesCount
                              .firstOrNull
                              ?.count
                              ?.id ??
                          0)
                      .toDouble(),
              color: context.colors.primary,
            ),
            ChartSeriesData(
              name: context.tr.unused,
              value:
                  (state
                              .batch
                              .data
                              ?.giftBatch
                              .unusedCodesCount
                              .firstOrNull
                              ?.count
                              ?.id ??
                          0)
                      .toDouble(),
              color: context.colors.secondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget detailItem({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.labelMedium?.variant(context)),
        Text(subtitle, style: context.textTheme.labelMedium),
      ],
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$giftCode nod) {
    return DataRow(
      cells: [
        DataCell(Text(nod.code)),
        DataCell(
          nod.usedAt == null
              ? AppTag(text: context.tr.unused, color: SemanticColor.error)
              : AppTag(
                  text:
                      "${context.tr.usedIn} ${nod.usedAt!.formatDate(context)}",
                  color: SemanticColor.success,
                ),
        ),
      ],
    );
  }
}
