import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/sms_provider.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/management_common/sms_provider/data/graphql/sms_provider.graphql.dart';
import 'package:admin_frontend/features/management_common/sms_provider/presentation/blocs/sms_provider_list.cubit.dart';

@RoutePage()
class SmsProviderListScreen extends StatelessWidget {
  const SmsProviderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SmsProviderListBloc()..onStarted(),
      child: PageContainer(
        child: Column(
          children: [
            BlocBuilder<SmsProviderListBloc, SmsProviderListState>(
              builder: (context, state) {
                return PageHeader(
                  title: context.tr.smsProviders,
                  subtitle: context.tr.smsProvidersSubtitle,
                  showBackButton: false,
                  actions: [
                    AppFilledButton(
                      onPressed: () async {
                        await context.router.push(SmsProviderDetailsRoute());
                        context.read<SmsProviderListBloc>().onStarted();
                      },
                      text: context.tr.create,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<SmsProviderListBloc, SmsProviderListState>(
                builder: (context, state) {
                  return SafeArea(
                    top: false,
                    child: AppDataTable(
                      columns: [
                        DataColumn(label: Text(context.tr.name)),
                        DataColumn(label: Text(context.tr.smsSent)),
                      ],
                      getRowCount: (data) => data.smsProviders.nodes.length,
                      rowBuilder: (data, index) =>
                          _rowBuilder(context, data, index),
                      getPageInfo: (data) => data.smsProviders.pageInfo,
                      data: state.smsProviders,
                      paging: state.paging,
                      onPageChanged: context
                          .read<SmsProviderListBloc>()
                          .onPageChanged,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Query$smsProviders data,
    int index,
  ) {
    final smsProvider = data.smsProviders.nodes[index];
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(smsProvider.name),
                      if (smsProvider.isDefault) ...[
                        const SizedBox(width: 8),
                        AppTag(text: "Default", color: SemanticColor.success),
                      ],
                    ],
                  ),
                  Text(
                    "Provider: ${smsProvider.type.name}",
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                ],
              ),
            ],
          ),
        ),
        DataCell(Text("${smsProvider.messagesCount} ${context.tr.messages}")),
      ],
      onSelectChanged: (_) async {
        await context.router.push(
          SmsProviderDetailsRoute(smsProviderId: smsProvider.id),
        );
        context.read<SmsProviderListBloc>().onStarted();
      },
    );
  }
}
