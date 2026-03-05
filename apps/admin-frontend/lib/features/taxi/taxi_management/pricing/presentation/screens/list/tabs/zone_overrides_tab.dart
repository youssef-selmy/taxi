import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.mock.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/graphql/zone_price.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/blocs/zone_price_list.cubit.dart';
import 'package:better_icons/better_icons.dart';

class ZoneOverridesTab extends StatelessWidget {
  const ZoneOverridesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ZonePriceListBloc()..onStarted(),
      child: Column(
        children: [
          BlocBuilder<ZonePriceListBloc, ZonePriceListState>(
            builder: (context, state) {
              return Skeletonizer(
                enabled: state.categories.isLoading,
                child: Row(
                  children: [
                    Expanded(
                      // child: TabBarBordered<String>(
                      // selectedValue: state.categoryId,
                      // onSelected: (value) => context
                      //     .read<ZonePriceListBloc>()
                      //     .onCategoryChanged(value),
                      // items: (state.categories.data ?? mockZonePriceCategoies)
                      //     .map(
                      //       (e) => TabBarItem(
                      //         title: e.name,
                      //         value: e.id,
                      //       ),
                      //     )
                      //     .toList(),
                      // ),
                      child: AppTabMenuHorizontal(
                        style: TabMenuHorizontalStyle.soft,
                        tabs: (state.categories.data ?? mockZonePriceCategoies)
                            .map(
                              (e) => TabMenuHorizontalOption(
                                title: e.name,
                                value: e.id,
                              ),
                            )
                            .toList(),
                        selectedValue: state.categoryId,
                        onChanged: (value) {
                          context.read<ZonePriceListBloc>().onCategoryChanged(
                            value,
                          );
                        },
                      ),
                    ),
                    AppTextButton(
                      prefixIcon: BetterIcons.addCircleOutline,
                      color: SemanticColor.primary,
                      text: context.tr.newCategory,
                      onPressed: () {
                        context.router.push(ZonePriceCategoryDetailsRoute());
                      },
                    ),
                    const SizedBox(width: 16),
                    AppTextButton(
                      prefixIcon: BetterIcons.pencilEdit01Filled,
                      text: context.tr.edit,
                      color: SemanticColor.primary,
                      isDisabled: state.categoryId == null,
                      onPressed: () {
                        context.router.push(
                          ZonePriceCategoryDetailsRoute(
                            zonePriceCategoryId: state.categoryId,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<ZonePriceListBloc, ZonePriceListState>(
              builder: (context, state) {
                return Skeletonizer(
                  enabled: state.zonePrices.isLoading,
                  child: AppDataTable(
                    columns: [
                      DataColumn2(
                        label: Text(context.tr.name),
                        size: ColumnSize.S,
                      ),
                    ],
                    searchBarOptions: TableSearchBarOptions(
                      hintText: context.tr.searchWithDots,
                      onChanged: (value) => context
                          .read<ZonePriceListBloc>()
                          .onSearchQueryChanged(value),
                    ),
                    actions: [
                      AppOutlinedButton(
                        onPressed: () {
                          context.router.push(ZonePriceDetailsRoute());
                        },
                        text: context.tr.newZonePrice,
                        prefixIcon: BetterIcons.addCircleOutline,
                      ),
                    ],
                    getRowCount: (data) => data.zonePrices.nodes.length,
                    rowBuilder: (data, index) =>
                        _rowBuilder(context, data, index),
                    getPageInfo: (data) => data.zonePrices.pageInfo,
                    data: state.zonePrices,
                    onPageChanged: context
                        .read<ZonePriceListBloc>()
                        .onPageChanged,
                    paging: state.paging,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  DataRow _rowBuilder(BuildContext context, Query$zonePrices data, int index) {
    final row = data.zonePrices.nodes[index];
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(ZonePriceDetailsRoute(zonePriceId: row.id));
      },
      cells: [DataCell(Text(row.name, style: context.textTheme.labelMedium))],
    );
  }
}
