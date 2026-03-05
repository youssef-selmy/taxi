import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/molecules/list_item/list_action.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/enums/service_option.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/blocs/dispatcher_taxi.cubit.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/components/ride_preference_checkable_item.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class RidePreferences extends StatelessWidget {
  const RidePreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DispatcherTaxiBloc, DispatcherTaxiState>(
      builder: (context, state) {
        if (state.selectedService == null) return const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (state.selectedService!.options.any(
              (element) => element.icon == Enum$ServiceOptionIcon.TwoWay,
            ))
              RidePreferenceCheckableItem(
                title: context.tr.twoWayTrip,
                icon: BetterIcons.alert02Filled,
                isSelected: state.isRoundTrip,
                onChanged: (p0) {
                  context.read<DispatcherTaxiBloc>().setRoundTrip(p0);
                },
              ),
            AppListItem(
              title: context.tr.waitTime,
              icon: BetterIcons.clock01Filled,
              isCompact: true,
              initialSelectedItem: state.waitingTime,
              actionType: ListItemActionType.dropdown,
              onDropdownValueChanged: context
                  .read<DispatcherTaxiBloc>()
                  .setWaitingTime,
              items: [
                AppDropdownItem(title: context.tr.noWaitTime, value: 0),
                AppDropdownItem(
                  title: context.tr.minutesRange("0-5"),
                  value: 5,
                ),
                AppDropdownItem(
                  title: context.tr.minutesRange("5-10"),
                  value: 10,
                ),
                AppDropdownItem(
                  title: context.tr.minutesRange("10-15"),
                  value: 15,
                ),
                AppDropdownItem(
                  title: context.tr.minutesRange("15-20"),
                  value: 20,
                ),
                AppDropdownItem(
                  title: context.tr.minutesRange("20-25"),
                  value: 25,
                ),
                AppDropdownItem(
                  title: context.tr.minutesRange("25-30"),
                  value: 30,
                ),
                AppDropdownItem(
                  title: context.tr.minutesRange("30-35"),
                  value: 35,
                ),
                AppDropdownItem(
                  title: context.tr.minutesRange("35-40"),
                  value: 40,
                ),
                AppDropdownItem(
                  title: context.tr.minutesRange("40-45"),
                  value: 45,
                ),
                AppDropdownItem(
                  title: context.tr.minutesRange("45-50"),
                  value: 50,
                ),
                AppDropdownItem(
                  title: context.tr.minutesRange("50-55"),
                  value: 55,
                ),
                AppDropdownItem(
                  title: context.tr.minutesRange("55-60"),
                  value: 60,
                ),
                AppDropdownItem(
                  title: context.tr.minutesRange("60-65"),
                  value: 65,
                ),
              ],
            ),
            ...state.selectedService!.options
                .where(
                  (element) => element.icon != Enum$ServiceOptionIcon.TwoWay,
                )
                .map(
                  (e) => RidePreferenceCheckableItem(
                    title: e.name,
                    icon: e.icon.icon,
                    fee: e.additionalFee,
                    currency: state.fare!.currency,
                    isSelected:
                        state.rideOptions.firstWhereOrNull(
                          (element) => element.id == e.id,
                        ) !=
                        null,
                    onChanged: (value) {
                      context.read<DispatcherTaxiBloc>().setRideOption(
                        e,
                        value,
                      );
                    },
                  ),
                ),
          ],
        );
      },
    );
  }
}
