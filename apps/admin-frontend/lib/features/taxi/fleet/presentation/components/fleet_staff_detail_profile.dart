import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_staff_detail.cubit.dart';

class FleetStaffDetailProfile extends StatelessWidget {
  const FleetStaffDetailProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FleetStaffDetailBloc, FleetStaffDetailState>(
      listener: (context, state) {
        if (state.fleetStaffUpdate.isLoaded) {
          context.router.back();
        }
      },
      builder: (context, state) => SingleChildScrollView(
        child: Column(
          children: [
            LayoutGrid(
              rowGap: 16,
              columnGap: 16,
              columnSizes: context.responsive([auto], lg: [1.fr, 1.fr]),
              rowSizes: const [auto, auto, auto, auto, auto],
              children: <Widget>[
                AppTextField(
                  label: context.tr.firstName,
                  showEditButton: true,
                  initialValue: state.firstName,
                  onFieldSubmitted: (value) => context
                      .read<FleetStaffDetailBloc>()
                      .onFirstNameChanged(value),
                ),
                AppTextField(
                  label: context.tr.lastName,
                  initialValue: state.lastName,
                  showEditButton: true,
                  onFieldSubmitted: (value) => context
                      .read<FleetStaffDetailBloc>()
                      .onLastNameChanged(value),
                ),
                AppTextField(
                  label: context.tr.userName,
                  initialValue: state.userName,
                  showEditButton: true,
                  onFieldSubmitted: (value) => context
                      .read<FleetStaffDetailBloc>()
                      .onUsernameChanged(value),
                ),
                AppTextField(
                  label: context.tr.phoneNumber,
                  initialValue: state.phoneNumber,
                  showEditButton: true,
                  onFieldSubmitted: (value) => context
                      .read<FleetStaffDetailBloc>()
                      .onPhoneChanged(value),
                ),
                AppTextField(
                  label: context.tr.mobileNumber,
                  initialValue: state.mobileNumber,
                  showEditButton: true,
                  onFieldSubmitted: (value) => context
                      .read<FleetStaffDetailBloc>()
                      .onMobileNumberChanged(value),
                ),
                AppTextField(
                  label: context.tr.email,
                  initialValue: state.email,
                  showEditButton: true,
                  onFieldSubmitted: (value) => context
                      .read<FleetStaffDetailBloc>()
                      .onEmailChanged(value),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppFilledButton(
                  onPressed: () {
                    context.read<FleetStaffDetailBloc>().onUpdateFleetStaff();
                  },
                  text: context.tr.saveChanges,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
