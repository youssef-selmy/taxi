import 'package:admin_frontend/core/enums/park_spot_facility.dart';
import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/park_spot_car_size.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/blocs/park_spot_detail.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkSpotDetailFacilitiesTab extends StatelessWidget {
  const ParkSpotDetailFacilitiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkSpotDetailBloc>();
    return BlocBuilder<ParkSpotDetailBloc, ParkSpotDetailState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LargeHeader(title: context.tr.vehicleType),
              const Divider(height: 32),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: kBorder(context),
                  boxShadow: kShadow(context),
                  borderRadius: BorderRadius.circular(8),
                  color: context.colors.surface,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: state.carSpaces > 0,
                          onChanged: (value) => bloc.toggleCarSpaces(),
                        ),
                        const SizedBox(width: 8),
                        Text(context.tr.cars),
                      ],
                    ),
                    if (state.carSpaces > 0) ...[
                      const SizedBox(height: 24),
                      AppNumberField.integer(
                        title: context.tr.howManyCarsCanPark,
                        initialValue: state.carSpaces,
                        onChanged: (value) =>
                            bloc.onCarSpacesChanged(value?.toInt()),
                      ),
                      const SizedBox(height: 24),
                      AppDropdownField.single(
                        label: context.tr.carSize,
                        initialValue: state.carSize,
                        onChanged: bloc.onCarSizeChanged,
                        items: Enum$ParkSpotCarSize.values.toDropdownItems(
                          context,
                        ),
                      ),
                      const SizedBox(height: 24),
                      AppNumberField(
                        title: context.tr.pricePerHour,
                        initialValue: state.carPrice,
                        onChanged: bloc.onCarPriceChanged,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: kBorder(context),
                  boxShadow: kShadow(context),
                  borderRadius: BorderRadius.circular(8),
                  color: context.colors.surface,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: state.bikeSpaces > 0,
                          onChanged: (value) => bloc.toggleBikeSpaces(),
                        ),
                        const SizedBox(width: 8),
                        Text(context.tr.bikes),
                      ],
                    ),
                    if (state.bikeSpaces > 0) ...[
                      const SizedBox(height: 24),
                      AppNumberField.integer(
                        title: context.tr.howManyBikesCanPark,
                        initialValue: state.bikeSpaces,
                        onChanged: (value) =>
                            bloc.onBikeSpacesChanged(value?.toInt()),
                      ),
                      const SizedBox(height: 24),
                      AppNumberField(
                        title: context.tr.pricePerHour,
                        initialValue: state.bikePrice,
                        onChanged: bloc.onBikePriceChanged,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: kBorder(context),
                  boxShadow: kShadow(context),
                  borderRadius: BorderRadius.circular(8),
                  color: context.colors.surface,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: state.truckSpaces > 0,
                          onChanged: (value) => bloc.toggleTruckSpaces(),
                        ),
                        const SizedBox(width: 8),
                        Text(context.tr.trucks),
                      ],
                    ),
                    if (state.truckSpaces > 0) ...[
                      const SizedBox(height: 24),
                      AppNumberField.integer(
                        title: context.tr.howManyTrucksCanPark,
                        initialValue: state.truckSpaces,
                        onChanged: (value) =>
                            bloc.onTruckSpacesChanged(value?.toInt()),
                      ),
                      const SizedBox(height: 24),
                      const SizedBox(height: 24),
                      AppNumberField(
                        title: context.tr.pricePerHour,
                        initialValue: state.truckPrice,
                        onChanged: bloc.onTruckPriceChanged,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 48),
              LargeHeader(title: context.tr.facilities),
              const Divider(height: 32),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final facility = Enum$ParkSpotFacility.values
                      .where(
                        (facility) =>
                            facility != Enum$ParkSpotFacility.$unknown,
                      )
                      .elementAt(index);
                  return AppListItem(
                    title: facility.name(context),
                    icon: facility.icon,
                    actionType: ListItemActionType.switcher,
                    isSelected: state.facilities.contains(facility),
                    onTap: (value) => bloc.toggleFacility(facility),
                  );
                },
                separatorBuilder: (context, index) => const Divider(height: 32),
                itemCount: Enum$ParkSpotFacility.values.length - 1,
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: AppFilledButton(
                  onPressed: () {
                    bloc.saveFacilitiesAndSpacePriceStatus();
                  },
                  text: context.tr.saveChanges,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
