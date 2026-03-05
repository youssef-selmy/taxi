import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/customer_details.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class CustomerDetailsProfile extends StatelessWidget {
  const CustomerDetailsProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerDetailsBloc, CustomerDetailsState>(
      builder: (context, state) {
        if (state.customerDetailsState.isLoading) {
          return Center(child: CupertinoActivityIndicator());
        }
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
                    initialValue:
                        state.customerDetailsState.data?.firstName ?? "",
                    onFieldSubmitted: (value) => context
                        .read<CustomerDetailsBloc>()
                        .updateCustomerDetails(
                          Input$RiderInput(firstName: value),
                        ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    label: context.tr.lastName,
                    initialValue:
                        state.customerDetailsState.data?.lastName ?? "",
                    showEditButton: true,
                    onFieldSubmitted: (value) => context
                        .read<CustomerDetailsBloc>()
                        .updateCustomerDetails(
                          Input$RiderInput(lastName: value),
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    label: context.tr.email,
                    initialValue: state.customerDetailsState.data?.email ?? "",
                    showEditButton: true,
                    onFieldSubmitted: (value) => context
                        .read<CustomerDetailsBloc>()
                        .updateCustomerDetails(Input$RiderInput(email: value)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    label: context.tr.phone,
                    showEditButton: true,
                    onFieldSubmitted: (value) => context
                        .read<CustomerDetailsBloc>()
                        .updateCustomerDetails(
                          Input$RiderInput(mobileNumber: value),
                        ),
                    initialValue: state.customerDetailsState.data?.mobileNumber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppDropdownField.single(
                    label: context.tr.gender,
                    initialValue: state.customerDetailsState.data?.gender,
                    onChanged: (value) => context
                        .read<CustomerDetailsBloc>()
                        .updateCustomerDetails(Input$RiderInput(gender: value)),
                    items: [
                      AppDropdownItem<Enum$Gender>(
                        title: context.tr.genderMale,
                        value: Enum$Gender.Male,
                      ),
                      AppDropdownItem<Enum$Gender>(
                        title: context.tr.genderFemale,
                        value: Enum$Gender.Female,
                      ),
                      AppDropdownItem<Enum$Gender>(
                        title: context.tr.genderOther,
                        value: Enum$Gender.Other,
                      ),
                      AppDropdownItem<Enum$Gender>(
                        title: context.tr.genderUnknown,
                        value: Enum$Gender.Unknown,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        );
      },
    );
  }
}
