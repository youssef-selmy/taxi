import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/region.graphql.mock.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/management_common/regions/data/graphql/regions.graphql.dart';
import 'package:admin_frontend/features/management_common/regions/presentation/blocs/regions.cubit.dart';
import 'package:better_icons/better_icons.dart';

class RegionsList extends StatelessWidget {
  const RegionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegionsBloc>();
    return Column(
      children: [
        BlocBuilder<RegionsBloc, RegionsState>(
          builder: (context, state) {
            return Skeletonizer(
              enabled: state.regionCategories.isLoading,
              child: Row(
                children: [
                  Expanded(
                    child: AppTabMenuHorizontal<String?>(
                      style: TabMenuHorizontalStyle.soft,
                      selectedValue: state.categoryId,
                      onChanged: (value) => bloc.onCategoryChanged(value),
                      tabs: [
                        TabMenuHorizontalOption(
                          title: context.tr.all,
                          value: null,
                        ),
                        ...(state.regionCategories.data ??
                                [mockRegionCategory1, mockRegionCategory2])
                            .map(
                              (e) => TabMenuHorizontalOption(
                                title: e.name,
                                value: e.id,
                              ),
                            ),
                      ],
                    ),
                  ),
                  AppTextButton(
                    prefixIcon: BetterIcons.addCircleOutline,
                    text: context.tr.newCategory,
                    color: SemanticColor.primary,
                    onPressed: () async {
                      await context.router.push(RegionCategoryDetailsRoute());
                      bloc.onStarted();
                    },
                  ),
                  const SizedBox(width: 16),
                  AppTextButton(
                    prefixIcon: BetterIcons.pencilEdit01Filled,
                    text: context.tr.edit,
                    isDisabled: state.categoryId == null,
                    onPressed: () async {
                      await context.router.push(
                        RegionCategoryDetailsRoute(
                          regionCategoryId: state.categoryId,
                        ),
                      );
                      bloc.onStarted();
                    },
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Expanded(
          child: BlocBuilder<RegionsBloc, RegionsState>(
            builder: (context, state) {
              return Skeletonizer(
                enabled: state.regions.isLoading,
                child: AppDataTable(
                  columns: [
                    DataColumn2(
                      label: Text(context.tr.name),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text(context.tr.currency),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text(context.tr.status),
                      size: ColumnSize.S,
                    ),
                  ],
                  searchBarOptions: TableSearchBarOptions(
                    hintText: context.tr.searchWithDots,
                    query: state.searchQuery,
                    onChanged: (value) => bloc.onSearch(value),
                  ),
                  actions: [
                    AppOutlinedButton(
                      onPressed: () async {
                        await context.router.push(RegionDetailsRoute());

                        bloc.onStarted();
                      },
                      text: context.tr.newRegion,
                      prefixIcon: BetterIcons.addCircleOutline,
                    ),
                  ],
                  getRowCount: (data) => data.regions.nodes.length,
                  rowBuilder: (data, index) =>
                      _rowBuilder(context, data, index, bloc),
                  getPageInfo: (data) => data.regions.pageInfo,
                  data: state.regions,
                  onPageChanged: bloc.onPageChanged,
                  paging: state.paging,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Query$regions data,
    int index,
    RegionsBloc bloc,
  ) {
    final row = data.regions.nodes[index];
    return DataRow(
      onSelectChanged: (value) async {
        await context.router.push(RegionDetailsRoute(regionId: row.id));
        bloc.onStarted();
      },
      cells: [
        DataCell(Text(row.name)),
        DataCell(Text(row.currency)),
        DataCell(row.enabled.toActiveInactiveChip(context)),
      ],
    );
  }
}
