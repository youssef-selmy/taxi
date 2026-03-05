import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/customer/create_customer/presentation/blocs/create_customer.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class CreateCustomerScreen extends StatelessWidget {
  const CreateCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateCustomerBloc(),
      child: BlocConsumer<CreateCustomerBloc, CreateCustomerState>(
        listener: (context, state) {
          if (state.saveState.isLoaded) {
            context.router.replace(
              CustomerDetailsRoute(
                customerId: state.saveState.data!.createOneRider.id,
              ),
            );
          }
        },
        builder: (context, state) => Container(
          margin: context.pagePadding,
          color: context.colors.surface,
          child: Column(
            children: [
              PageHeader(
                title: context.tr.createCustomer,
                subtitle: context.tr.createCustomerSubtitle,
                showBackButton: true,
                actions: [
                  AppFilledButton(
                    onPressed: () {
                      context.read<CreateCustomerBloc>().onAddCustomer();
                    },
                    text: context.tr.register,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        AppTextField(
                          label: context.tr.firstName,
                          hint: context.tr.enterFirstName,
                          onChanged: (value) {
                            context
                                .read<CreateCustomerBloc>()
                                .onFirstNameChanged(value);
                          },
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: context.tr.lastName,
                          hint: context.tr.enterLastName,
                          onChanged: (value) {
                            context
                                .read<CreateCustomerBloc>()
                                .onLastNameChanged(value);
                          },
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: context.tr.phone,
                          hint: context.tr.enterPhoneNumber,
                          onChanged: (value) {
                            context.read<CreateCustomerBloc>().onPhoneChanged(
                              value,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: context.tr.email,
                          hint: context.tr.enterEmail,
                          onChanged: (value) {
                            context.read<CreateCustomerBloc>().onEmailChanged(
                              value,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        AppDropdownField.single(
                          onChanged: (p0) => context
                              .read<CreateCustomerBloc>()
                              .onGenderChanged(p0),
                          items: [
                            AppDropdownItem(
                              title: context.tr.genderMale,
                              value: Enum$Gender.Male,
                            ),
                            AppDropdownItem(
                              title: context.tr.genderFemale,
                              value: Enum$Gender.Female,
                            ),
                            AppDropdownItem(
                              title: context.tr.genderUnknown,
                              value: Enum$Gender.Unknown,
                            ),
                          ],
                          label: context.tr.gender,
                        ),
                      ],
                    ),
                  ),
                  if (context.isDesktop) const Expanded(child: SizedBox()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
