import 'package:admin_frontend/core/router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/blocs/add_staff_detail.cubit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class NewStaffScreen extends StatelessWidget {
  NewStaffScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddStaffDetailBloc()..onStarted(),
      child: BlocConsumer<AddStaffDetailBloc, AddStaffDetailState>(
        listener: (context, state) {
          if (state.staff.isLoaded) {
            context.router.back();
          }
        },
        builder: (context, state) {
          return Container(
            margin: context.pagePadding,
            color: context.colors.surface,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  PageHeader(
                    title: context.tr.addNewStaff,
                    subtitle: context.tr.inputOperatorsDetailsBelow,
                    showBackButton: true,
                    onBackButtonPressed: () {
                      context.router.replace(const StaffListRoute());
                    },
                    actions: [
                      AppFilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AddStaffDetailBloc>().onAddStaff();
                          }
                        },
                        text: context.tr.register,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          label: context.tr.firstName,
                          hint: context.tr.enterFirstName,
                          onChanged: (value) => context
                              .read<AddStaffDetailBloc>()
                              .onFirstNameChanged(value),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: AppTextField(
                          label: context.tr.lastName,
                          hint: context.tr.enterLastName,
                          validator: context.validateName,
                          onChanged: (value) {
                            context
                                .read<AddStaffDetailBloc>()
                                .onLastNameChanged(value);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      if (state.roles.data != null)
                        Expanded(
                          child: AppDropdownField.single(
                            onChanged: (p0) => context
                                .read<AddStaffDetailBloc>()
                                .onRoleChanged(p0),
                            items: state.roles.data!
                                .map(
                                  (e) => AppDropdownItem(
                                    title: e.title,
                                    value: e.id,
                                  ),
                                )
                                .toList(),
                            label: context.tr.role,
                            validator: (value) => (value?.isEmpty ?? true)
                                ? context.tr.fieldIsRequired
                                : null,
                            hint: context.tr.selectRole,
                          ),
                        ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: AppTextField(
                          label: context.tr.userName,
                          hint: context.tr.enterUserName,
                          validator: FormBuilderValidators.required(),
                          onChanged: context
                              .read<AddStaffDetailBloc>()
                              .onUsernameChanged,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: FormBuilderValidators.password(),
                          label: context.tr.password,
                          hint: context.tr.enterPassword,
                          onChanged: (value) {
                            context
                                .read<AddStaffDetailBloc>()
                                .onPasswordChanged(value);
                          },
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: AppTextField(
                          label: context.tr.mobileNumber,
                          validator: FormBuilderValidators.required(),
                          hint: context.tr.enterPhoneNumber,
                          onChanged: (value) {
                            context.read<AddStaffDetailBloc>().onPhoneChanged(
                              value,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          label: context.tr.email,
                          validator: FormBuilderValidators.required(),
                          hint: context.tr.enterEmail,
                          onChanged: (value) {
                            context.read<AddStaffDetailBloc>().onEmailChanged(
                              value,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 24),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
