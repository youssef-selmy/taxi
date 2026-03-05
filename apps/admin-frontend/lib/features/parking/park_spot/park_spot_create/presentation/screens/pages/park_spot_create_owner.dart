import 'package:better_design_system/organisms/phone_number_field/phone_number_field.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/gender.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_create/presentation/blocs/park_spot_create.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkSpotCreateOwner extends StatelessWidget {
  const ParkSpotCreateOwner({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkSpotCreateBloc>();
    return BlocBuilder<ParkSpotCreateBloc, ParkSpotCreateState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsive(16, lg: 40),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LargeHeader(title: context.tr.ownersInformation),
                const Divider(height: 32),
                const SizedBox(height: 16),
                LayoutGrid(
                  columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
                  rowSizes: context.responsive(
                    const [auto, auto, auto, auto, auto],
                    lg: [auto, auto, auto],
                  ),
                  rowGap: 16,
                  columnGap: 16,
                  children: [
                    AppTextField(
                      label: context.tr.firstName,
                      initialValue: state.ownerFirstName,
                      onChanged: bloc.onOwnerFirstNameChanged,
                    ),
                    AppTextField(
                      label: context.tr.lastName,
                      initialValue: state.ownerLastName,
                      onChanged: bloc.onOwnerLastNameChanged,
                    ),
                    AppTextField(
                      label: context.tr.email,
                      initialValue: state.ownerEmail,
                      onChanged: bloc.onOwnerEmailChanged,
                    ),
                    AppPhoneNumberField(
                      label: context.tr.mobileNumber,
                      initialValue: state.ownerPhoneNumber,
                      onChanged: bloc.onOwnerPhoneNumberChanged,
                    ),
                    AppDropdownField.single(
                      label: context.tr.gender,
                      items: Enum$Gender.values.toDropdownItems(context),
                      initialValue: state.ownerGender,
                      onChanged: bloc.onOwnerGenderChanged,
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 48,
                // ),
                // LargeHeader(title: context.translate.documents),
                // const Divider(height: 32),
                // const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
