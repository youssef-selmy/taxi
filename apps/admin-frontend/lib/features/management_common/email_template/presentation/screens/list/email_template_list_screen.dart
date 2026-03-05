import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/enums/email_event_type.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/management_common/email_template/data/graphql/email_template.graphql.dart';
import 'package:admin_frontend/features/management_common/email_template/presentation/blocs/email_template_list.cubit.dart';

@RoutePage()
class EmailTemplateListScreen extends StatelessWidget {
  const EmailTemplateListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailTemplateListBloc()..onStarted(),
      child: PageContainer(
        child: Column(
          children: [
            BlocBuilder<EmailTemplateListBloc, EmailTemplateListState>(
              builder: (context, state) {
                return PageHeader(
                  title: context.tr.emailTemplates,
                  subtitle: context.tr.emailTemplatesSubtitle,
                  showBackButton: false,
                  actions: [
                    AppFilledButton(
                      onPressed: () async {
                        await context.router.push(EmailTemplateDetailsRoute());
                        context.read<EmailTemplateListBloc>().onStarted();
                      },
                      text: context.tr.create,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<EmailTemplateListBloc, EmailTemplateListState>(
                builder: (context, state) {
                  return SafeArea(
                    top: false,
                    child: AppDataTable(
                      columns: [
                        DataColumn(label: Text(context.tr.name)),
                        DataColumn(label: Text(context.tr.eventType)),
                        DataColumn(label: Text(context.tr.status)),
                      ],
                      getRowCount: (data) => data.emailTemplates.nodes.length,
                      rowBuilder: (data, index) =>
                          _rowBuilder(context, data, index),
                      getPageInfo: (data) => data.emailTemplates.pageInfo,
                      data: state.emailTemplates,
                      paging: state.paging,
                      onPageChanged: context
                          .read<EmailTemplateListBloc>()
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
    Query$emailTemplates data,
    int index,
  ) {
    final emailTemplate = data.emailTemplates.nodes[index];
    return DataRow(
      cells: [
        DataCell(
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(emailTemplate.name),
              if (emailTemplate.locale != null)
                Text(
                  "Locale: ${emailTemplate.locale}",
                  style: context.textTheme.labelMedium?.variant(context),
                ),
            ],
          ),
        ),
        DataCell(Text(emailTemplate.eventType.name(context))),
        DataCell(
          AppTag(
            text: emailTemplate.isActive ? "Active" : "Inactive",
            color: emailTemplate.isActive
                ? SemanticColor.success
                : SemanticColor.neutral,
          ),
        ),
      ],
      onSelectChanged: (_) async {
        await context.router.push(
          EmailTemplateDetailsRoute(emailTemplateId: emailTemplate.id),
        );
        context.read<EmailTemplateListBloc>().onStarted();
      },
    );
  }
}
