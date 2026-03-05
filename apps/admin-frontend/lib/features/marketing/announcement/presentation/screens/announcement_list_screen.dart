import 'package:admin_frontend/core/enums/app_type.enum.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/announcement.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/marketing/announcement/presentation/blocs/announcement_list.cubit.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class AnnouncementListScreen extends StatelessWidget {
  const AnnouncementListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnnouncementListBloc()..onStarted(),
      child: BlocBuilder<AnnouncementListBloc, AnnouncementListState>(
        builder: (context, state) {
          return PageContainer(
            child: Column(
              children: [
                PageHeader(
                  title: context.tr.announcements,
                  subtitle: context.tr.announcementsSubtitle,
                  showBackButton: false,
                  actions: [
                    AppOutlinedButton(
                      text: context.tr.add,
                      prefixIcon: BetterIcons.addCircleOutline,
                      onPressed: () async {
                        await context.router.push(
                          const CreateAnnouncementRoute(),
                        );
                        // context.read<AnnouncementListBloc>().onStarted();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child:
                      BlocBuilder<AnnouncementListBloc, AnnouncementListState>(
                        builder: (context, state) {
                          return AppDataTable(
                            minWidth: 400,
                            columns: [
                              DataColumn(label: Text(context.tr.name)),
                              DataColumn(label: Text("Targeted App")),
                              DataColumn(label: Text(context.tr.dateAndTime)),
                            ],
                            getRowCount: (data) =>
                                data.announcements.nodes.length,
                            rowBuilder: (data, index) => _rowBuilder(
                              context,
                              data.announcements.nodes[index],
                            ),
                            getPageInfo: (data) => data.announcements.pageInfo,
                            data: state.announcements,
                            paging: state.paging,
                            onPageChanged: context
                                .read<AnnouncementListBloc>()
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

  DataRow _rowBuilder(BuildContext context, Fragment$announcementListItem nod) {
    return DataRow(
      onSelectChanged: (selected) {
        context.router.push(AnnouncementDetailRoute(announcementId: nod.id));
      },
      cells: [
        DataCell(Text(nod.title)),
        DataCell(
          Text(
            [
              nod.appType?.displayName(context),
              nod.userType.isNotEmpty
                  ? nod.userType.map((e) => e.name).toList().join(', ')
                  : null,
            ].nonNulls.join(' - '),
          ),
        ),
        DataCell(Text((nod.startAt, nod.expireAt).toRange(context))),
      ],
    );
  }
}
