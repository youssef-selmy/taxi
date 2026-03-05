import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/data/graphql/vehicle.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/presentation/blocs/vehicle_color_list.cubit.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/presentation/blocs/vehicle_model_list.cubit.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VehicleModelListBloc()..onStarted()),
        BlocProvider(create: (context) => VehicleColorListBloc()..onStarted()),
      ],
      child: SingleChildScrollView(
        padding: context.pagePadding,
        child: SafeArea(
          top: false,
          child: Container(
            color: context.colors.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PageHeader(
                  title: context.tr.vehicles,
                  subtitle: context.tr.vehiclesSubtitle,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 500,
                  child: Card(
                    child:
                        BlocBuilder<
                          VehicleModelListBloc,
                          VehicleModelListState
                        >(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: AppDataTable(
                                useSafeArea: false,
                                isHeaderTransparent: true,
                                columns: [
                                  DataColumn(label: Text(context.tr.name)),
                                ],
                                searchBarOptions: TableSearchBarOptions(
                                  isCompact: true,
                                  onChanged: context
                                      .read<VehicleModelListBloc>()
                                      .onSearch,
                                ),
                                actions: [
                                  AppOutlinedButton(
                                    onPressed: () async {
                                      await context.router.push(
                                        VehicleModelDetailsRoute(),
                                      );
                                      context
                                          .read<VehicleModelListBloc>()
                                          .onStarted();
                                    },
                                    text: context.tr.add,
                                    prefixIcon: BetterIcons.addCircleOutline,
                                  ),
                                ],
                                getRowCount: (data) =>
                                    data.vehicleModels.nodes.length,
                                rowBuilder: (data, index) =>
                                    _vehicleModelRowBuilder(
                                      context,
                                      data,
                                      index,
                                    ),
                                getPageInfo: (data) =>
                                    data.vehicleModels.pageInfo,
                                data: state.networkState,
                                title: context.tr.vehicleModels,
                                titleSize: TitleSize.small,
                                onPageChanged: context
                                    .read<VehicleModelListBloc>()
                                    .onPageChanged,
                                paging: state.paging,
                              ),
                            );
                          },
                        ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 500,
                  child: Card(
                    child:
                        BlocBuilder<
                          VehicleColorListBloc,
                          VehicleColorListState
                        >(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: AppDataTable(
                                isHeaderTransparent: true,
                                useSafeArea: false,
                                columns: [
                                  DataColumn(label: Text(context.tr.name)),
                                ],
                                searchBarOptions: TableSearchBarOptions(
                                  isCompact: true,
                                  onChanged: context
                                      .read<VehicleColorListBloc>()
                                      .onSearch,
                                ),
                                actions: [
                                  AppOutlinedButton(
                                    onPressed: () async {
                                      await context.router.push(
                                        VehicleColorDetailsRoute(),
                                      );
                                      context
                                          .read<VehicleColorListBloc>()
                                          .onStarted();
                                    },
                                    text: context.tr.add,
                                    prefixIcon: BetterIcons.addCircleOutline,
                                  ),
                                ],
                                titleSize: TitleSize.small,
                                getRowCount: (data) =>
                                    data.vehicleColors.nodes.length,
                                rowBuilder: (data, index) =>
                                    _vehicleColorRowBuilder(
                                      context,
                                      data,
                                      index,
                                    ),
                                getPageInfo: (data) =>
                                    data.vehicleColors.pageInfo,
                                data: state.networkState,
                                title: context.tr.vehicleColors,
                                onPageChanged: context
                                    .read<VehicleColorListBloc>()
                                    .onPageChanged,
                                paging: state.paging,
                              ),
                            );
                          },
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataRow _vehicleModelRowBuilder(
    BuildContext context,
    Query$vehicleModels data,
    int index,
  ) {
    final item = data.vehicleModels.nodes[index];
    return DataRow(
      onSelectChanged: (value) =>
          context.router.push(VehicleModelDetailsRoute(modelId: item.id)),
      cells: [DataCell(Text(item.name))],
    );
  }

  DataRow _vehicleColorRowBuilder(
    BuildContext context,
    Query$vehicleColors data,
    int index,
  ) {
    final item = data.vehicleColors.nodes[index];
    return DataRow(
      onSelectChanged: (value) =>
          context.router.push(VehicleColorDetailsRoute(colorId: item.id)),
      cells: [DataCell(Text(item.name))],
    );
  }
}
