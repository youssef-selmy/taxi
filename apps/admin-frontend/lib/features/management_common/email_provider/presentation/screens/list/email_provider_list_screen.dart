import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/email_provider.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/management_common/email_provider/data/graphql/email_provider.graphql.dart';
import 'package:admin_frontend/features/management_common/email_provider/presentation/blocs/email_provider_list.cubit.dart';

@RoutePage()
class EmailProviderListScreen extends StatelessWidget {
  const EmailProviderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailProviderListBloc()..onStarted(),
      child: PageContainer(
        child: Column(
          children: [
            BlocBuilder<EmailProviderListBloc, EmailProviderListState>(
              builder: (context, state) {
                return PageHeader(
                  title: context.tr.emailProviders,
                  subtitle: context.tr.emailProvidersSubtitle,
                  showBackButton: false,
                  actions: [
                    AppFilledButton(
                      onPressed: () async {
                        await context.router.push(EmailProviderDetailsRoute());
                        context.read<EmailProviderListBloc>().onStarted();
                      },
                      text: context.tr.create,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<EmailProviderListBloc, EmailProviderListState>(
                builder: (context, state) {
                  return SafeArea(
                    top: false,
                    child: AppDataTable(
                      columns: [
                        DataColumn(label: Text(context.tr.name)),
                        DataColumn(label: Text(context.tr.emailsSent)),
                      ],
                      getRowCount: (data) => data.emailProviders.nodes.length,
                      rowBuilder: (data, index) =>
                          _rowBuilder(context, data, index),
                      getPageInfo: (data) => data.emailProviders.pageInfo,
                      data: state.emailProviders,
                      paging: state.paging,
                      onPageChanged: context
                          .read<EmailProviderListBloc>()
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
    Query$emailProviders data,
    int index,
  ) {
    final emailProvider = data.emailProviders.nodes[index];
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
                      Text(emailProvider.name),
                      if (emailProvider.isDefault) ...[
                        const SizedBox(width: 8),
                        AppTag(text: "Default", color: SemanticColor.success),
                      ],
                    ],
                  ),
                  Text(
                    "Provider: ${emailProvider.type.name}",
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                ],
              ),
            ],
          ),
        ),
        DataCell(Text("${emailProvider.emailsCount} ${context.tr.emails}")),
      ],
      onSelectChanged: (_) async {
        await context.router.push(
          EmailProviderDetailsRoute(emailProviderId: emailProvider.id),
        );
        context.read<EmailProviderListBloc>().onStarted();
      },
    );
  }
}
