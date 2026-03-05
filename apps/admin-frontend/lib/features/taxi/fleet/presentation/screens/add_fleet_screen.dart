import 'package:admin_frontend/core/router/app_router.dart';
import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:better_design_system/organisms/phone_number_field/phone_number_field.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/map/geofence_form_field.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/add_fleet.cubit.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/widgets/warning_text_widget.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class AddFleetScreen extends StatefulWidget {
  const AddFleetScreen({super.key});

  @override
  State<AddFleetScreen> createState() => _AddFleetScreenState();
}

class _AddFleetScreenState extends State<AddFleetScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFleet(),
      child: BlocConsumer<AddFleet, AddFleetState>(
        listener: (context, state) {
          if (state.fleet.isLoaded) {
            context.showToast(context.tr.success, type: SemanticColor.success);
            context.router.replace(FleetListRoute());
          }
          if (state.fleet.isError) {
            context.showToast(
              state.fleet.errorMessage ?? context.tr.somethingWentWrong,
              type: SemanticColor.error,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              margin: context.pagePadding,
              color: context.colors.surface,
              child: Form(
                key: _formKey,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PageHeader(
                        title: context.tr.addNewFleet,
                        subtitle: context.tr.inputNewFleetsDetailsBelow,
                        showBackButton: true,
                        onBackButtonPressed: () =>
                            context.router.replace(FleetListRoute()),
                        actions: [
                          AppFilledButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AddFleet>().onAddFleet();
                              }
                            },
                            text: context.tr.register,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      LargeHeader(title: context.tr.information),
                      const SizedBox(height: 24),
                      Text(context.tr.image),
                      const SizedBox(height: 16),
                      UploadFieldSmall(
                        title: context.tr.uploadImage,
                        onChanged: (value) {
                          context.read<AddFleet>().onImageChanged(value);
                        },
                        initialValue: state.media,
                      ),
                      const SizedBox(height: 36),
                      LayoutGrid(
                        rowGap: 16,
                        columnGap: 16,
                        columnSizes: context.responsive(
                          [auto],
                          lg: [1.fr, 1.fr],
                        ),
                        rowSizes: const [
                          auto,
                          auto,
                          auto,
                          auto,
                          auto,
                          auto,
                          auto,
                        ],
                        children: <Widget>[
                          AppTextField(
                            label: context.tr.name,
                            hint: context.tr.enterName,
                            validator: FormBuilderValidators.required(),
                            onChanged: (value) =>
                                context.read<AddFleet>().onNameChanged(value),
                          ),
                          AppTextField(
                            label: context.tr.userName,
                            hint: context.tr.enterUserName,
                            initialValue: state.userName,
                            validator: FormBuilderValidators.required(),
                            onChanged: context
                                .read<AddFleet>()
                                .onUsernameChanged,
                          ),
                          AppPhoneNumberField(
                            initialValue: state.phoneNumber,
                            label: context.tr.phoneNumber,
                            hint: context.tr.enterPhoneNumber,
                            onChanged: (value) {
                              context.read<AddFleet>().onPhoneChanged(value);
                            },
                          ),
                          AppPhoneNumberField(
                            initialValue: state.phoneNumber,
                            label: context.tr.mobileNumber,
                            hint: context.tr.enterMobileNumber,
                            onChanged: (value) {
                              context.read<AddFleet>().onMobileNumberChanged(
                                value,
                              );
                            },
                          ),
                          AppTextField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            maxLines: 1,
                            validator: FormBuilderValidators.required(),
                            label: context.tr.password,
                            hint: context.tr.enterPassword,
                            onChanged: (value) {
                              context.read<AddFleet>().onPasswordChanged(value);
                            },
                          ),
                          const SizedBox(),
                          AppTextField(
                            label: context.tr.address,
                            validator: FormBuilderValidators.required(),
                            initialValue: state.address,
                            hint: context.tr.enterAddress,
                            onChanged: (value) {
                              context.read<AddFleet>().onAddressChanged(value);
                            },
                          ).withGridPlacement(
                            columnSpan: context.responsive(1, lg: 2),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      LargeHeader(title: context.tr.commission),
                      const SizedBox(height: 32),
                      LayoutGrid(
                        rowGap: 16,
                        columnGap: 16,
                        columnSizes: context.responsive(
                          [auto],
                          lg: [1.fr, 1.fr],
                        ),
                        rowSizes: const [auto, auto, auto, auto],
                        children: <Widget>[
                          AppNumberField(
                            initialValue: state.commissionSharePercent,
                            onChanged: (value) => context
                                .read<AddFleet>()
                                .onCommissionPercentageChanged(value),
                          ),
                          AppNumberField(
                            title: context.tr.commissionFlat,
                            onChanged: (value) => context
                                .read<AddFleet>()
                                .onCommissionFlatChanged(value),
                          ),
                          AppNumberField(
                            title: context.tr.feeMultiplier,
                            onChanged: (value) => context
                                .read<AddFleet>()
                                .onFeeMultiplierChanged(value),
                          ),
                          AppTextField(
                            label: context.tr.bankAccountInfo,
                            hint: context.tr.enterInformation,
                            validator: FormBuilderValidators.required(),
                            onChanged: (value) => context
                                .read<AddFleet>()
                                .onBankAccountInfoChanged(value),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      LargeHeader(title: context.tr.exclusivityArea),
                      const SizedBox(height: 32),
                      SizedBox(
                        height: 400,
                        child: AppGeofenceFormField(
                          validator: (value) => (value?.isEmpty ?? true)
                              ? context.tr.geofenceErrorMessage
                              : null,
                          onChanged: context
                              .read<AddFleet>()
                              .onExclusivityAreasChanged,
                          onSaved: (newValue) => [],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const WarningTextWidget(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
