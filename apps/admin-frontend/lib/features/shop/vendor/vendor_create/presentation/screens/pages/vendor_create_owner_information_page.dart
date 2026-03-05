import 'package:better_design_system/organisms/phone_number_field/phone_number_field.dart';
import 'package:flutter/cupertino.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/gender.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_create/presentation/blocs/vendor_create.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class VendorCreateOwnerInformationPage extends StatelessWidget {
  const VendorCreateOwnerInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<VendorCreateBloc>();
    return BlocBuilder<VendorCreateBloc, VendorCreateState>(
      builder: (context, state) {
        return switch (state.vendorState) {
          ApiResponseError(:final message) => Center(child: Text(message)),
          ApiResponseInitial() => const SizedBox.shrink(),
          ApiResponseLoading() => const Center(
            child: CupertinoActivityIndicator(),
          ),
          ApiResponseLoaded() => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsive(16, lg: 40),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LargeHeader(
                    title: context.tr.ownerInformation,
                    size: HeaderSize.large,
                  ),
                  const SizedBox(height: 16),
                  LayoutGrid(
                    columnGap: 24,
                    rowGap: 16,
                    columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
                    rowSizes: List.generate(
                      context.responsive(5, lg: 4),
                      (index) => auto,
                    ),
                    children: [
                      AppTextField(
                        label: context.tr.firstName,
                        onChanged: bloc.onFirstNameChanged,
                        initialValue: state.ownerFirstName,
                      ),
                      AppTextField(
                        label: context.tr.lastName,
                        onChanged: bloc.onLastNameChanged,
                        initialValue: state.ownerLastName,
                      ),
                      AppTextField(
                        label: context.tr.email,
                        onChanged: bloc.onOwnerEmailChanged,
                        initialValue: state.ownerEmail,
                      ),
                      AppPhoneNumberField(
                        label: context.tr.mobileNumber,
                        onChanged: bloc.onOwnerPhoneNumberChanged,
                        initialValue: state.ownerPhoneNumber,
                      ),
                      AppDropdownField.single(
                        label: context.tr.gender,
                        items: Enum$Gender.values.toDropdownItems(context),
                        onChanged: bloc.onGenderChanged,
                        initialValue: state.ownerGender,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        };
      },
    );
  }
}
