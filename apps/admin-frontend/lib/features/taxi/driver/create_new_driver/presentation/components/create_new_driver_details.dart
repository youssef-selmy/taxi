import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:better_design_system/organisms/phone_number_field/phone_number_field.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/presentation/blocs/create_new_driver.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class CreateNewDriverDetails extends StatelessWidget {
  const CreateNewDriverDetails({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateNewDriverBloc>();
    return BlocBuilder<CreateNewDriverBloc, CreateNewDriverState>(
      builder: (context, state) {
        return Form(
          key: state.formKeyDriverDetails,
          child: BlocBuilder<CreateNewDriverBloc, CreateNewDriverState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: switch (state.driverDetailsState) {
                  ApiResponseInitial() => const SizedBox(),
                  ApiResponseLoading() || ApiResponseLoaded() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LargeHeader(title: context.tr.details),
                      const SizedBox(height: 16),
                      const AppDivider(height: 1),
                      const SizedBox(height: 24),
                      Skeletonizer(
                        enabled: state.driverDetailsState.isLoading,
                        enableSwitchAnimation: true,
                        child: Column(
                          crossAxisAlignment: context.responsive(
                            CrossAxisAlignment.center,
                            lg: CrossAxisAlignment.start,
                          ),
                          children: <Widget>[
                            UploadFieldSmall(
                              initialValue: state.profileImage,
                              validator: FormBuilderValidators.required(),
                              title: context.tr.profilePicture,
                              onChanged: bloc.onProfileImageChanged,
                            ),
                            const SizedBox(height: 24),
                            LayoutGrid(
                              columnSizes: context.responsive(
                                [1.fr],
                                lg: [1.fr, 1.fr],
                              ),
                              rowGap: 16,
                              columnGap: 16,
                              rowSizes: List.generate(
                                context.responsive(17, lg: 9),
                                (index) => auto,
                              ),
                              children: <Widget>[
                                AppTextField(
                                  initialValue: state.firstName,
                                  label: context.tr.firstName,
                                  validator: FormBuilderValidators.required(),
                                  hint: context.tr.enterFirstName,
                                  onChanged: bloc.onFirstNameChange,
                                ),
                                AppTextField(
                                  initialValue: state.lastName,
                                  label: context.tr.lastName,
                                  validator: FormBuilderValidators.required(),
                                  hint: context.tr.enterLastName,
                                  onChanged: bloc.onLastNameChange,
                                ),
                                AppPhoneNumberField(
                                  initialValue: state.phoneNumber,
                                  label: context.tr.phone,
                                  validator: FormBuilderValidators.required(),
                                  hint: context.tr.enterPhone,
                                  onChanged: bloc.onPhoneChange,
                                ),
                                AppTextField(
                                  initialValue: state.email,
                                  label: context.tr.email,
                                  hint: context.tr.enterEmail,
                                  onChanged: bloc.onEmailChange,
                                ),
                                AppDropdownField.single(
                                  initialValue: state.gender,
                                  items: Enum$Gender.values
                                      .where(
                                        (e) =>
                                            e != Enum$Gender.Unknown &&
                                            e != Enum$Gender.$unknown,
                                      )
                                      .map(
                                        (e) => AppDropdownItem(
                                          title: e.name,
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                  label: context.tr.gender,
                                  hint: context.tr.selectGender,
                                  onChanged: bloc.onGenderChange,
                                ),
                                AppDropdownField.single(
                                  initialValue: state.fleet,
                                  items:
                                      state
                                          .driverDetailsState
                                          .data
                                          ?.fleets
                                          .nodes
                                          .map(
                                            (e) => AppDropdownItem(
                                              title: e.name,
                                              value: e,
                                            ),
                                          )
                                          .toList() ??
                                      <
                                        AppDropdownItem<Fragment$fleetListItem>
                                      >[],
                                  label: context.tr.fleets,
                                  hint: context.tr.selectFleet,
                                  onChanged: bloc.onFleetChange,
                                ),
                                AppDropdownField<Fragment$vehicleModel>.single(
                                  initialValue: state.carModel,
                                  items:
                                      state
                                          .driverDetailsState
                                          .data
                                          ?.carModels
                                          .nodes
                                          .map(
                                            (e) => AppDropdownItem(
                                              title: e.name,
                                              value: e,
                                            ),
                                          )
                                          .toList() ??
                                      [],
                                  label: context.tr.carModel,
                                  hint: context.tr.selectCarModel,
                                  onChanged: bloc.onCarModelChange,
                                ),
                                AppDropdownField<Fragment$vehicleColor>.single(
                                  initialValue: state.carColor,
                                  items:
                                      state
                                          .driverDetailsState
                                          .data
                                          ?.carColors
                                          .nodes
                                          .map(
                                            (e) => AppDropdownItem(
                                              title: e.name,
                                              value: e,
                                            ),
                                          )
                                          .toList() ??
                                      [],
                                  label: context.tr.carColor,
                                  hint: context.tr.selectCarColor,
                                  onChanged: bloc.onCarColorChange,
                                ),
                                AppNumberField.integer(
                                  initialValue: state.carProductionYear,
                                  title: context.tr.carProductionYear,
                                  hint: context.tr.enterCarProductionYear,
                                  onChanged: bloc.onCarProductionYearChange,
                                ),
                                AppTextField(
                                  initialValue: state.carPlateNumber,
                                  label: context.tr.carPlateNumber,
                                  hint: context.tr.enterCarPlateNumber,
                                  onChanged: bloc.onCarPlateNumberChange,
                                ),
                                AppTextField(
                                  initialValue: state.accountNumber,
                                  label: context.tr.accountNumber,
                                  hint: context.tr.enterAccountNumber,
                                  onChanged: bloc.onAccountNumberChange,
                                ),
                                AppTextField(
                                  initialValue: state.bankName,
                                  label: context.tr.bankName,
                                  hint: context.tr.enterBankName,
                                  onChanged: bloc.onBankNameChange,
                                ),
                                AppTextField(
                                  initialValue: state.bankRoutingNumber,
                                  label: context.tr.bankRoutingNumber,
                                  hint: context.tr.enterBankRoutingNumber,
                                  onChanged: bloc.onBankRoutingNumberChange,
                                ),
                                AppTextField(
                                  initialValue: state.bankSwift,
                                  label: context.tr.bankSwift,
                                  hint: context.tr.enterBankSwift,
                                  onChanged: bloc.onBankSwiftChange,
                                ),
                                AppTextField(
                                  initialValue: state.password,
                                  label: context.tr.password,
                                  hint: context.tr.enterPassword,
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  onChanged: bloc.onPasswordChange,
                                ),
                                const SizedBox(),
                                AppTextField(
                                  initialValue: state.address,
                                  label: context.tr.address,
                                  hint: context.tr.enterAddress,
                                  onChanged: bloc.onAddressChange,
                                ).withGridPlacement(
                                  columnSpan: context.responsive(1, lg: 2),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ApiResponseError(:final message) => Text(message),
                },
              );
            },
          ),
        );
      },
    );
  }
}
