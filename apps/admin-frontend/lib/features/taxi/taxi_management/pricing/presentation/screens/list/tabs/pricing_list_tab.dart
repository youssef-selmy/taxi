import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.mock.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/blocs/pricing_list.cubit.dart';
import 'package:better_icons/better_icons.dart';

class PricingListTab extends StatelessWidget {
  const PricingListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PricingListBloc()..onStarted(),
      child: Column(
        children: [
          BlocBuilder<PricingListBloc, PricingListState>(
            builder: (context, state) {
              return Skeletonizer(
                enabled: state.categories.isLoading,
                child: Row(
                  children: [
                    Expanded(
                      child: AppTabMenuHorizontal(
                        style: TabMenuHorizontalStyle.soft,
                        tabs:
                            (state.categories.data ?? mockTaxiPricingCategories)
                                .map(
                                  (e) => TabMenuHorizontalOption(
                                    title: e.name,
                                    value: e.id,
                                  ),
                                )
                                .toList(),
                        selectedValue: state.categoryId,
                        onChanged: (value) {
                          context.read<PricingListBloc>().onCategoryChanged(
                            value,
                          );
                        },
                      ),
                    ),
                    AppTextButton(
                      prefixIcon: BetterIcons.addCircleOutline,
                      text: context.tr.newCategory,
                      color: SemanticColor.primary,
                      onPressed: () async {
                        await context.router.push(
                          PricingCategoryDetailsRoute(),
                        );
                        // ignore: use_build_context_synchronously
                        context.read<PricingListBloc>().onStarted();
                      },
                    ),
                    const SizedBox(width: 16),
                    AppTextButton(
                      prefixIcon: BetterIcons.pencilEdit01Filled,
                      text: context.tr.edit,
                      color: SemanticColor.primary,
                      onPressed: () async {
                        await context.router.push(
                          PricingCategoryDetailsRoute(
                            pricingCategoryId: state.categoryId,
                          ),
                        );
                        // ignore: use_build_context_synchronously
                        context.read<PricingListBloc>().onStarted();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<PricingListBloc, PricingListState>(
              builder: (context, state) {
                return Skeletonizer(
                  enabled: state.pricings.isLoading,
                  child: AppDataTable(
                    columns: [
                      DataColumn2(
                        label: Text(context.tr.name),
                        size: ColumnSize.S,
                      ),
                    ],
                    searchBarOptions: TableSearchBarOptions(
                      hintText: context.tr.searchWithDots,
                      onChanged: (value) =>
                          context.read<PricingListBloc>().onSearch(value),
                    ),
                    actions: [
                      AppOutlinedButton(
                        onPressed: () async {
                          await context.router.push(PricingDetailsRoute());
                          // ignore: use_build_context_synchronously
                          context.read<PricingListBloc>().onStarted();
                        },
                        text: context.tr.newPricing,
                        prefixIcon: BetterIcons.addCircleOutline,
                      ),
                    ],
                    getRowCount: (data) => data.length,
                    rowBuilder: (data, index) =>
                        _rowBuilder(context, data, index),
                    getPageInfo: null,
                    data: state.pricings,
                    onPageChanged: (page) {
                      context.read<PricingListBloc>().onPageChanged(page);
                    },
                    paging: null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    List<Fragment$taxiPricingListItem> data,
    int index,
  ) {
    final row = data[index];
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(PricingDetailsRoute(pricingId: row.id));
      },
      cells: [
        DataCell(AppProfileCell(name: row.name, imageUrl: row.media.address)),
      ],
    );
  }
}
