import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/kpi_card/delta_text.dart';
import 'package:admin_frontend/core/components/kpi_card/kpi_card_style_b.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/presentation/blocs/shop_order_list.cubit.dart';

class ShopOrderListStatisticsBox extends StatelessWidget {
  const ShopOrderListStatisticsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOrderListBloc, ShopOrderListState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.statistics.isLoading,
          child: LayoutGrid(
            columnSizes: context.responsive(
              [1.fr],
              lg: [1.fr, 1.fr, 1.fr, 1.fr],
            ),
            rowGap: 8,
            columnGap: 8,
            rowSizes: const [auto, auto, auto, auto],
            children: [
              KPICardStyleB(
                title: context.tr.totalOrders,
                value: 0.toStringAsFixed(0), // TODO: Actual values
                titleStyle: NumberCardTitleStyle.regular,
                subtitle: DeltaText(
                  timePeriod: DetailTimePeriod.vsLastWeek,
                  currentValue: 0.toDouble(),
                  previousValue: 0.toDouble(),
                ),
              ),
              KPICardStyleB(
                title: context.tr.totalRides,
                value: 0.toStringAsFixed(0), // TODO: Actual values
                titleStyle: NumberCardTitleStyle.regular,
                subtitle: DeltaText(
                  timePeriod: DetailTimePeriod.vsLastWeek,
                  currentValue: 0.toDouble(),
                  previousValue: 0.toDouble(),
                ),
              ),
              KPICardStyleB(
                title: context.tr.averageOrderValue,
                value: 0.toStringAsFixed(0), // TODO: Actual values
                titleStyle: NumberCardTitleStyle.regular,
                subtitle: DeltaText(
                  timePeriod: DetailTimePeriod.vsLastWeek,
                  currentValue: 0.toDouble(),
                  previousValue: 0.toDouble(),
                ),
              ),
              KPICardStyleB(
                title: context.tr.averageDeliveryTime,
                value: 0.toStringAsFixed(0), // TODO: Actual values
                titleStyle: NumberCardTitleStyle.regular,
                subtitle: DeltaText(
                  timePeriod: DetailTimePeriod.vsLastWeek,
                  currentValue: 0.toDouble(),
                  previousValue: 0.toDouble(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
