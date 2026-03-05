import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/chart_card/chart_indicator.dart';
import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/components/charts/ring_chart.dart';
import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/campaign.graphql.dart';
import 'package:admin_frontend/features/marketing/coupon/presentation/blocs/campaign_details.cubit.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class CampaignDetailsScreen extends StatelessWidget {
  final String? campaignId;

  const CampaignDetailsScreen({
    super.key,
    @QueryParam('campaignId') required this.campaignId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.surface,
      child: SingleChildScrollView(
        child: BlocProvider(
          create: (context) =>
              CampaignDetailsBloc()..onStarted(campaignId: campaignId!),
          child: BlocConsumer<CampaignDetailsBloc, CampaignDetailsState>(
            listener: (context, state) {
              if (state.exportCodes.data != null) {
                // open url to download file
                launchUrlString(state.exportCodes.data!);
                context.read<CampaignDetailsBloc>().resetExportState();
              }
            },
            builder: (context, state) {
              final bloc = context.read<CampaignDetailsBloc>();
              return switch (state.campaign) {
                ApiResponseInitial() => const SizedBox.shrink(),
                ApiResponseError(:final message) => Center(
                  child: Text(message),
                ),
                ApiResponseLoading() || ApiResponseLoaded() => Padding(
                  padding: context.pagePadding,
                  child: Column(
                    children: [
                      PageHeader(
                        title:
                            "${context.tr.couponBatch} #${campaignId ?? "0"}",
                        subtitle: context.tr.campaignStatsAndCouponExport,
                        showBackButton: true,
                        onBackButtonPressed: () {
                          context.router.replace(CampaignListRoute());
                        },
                      ),
                      const SizedBox(height: 32),
                      Skeletonizer(
                        enabled: state.campaign.isLoading,
                        child: LayoutGrid(
                          columnSizes: context.responsive(
                            [auto],
                            lg: [2.fr, 1.fr],
                          ),
                          columnGap: 16,
                          rowGap: 16,
                          rowSizes: const [auto, auto, auto, auto],
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    LargeHeader(
                                      title: context.tr.details,
                                      subtitle: context.tr.overview,
                                    ),
                                    const SizedBox(height: 16),
                                    LayoutGrid(
                                      columnSizes: context.responsive(
                                        [auto],
                                        lg: [1.fr, 1.fr],
                                      ),
                                      rowSizes: const [
                                        auto,
                                        auto,
                                        auto,
                                        auto,
                                        auto,
                                        auto,
                                        auto,
                                        auto,
                                        auto,
                                        auto,
                                        auto,
                                      ],
                                      children: [
                                        InfoPanelCell(
                                          title: context.tr.name,
                                          subtitle:
                                              state.campaign.data?.id ?? "----",
                                        ),
                                        InfoPanelCell(
                                          title: context.tr.status,
                                          subtitleWidget: state
                                              .campaign
                                              .data
                                              ?.isEnabled
                                              .toActiveInactiveChip(context),
                                        ),
                                        InfoPanelCell(
                                          title: context.tr.description,
                                          subtitle:
                                              state
                                                  .campaign
                                                  .data
                                                  ?.description ??
                                              "-",
                                        ),
                                        InfoPanelCell(
                                          title:
                                              context.tr.maxRedeemPerCustomer,
                                          subtitle:
                                              state
                                                  .campaign
                                                  .data
                                                  ?.manyTimesUserCanUse
                                                  .toString() ??
                                              "----",
                                        ),
                                        InfoPanelCell(
                                          title: context.tr.minimumCost,
                                          subtitleWidget: state
                                              .campaign
                                              .data
                                              ?.minimumCost
                                              .toCurrency(
                                                context,
                                                state.campaign.data?.currency ??
                                                    Env.defaultCurrency,
                                              ),
                                        ),
                                        InfoPanelCell(
                                          title: context.tr.maximumCost,
                                          subtitleWidget: state
                                              .campaign
                                              .data
                                              ?.maximumCost
                                              .toCurrency(
                                                context,
                                                state.campaign.data?.currency ??
                                                    Env.defaultCurrency,
                                              ),
                                        ),
                                        InfoPanelCell(
                                          title: context.tr.discount,
                                          subtitleWidget: state
                                              .campaign
                                              .data
                                              ?.discountFlat
                                              .toCurrency(
                                                context,
                                                state.campaign.data?.currency ??
                                                    Env.defaultCurrency,
                                              ),
                                        ),
                                        InfoPanelCell(
                                          title: context.tr.discountPercent,
                                          subtitle:
                                              "${state.campaign.data?.discountPercent ?? 0}%",
                                        ),
                                        InfoPanelCell(
                                          title: context.tr.quantity,
                                          subtitle:
                                              "${((state.campaign.data?.usedCodesCount.firstOrNull?.count?.id ?? 0) + (state.campaign.data?.unusedCodesCount.firstOrNull?.count?.id ?? 0))}",
                                          hideDivider: context.responsive(
                                            false,
                                            lg: true,
                                          ),
                                        ),
                                        InfoPanelCell(
                                          title: context.tr.dateAndTime,
                                          subtitle: (
                                            state.campaign.data?.startAt,
                                            state.campaign.data?.expireAt,
                                          ).toRange(context),
                                          hideDivider: true,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 400,
                              child: ChartCard(
                                title: context.tr.usageStatistics,
                                subtitle:
                                    "Shows the usage statistics of coupon codes",
                                footer: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                                  .campaign
                                                  .data
                                                  ?.usedCodesCount
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
                                                  .campaign
                                                  .data
                                                  ?.unusedCodesCount
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
                                                      .campaign
                                                      .data
                                                      ?.usedCodesCount
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
                                                      .campaign
                                                      .data
                                                      ?.unusedCodesCount
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
                            ),
                          ],
                        ),
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
                          title: context.tr.list,
                          titleSize: TitleSize.small,
                          columns: [
                            DataColumn(label: Text(context.tr.couponCode)),
                            DataColumn(label: Text(context.tr.status)),
                          ],
                          getRowCount: (data) =>
                              data.campaignCodes.nodes.length,
                          rowBuilder: (data, index) => _rowBuilder(
                            context,
                            data.campaignCodes.nodes[index],
                          ),
                          getPageInfo: (data) => data.campaignCodes.pageInfo,
                          data: state.giftCodes,
                          onPageChanged: bloc.onCodesPageChanged,
                          paging: state.giftCodesPaging,
                        ),
                      ),
                    ],
                  ),
                ),
              };
            },
          ),
        ),
      ),
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$campaignCode nod) {
    return DataRow(
      cells: [
        DataCell(Text(nod.code)),
        DataCell(
          nod.usedAt == null
              ? AppTag(text: context.tr.unused, color: SemanticColor.error)
              : AppTag(text: context.tr.used, color: SemanticColor.success),
        ),
      ],
    );
  }
}

class InfoPanelCell extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final bool hideDivider;

  const InfoPanelCell({
    super.key,
    required this.title,
    this.subtitle,
    this.subtitleWidget,
    this.hideDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.labelMedium?.variant(context)),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          Text(subtitle!, style: context.textTheme.labelMedium),
        ],
        if (subtitleWidget != null) ...[
          const SizedBox(height: 2),
          subtitleWidget!,
        ],
        if (!hideDivider) const Divider(),
      ],
    );
  }
}
