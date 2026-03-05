import 'package:admin_frontend/core/graphql/fragments/taxi_calculate_fare.fragment.graphql.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/blocs/dispatcher_taxi.cubit.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/components/customer_profile.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/components/ride_preferences.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/screens/dialogs/reserve_ride.dart';
import 'package:better_icons/better_icons.dart';

class SelectService extends StatelessWidget {
  const SelectService({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DispatcherTaxiBloc>();
    return Column(
      children: [
        Padding(
          padding: context.pagePaddingHorizontal,
          child: CustomerProfile(),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: context.pagePaddingHorizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppClickableCard(
                      padding: const EdgeInsets.all(16),
                      type: ClickableCardType.elevated,
                      elevation: BetterShadow.shadow4,
                      child:
                          BlocBuilder<DispatcherTaxiBloc, DispatcherTaxiState>(
                            builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    context.tr.taxiSelectServiceSubtitle,
                                    style: context.textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 16),
                                  AppToggleSwitchButtonGroup<int>(
                                    selectedValue:
                                        state.selectedServiceCategoryIndex,
                                    onChanged: context
                                        .read<DispatcherTaxiBloc>()
                                        .onServiceCategorySelected,
                                    options:
                                        state.fare?.services.mapIndexed((
                                          index,
                                          service,
                                        ) {
                                          return ToggleSwitchButtonGroupOption(
                                            label: service.name,
                                            value: index,
                                          );
                                        }).toList() ??
                                        [],
                                  ),
                                  const SizedBox(height: 16),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: 8,
                                    children: [
                                      ...(state
                                              .selectedServiceCategory
                                              ?.services
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                                final index = entry.key;
                                                final service = entry.value;
                                                return AppListItem(
                                                  onTap: (value) {
                                                    context
                                                        .read<
                                                          DispatcherTaxiBloc
                                                        >()
                                                        .onServiceSelected(
                                                          index,
                                                        );
                                                  },
                                                  padding: const EdgeInsets.all(
                                                    12,
                                                  ),
                                                  trailing: Text(
                                                    getCost(
                                                      service.costResult,
                                                      state.fare!.currency,
                                                    ),
                                                    style: context
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          color: context
                                                              .colors
                                                              .primary,
                                                        ),
                                                  ),
                                                  leading: CachedNetworkImage(
                                                    imageUrl:
                                                        service.media.address,
                                                    width: 48,
                                                    height: 48,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                              Icons.error,
                                                            ),
                                                  ),
                                                  title: service.name,
                                                  subtitle: service.description,
                                                  isSelected:
                                                      index ==
                                                      state
                                                          .selectedServiceIndex,
                                                );
                                              })
                                              .toList() ??
                                          []),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                    ),
                  ),
                  if (context.isDesktop) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppClickableCard(
                        padding: const EdgeInsets.all(16),
                        type: ClickableCardType.elevated,
                        elevation: BetterShadow.shadow4,
                        child: _getServiceOption(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (!context.isDesktop) ...[
          Padding(
            padding: context.pagePaddingHorizontal,
            child: _getServiceOption(context),
          ),
          SizedBox(height: 14),
        ],
        Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: context.colors.outline)),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              AppOutlinedButton(
                prefixIcon: BetterIcons.arrowLeft02Outline,
                onPressed: context.read<DispatcherTaxiBloc>().goBack,
                text: context.tr.back,
              ),
              const Spacer(),
              AppOutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    useSafeArea: false,
                    builder: (context) {
                      return BlocProvider.value(
                        value: bloc,
                        child: const ReserveRideDialog(),
                      );
                    },
                  );
                },
                prefixIcon: BetterIcons.clock01Filled,
                text: context.tr.reserveRide,
              ),
              const SizedBox(width: 8),
              AppFilledButton(
                onPressed: () {
                  context.read<DispatcherTaxiBloc>().onReserveRideDateChanged(
                    null,
                  );
                  context.read<DispatcherTaxiBloc>().onReserveRide();
                },
                text: context.tr.bookNow,
                suffixIcon: BetterIcons.arrowRight02Outline,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _getServiceOption(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(context.tr.ridePreferences, style: context.textTheme.titleMedium),
        const SizedBox(height: 16),
        SingleChildScrollView(child: RidePreferences()),
      ],
    );
  }

  String getCost(
    Fragment$TaxiCalculateFare$services$services$costResult costResult,
    String currency,
  ) {
    switch (costResult) {
      case Fragment$TaxiCalculateFare$services$services$costResult$$FixedCost():
        return costResult.cost.formatCurrency(currency);
      case Fragment$TaxiCalculateFare$services$services$costResult$$RangeCost():
        return '${costResult.min.formatCurrency(currency)} - ${costResult.max.formatCurrency(currency)}';
      default:
        return 'Non-supported cost type';
    }
  }
}
