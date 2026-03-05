import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/blocs/staff_details.cubit.dart';

class StaffDetailProfile extends StatelessWidget {
  const StaffDetailProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffDetailsBloc, StaffDetailsState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: context.tr.firstName,
                    showEditButton: true,
                    initialValue: state.staff.data?.firstName ?? "",
                    onFieldSubmitted: (value) => context
                        .read<StaffDetailsBloc>()
                        .onFirstNameChanged(value),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    label: context.tr.lastName,
                    initialValue: state.staff.data?.lastName ?? "",
                    showEditButton: true,
                    onFieldSubmitted: (value) => context
                        .read<StaffDetailsBloc>()
                        .onLastNameChanged(value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (state.roles.data != null)
                  Expanded(
                    child: AppDropdownField.single(
                      initialValue: state.staff.data?.role?.id,
                      onChanged: (p0) =>
                          context.read<StaffDetailsBloc>().onRoleChanged(p0),
                      items: state.roles.data!
                          .map(
                            (e) => AppDropdownItem(title: e.title, value: e.id),
                          )
                          .toList(),
                      label: context.tr.role,
                      hint: context.tr.selectRole,
                    ),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    label: context.tr.userName,
                    initialValue: state.staff.data?.userName ?? "",
                    showEditButton: true,
                    onFieldSubmitted: (value) => context
                        .read<StaffDetailsBloc>()
                        .onUsernameChanged(value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: context.tr.phone,
                    initialValue: state.staff.data?.mobileNumber ?? "",
                    showEditButton: true,
                    onFieldSubmitted: (value) =>
                        context.read<StaffDetailsBloc>().onPhoneChanged(value),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    label: context.tr.email,
                    initialValue: state.staff.data?.email ?? "",
                    showEditButton: true,
                    onFieldSubmitted: (value) =>
                        context.read<StaffDetailsBloc>().onEmailChanged(value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                AppFilledButton(
                  onPressed: () {
                    context.read<StaffDetailsBloc>().updateStaffDetails();
                  },
                  text: context.tr.saveChanges,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
