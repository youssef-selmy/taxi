import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/service_option.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/blocs/taxi_order_detail.bloc.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/components/taxi_order_fleet_section.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/components/taxi_order_summary_section.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';

class TaxiOrderRideDetailBox extends StatelessWidget {
  const TaxiOrderRideDetailBox({super.key, this.borderless = false});

  final bool borderless;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOrderDetailBloc, TaxiOrderDetailState>(
      builder: (context, state) {
        final order = state.orderDetailResponse.data ?? mockOrdersItem1;
        return Skeletonizer(
          enabled: state.orderDetailResponse.isLoading,
          enableSwitchAnimation: true,
          child: AppClickableCard(
            type: ClickableCardType.elevated,
            borderLess: borderless,
            elevation: BetterShadow.shadow8,
            padding: borderless ? EdgeInsets.all(0) : EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                LargeHeader(title: context.tr.rideDetails),
                SizedBox(height: 12),
                Text(
                  '${context.tr.serviceDetails}:',
                  style: context.textTheme.bodyMedium?.variant(context),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    border: Border.all(color: context.colors.outline),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  order.service.imageUrl.widget(
                                    width: 32,
                                    height: 32,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    order.service.name,
                                    style: context.textTheme.labelLarge,
                                  ),
                                  Text(
                                    "",
                                    style: context.textTheme.bodySmall?.variant(
                                      context,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                runSpacing: 10,
                                spacing: 10,
                                runAlignment: WrapAlignment.spaceEvenly,
                                children: List.generate(order.options.length, (
                                  int index,
                                ) {
                                  return Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          border: kBorder(context),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            order.options[index].icon.icon,
                                            size: 16,
                                            color: context.colors.primary,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        order.options[index].icon.name(context),
                                        style: context.textTheme.labelMedium,
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          order.totalCost.formatCurrency(order.currency),
                          style: context.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const TaxiOrderSummarySection(),
                const Divider(height: 32),
                const TaxiOrderFleetSection(),
              ],
            ),
          ),
        );
      },
    );
  }
}
