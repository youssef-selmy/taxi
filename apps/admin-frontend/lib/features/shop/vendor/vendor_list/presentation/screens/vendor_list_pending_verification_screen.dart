import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/enums/shop_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_list/presentation/blocs/vendor_list_pending_verification.cubit.dart';

@RoutePage()
class VendorListPendingVerificationScreen extends StatelessWidget {
  const VendorListPendingVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VendorListPendingVerificationBloc()..onStarted(),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: Column(
          children: [
            PageHeader(
              title: context.tr.pendingShops,
              subtitle: context.tr.pendingShopsSubtitle,
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  BlocBuilder<
                    VendorListPendingVerificationBloc,
                    VendorListPendingVerificationState
                  >(
                    builder: (context, state) {
                      return AppDataTable(
                        columns: [
                          DataColumn(label: Text(context.tr.name)),
                          DataColumn(label: Text(context.tr.categories)),
                          DataColumn(label: Text(context.tr.mobileNumber)),
                          DataColumn2(
                            label: Text(context.tr.status),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                            label: const SizedBox(),
                            size: ColumnSize.S,
                          ),
                        ],
                        getRowCount: (data) => data.shops.nodes.length,
                        rowBuilder: (data, index) =>
                            _rowBuilder(context, data.shops.nodes[index]),
                        getPageInfo: (data) => data.shops.pageInfo,
                        data: state.vendorsState,
                        paging: state.paging,
                        onPageChanged: context
                            .read<VendorListPendingVerificationBloc>()
                            .onPageChanged,
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

  DataRow _rowBuilder(BuildContext context, Fragment$shopListItem node) {
    return DataRow(
      cells: [
        DataCell(node.tableView(context)),
        DataCell(node.categories.toChips()),
        DataCell(
          AppLinkButton(
            onPressed: () {
              launchUrlString("tel:+${node.mobileNumber.number}");
            },
            text: node.mobileNumber.number.formatPhoneNumber(null),
            alwaysUnderline: false,
          ),
        ),
        DataCell(node.status.chip(context)),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppFilledButton(
                text: context.tr.verify,
                size: ButtonSize.medium,
                onPressed: () {
                  context.router.push(VendorCreateRoute(vendorId: node.id));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
