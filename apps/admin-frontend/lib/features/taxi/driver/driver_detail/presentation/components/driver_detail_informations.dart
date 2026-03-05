import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/blocs/driver_detail.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverDetailInformations extends StatelessWidget {
  const DriverDetailInformations({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverDetailBloc>();
    return BlocBuilder<DriverDetailBloc, DriverDetailState>(
      buildWhen: (previous, current) {
        return previous.driverDetailResponse != current.driverDetailResponse;
      },
      builder: (context, state) {
        var driver = state.driverDetailResponse.data;
        return switch (state.driverDetailResponse) {
          ApiResponseInitial() => const SizedBox(),
          ApiResponseLoading() => const SizedBox(),
          ApiResponseError() => const SizedBox(),
          ApiResponseLoaded(:final data) => LayoutGrid(
            columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
            rowGap: 16,
            columnGap: 16,
            rowSizes: List.generate(
              context.responsive(17, lg: 9),
              (index) => auto,
            ),
            children: <Widget>[
              AppTextField(
                initialValue: data.driver.firstName,
                label: context.tr.firstName,
                hint: context.tr.enterFirstName,
                onChanged: bloc.onFirstNameChange,
                showEditButton: true,
              ),
              AppTextField(
                initialValue: data.driver.lastName,
                label: context.tr.lastName,
                hint: context.tr.enterLastName,
                onChanged: bloc.onLastNameChange,
                showEditButton: true,
              ),
              AppTextField(
                initialValue: data.driver.email,
                label: context.tr.email,
                hint: context.tr.enterEmail,
                onChanged: bloc.onEmailChange,
                showEditButton: true,
              ),
              AppTextField(
                label: context.tr.phoneNumber,
                initialValue: data.driver.mobileNumber,

                onChanged: bloc.onPhoneChange,
              ),
              AppDropdownField<Enum$Gender>.single(
                initialValue: data.driver.gender,
                items: Enum$Gender.values
                    .where((e) => e != Enum$Gender.$unknown)
                    .map((e) => AppDropdownItem(title: e.name, value: e))
                    .toList(),
                label: context.tr.gender,
                hint: context.tr.selectGender,
                onChanged: bloc.onGenderChange,
              ),
              AppDropdownField<Fragment$fleetListItem>.single(
                initialValue: driver?.fleets.nodes
                    .where((e) => e.id == data.driver.fleetId)
                    .firstOrNull,
                items:
                    state.driverDetailResponse.data?.fleets.nodes
                        .map((e) => AppDropdownItem(title: e.name, value: e))
                        .toList() ??
                    [],
                label: context.tr.fleets,
                hint: context.tr.selectFleet,
                onChanged: bloc.onFleetChange,
              ),
              AppDropdownField<Fragment$vehicleModel>.single(
                initialValue: driver?.carModels.nodes
                    .where((e) => e.id == data.driver.carId)
                    .firstOrNull,
                items:
                    state.driverDetailResponse.data?.carModels.nodes
                        .map((e) => AppDropdownItem(title: e.name, value: e))
                        .toList() ??
                    [],
                label: context.tr.carModel,
                hint: context.tr.selectCarModel,
                onChanged: bloc.onCarModelChange,
              ),
              AppDropdownField<Fragment$vehicleColor>.single(
                initialValue: driver?.carColors.nodes
                    .where((e) => e.id == data.driver.carColorId)
                    .firstOrNull,
                items:
                    state.driverDetailResponse.data?.carColors.nodes
                        .map((e) => AppDropdownItem(title: e.name, value: e))
                        .toList() ??
                    [],
                label: context.tr.carColor,
                hint: context.tr.selectCarColor,
                onChanged: bloc.onCarColorChange,
              ),
              AppNumberField.integer(
                initialValue: data.driver.carProductionYear,
                title: context.tr.carProductionYear,
                hint: context.tr.enterCarProductionYear,
                onChanged: bloc.onCarProductionYearChange,
              ),
              AppTextField(
                initialValue: data.driver.carPlate,
                label: context.tr.carPlateNumber,
                hint: context.tr.enterCarPlateNumber,
                onChanged: bloc.onCarPlateNumberChange,
                showEditButton: true,
              ),
              AppTextField(
                initialValue: data.driver.accountNumber,
                label: context.tr.accountNumber,
                hint: context.tr.enterAccountNumber,
                onChanged: bloc.onAccountNumberChange,
                showEditButton: true,
              ),
              AppTextField(
                initialValue: data.driver.bankName,
                label: context.tr.bankName,
                hint: context.tr.enterBankName,
                onChanged: bloc.onBankNameChange,
                showEditButton: true,
              ),
              AppTextField(
                initialValue: data.driver.bankRoutingNumber,
                label: context.tr.bankRoutingNumber,
                hint: context.tr.enterBankRoutingNumber,
                onChanged: bloc.onBankRoutingNumberChange,
                showEditButton: true,
              ),
              AppTextField(
                initialValue: data.driver.bankSwift,
                label: context.tr.bankSwift,
                hint: context.tr.enterBankSwift,
                onChanged: bloc.onBankSwiftChange,
                showEditButton: true,
              ),
              AppTextField(
                initialValue: data.driver.address,
                label: context.tr.address,
                hint: context.tr.enterAddress,
                onChanged: bloc.onAddressChange,
                showEditButton: true,
              ).withGridPlacement(columnSpan: context.responsive(1, lg: 2)),
            ],
          ),
        };
      },
    );
  }
}
