import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/map_pin/rod_marker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/components/upload_field/multi_image_upload.dart';
import 'package:admin_frontend/core/enums/gender.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/blocs/park_spot_detail.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkSpotDetailDetailsTab extends StatelessWidget {
  const ParkSpotDetailDetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkSpotDetailBloc>();
    return BlocBuilder<ParkSpotDetailBloc, ParkSpotDetailState>(
      builder: (context, state) {
        return switch (state.parkSpotDetailState) {
          ApiResponseLoading() => const Center(
            child: CupertinoActivityIndicator(),
          ),
          ApiResponseLoaded() => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      label: context.tr.parkingName,
                      initialValue: state.parkingName,
                      onChanged: bloc.onNameChanged,
                    ).withGridPlacement(
                      columnSpan: context.responsive(1, lg: 2),
                    ),
                    AppTextField(
                      label: context.tr.description,
                      initialValue: state.description,
                      onChanged: bloc.onDescriptionChanged,
                    ).withGridPlacement(
                      columnSpan: context.responsive(1, lg: 2),
                    ),
                    AppTextField(
                      label: context.tr.email,
                      initialValue: state.email,
                      onChanged: bloc.onEmailChanged,
                    ),
                    AppTextField(
                      label: context.tr.mobileNumber,
                      initialValue: state.mobileNumber,
                      onChanged: bloc.onPhoneNumberChanged,
                    ),
                    MultiImageUpload(
                      images: state.images,
                      onChanged: bloc.onImagesChanged,
                    ).withGridPlacement(
                      columnSpan: context.responsive(1, lg: 2),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                LargeHeader(title: context.tr.ownerInformation),
                const Divider(height: 32),
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
                    AppTextField(
                      label: context.tr.mobileNumber,
                      onChanged: bloc.onOwnerPhoneNumberChanged,
                      initialValue: state.ownerPhoneNumber,
                    ),
                    AppDropdownField<Enum$Gender>.single(
                      label: context.tr.gender,
                      items: Enum$Gender.values.toDropdownItems(context),
                      onChanged: bloc.onGenderChanged,
                      initialValue: state.ownerGender,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                LargeHeader(title: context.tr.location),
                const Divider(height: 32),
                const SizedBox(height: 16),
                AppTextField(
                  label: context.tr.address,
                  onChanged: bloc.onAddressChanged,
                  initialValue: state.address,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 550,
                  child: AppGenericMap(
                    mode: MapViewMode.picker,
                    interactive: true,
                    hasSearchBar: true,
                    enableAddressResolve: true,
                    centerMarkerBuilder: (context, key, address) =>
                        AppRodMarker.centerMarker(
                          key: key,
                          title: context.tr.selectedLocation,
                        ),
                    onMapMoved: (event) => {
                      bloc.onCoordinateChanged(
                        event.latLng.toFragmentCoordinate(),
                      ),
                    },
                    initialLocation: state.coordinate
                        ?.toPlaceFragment(address: state.address ?? "")
                        .toGenericMapPlace(),
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppFilledButton(
                    onPressed: () => bloc.saveDetails(),
                    text: context.tr.saveChanges,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
