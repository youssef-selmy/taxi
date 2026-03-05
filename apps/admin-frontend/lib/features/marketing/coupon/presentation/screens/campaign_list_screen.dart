import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/marketing/coupon/data/graphql/coupon.graphql.dart';
import 'package:admin_frontend/features/marketing/coupon/presentation/blocs/campaign_list.cubit.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class CampaignListScreen extends StatelessWidget {
  const CampaignListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CampaignListBloc()..onStarted(),
      child: PageContainer(
        child: Column(
          children: [
            PageHeader(
              title: context.tr.coupons,
              subtitle: context.tr.listOfAllCampaigns,
              showBackButton: false,
              actions: [
                AppOutlinedButton(
                  text: context.tr.add,
                  prefixIcon: BetterIcons.addCircleOutline,
                  onPressed: () async {
                    await context.router.push(const CreateCampaignRoute());
                    context.read<CampaignListBloc>().refresh();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<CampaignListBloc, CampaignListState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: AppDataTable(
                      minWidth: 600,
                      columns: [
                        DataColumn(label: Text(context.tr.name)),
                        DataColumn(label: Text(context.tr.status)),
                        DataColumn(label: Text(context.tr.batchSize)),
                        DataColumn(label: Text(context.tr.appType)),
                      ],
                      getRowCount: (data) => data.campaigns.nodes.length,
                      rowBuilder: (data, index) =>
                          _rowBuilder(context, data, index),
                      getPageInfo: (data) => data.campaigns.pageInfo,
                      data: state.campaigns,
                      paging: state.paging,
                      onPageChanged: context
                          .read<CampaignListBloc>()
                          .onPageChanged,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _rowBuilder(BuildContext context, Query$campaigns data, int index) {
    final campaign = data.campaigns.nodes[index];
    return DataRow(
      onSelectChanged: (selected) async {
        final bloc = context.read<CampaignListBloc>();
        await context.router.push(
          CampaignDetailsRoute(campaignId: campaign.id),
        );
        bloc.refresh();
      },
      cells: [
        DataCell(
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(campaign.name),
              Text(
                (campaign.startAt, campaign.expireAt).toRange(context),
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ],
          ),
        ),
        DataCell(
          (campaign.startAt, campaign.expireAt).toAvailabilityChip(context),
        ),
        DataCell(
          Text(
            context.tr.codesCount(
              campaign.codesAggregate.firstOrNull?.count?.id ?? 0,
            ),
          ),
        ),
        DataCell(Text(campaign.appType.map((e) => e.name).join(", "))),
      ],
    );
  }
}
