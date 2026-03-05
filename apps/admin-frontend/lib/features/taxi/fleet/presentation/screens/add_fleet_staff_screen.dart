import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_staff_create.cubit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class AddFleetStaffScreen extends StatelessWidget {
  AddFleetStaffScreen({super.key, required this.fleetID});
  final String fleetID;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FleetStaffCreateBloc()..onFleetIdChanged(fleetID),
      child: BlocConsumer<FleetStaffCreateBloc, FleetStaffCreateState>(
        listener: (context, state) {
          if (state.fleetStaffCreate.isLoaded) {
            context.router.back();
          }
        },
        builder: (context, state) {
          return Container(
            margin: context.pagePadding,
            color: context.colors.surface,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PageHeader(
                      title: context.tr.addNewStaff,
                      subtitle: context.tr.inputOperatorsDetailsBelow,
                      showBackButton: true,
                      actions: [
                        AppFilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<FleetStaffCreateBloc>()
                                  .onCreateFleetStaff();
                            }
                          },
                          text: context.tr.register,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    LayoutGrid(
                      rowGap: 16,
                      columnGap: 16,
                      columnSizes: context.responsive([auto], lg: [1.fr, 1.fr]),
                      rowSizes: const [auto, auto, auto, auto, auto, auto],
                      children: <Widget>[
                        AppTextField(
                          label: context.tr.firstName,
                          hint: context.tr.enterFirstName,
                          onChanged: (value) => context
                              .read<FleetStaffCreateBloc>()
                              .onFirstNameChanged(value),
                          validator: context.validateName,
                        ),
                        AppTextField(
                          label: context.tr.lastName,
                          hint: context.tr.enterLastName,
                          validator: context.validateName,
                          onChanged: (value) {
                            context
                                .read<FleetStaffCreateBloc>()
                                .onLastNameChanged(value);
                          },
                        ),
                        AppTextField(
                          label: context.tr.userName,
                          hint: context.tr.enterUserName,
                          validator: FormBuilderValidators.required(),
                          onChanged: context
                              .read<FleetStaffCreateBloc>()
                              .onUsernameChanged,
                        ),
                        AppTextField(
                          label: context.tr.password,
                          hint: context.tr.enterPassword,
                          validator: FormBuilderValidators.password(),
                          onChanged: context
                              .read<FleetStaffCreateBloc>()
                              .onPasswordChanged,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          maxLines: 1,
                        ),
                        AppTextField(
                          validator: FormBuilderValidators.required(),
                          label: context.tr.phoneNumber,
                          hint: context.tr.enterPhoneNumber,
                          onChanged: (value) {
                            context.read<FleetStaffCreateBloc>().onPhoneChanged(
                              value,
                            );
                          },
                        ),
                        AppTextField(
                          label: context.tr.email,
                          validator: FormBuilderValidators.required(),
                          hint: context.tr.enterEmail,
                          onChanged: (value) {
                            context.read<FleetStaffCreateBloc>().onEmailChanged(
                              value,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
