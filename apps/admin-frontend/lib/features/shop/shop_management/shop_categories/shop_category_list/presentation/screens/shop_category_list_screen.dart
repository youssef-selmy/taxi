import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_category_list/presentation/blocs/shop_category_list.bloc.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class ShopCategoryListScreen extends StatelessWidget {
  const ShopCategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCategoryListBloc()..onStarted(),
      child: BlocBuilder<ShopCategoryListBloc, ShopCategoryListState>(
        builder: (context, state) {
          return Container(
            padding: context.pagePadding,
            color: context.colors.surface,
            child: Column(
              children: [
                PageHeader(
                  title: context.tr.shopCategories,
                  subtitle: context.tr.shopCategoriesSubtitle,
                  actions: [
                    AppOutlinedButton(
                      onPressed: () async {
                        await context.router.push(
                          ShopCategoryDetailRoute(shopCategoryId: null),
                        );

                        // ignore: use_build_context_synchronously
                        context.read<ShopCategoryListBloc>().onStarted();
                      },
                      text: context.tr.add,
                      prefixIcon: BetterIcons.addCircleOutline,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: AppDataTable(
                    empty: TableEmptyState(
                      actionText: context.tr.newCategory,
                      onActionPressed: () async {
                        await context.router.push(
                          ShopCategoryDetailRoute(shopCategoryId: null),
                        );
                        // ignore: use_build_context_synchronously
                        context.read<ShopCategoryListBloc>().onStarted();
                      },
                    ),
                    columns: [
                      DataColumn(label: Text(context.tr.name)),
                      DataColumn(label: Text(context.tr.shopsCountTitle)),
                    ],
                    getRowCount: (data) => data.shopCategories.nodes.length,
                    rowBuilder: (data, index) =>
                        _rowBuilder(context, data.shopCategories.nodes[index]),
                    getPageInfo: (data) => data.shopCategories.pageInfo,
                    data: state.shopCategoriesState,
                    onPageChanged: context
                        .read<ShopCategoryListBloc>()
                        .onPageChanged,
                    paging: state.paging,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$shopCategory nod) =>
      DataRow(
        onSelectChanged: (value) async {
          await context.router.push(
            ShopCategoryDetailRoute(shopCategoryId: nod.id),
          );
          // ignore: use_build_context_synchronously
          context.read<ShopCategoryListBloc>().onStarted();
        },
        cells: [
          DataCell(
            Row(
              children: [
                nod.image.widget(),
                const SizedBox(width: 8),
                Text(nod.name),
              ],
            ),
          ),
          DataCell(Text(context.tr.shopsCount(nod.shops.totalCount))),
        ],
      );
}
