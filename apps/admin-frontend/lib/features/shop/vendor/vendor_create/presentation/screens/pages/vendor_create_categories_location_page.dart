import 'package:flutter/cupertino.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/map_pin/rod_marker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_create/presentation/blocs/vendor_create.cubit.dart';

class VendorCreateCategoriesLocationPage extends StatelessWidget {
  const VendorCreateCategoriesLocationPage({super.key});

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
              padding: context.pagePaddingHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LargeHeader(
                    title: context.tr.categories,
                    size: HeaderSize.large,
                  ),
                  const SizedBox(height: 16),
                  switch (state.shopCategoriesState) {
                    ApiResponseLoaded(:final data) => AppDropdownField(
                      label: context.tr.categories,
                      items: data
                          .map(
                            (category) => AppDropdownItem(
                              title: category.name,
                              value: category,
                            ),
                          )
                          .toList(),
                      initialValue: state.categories,
                      isMultiSelect: true,
                      onMultiChanged: bloc.onCategoriesChanged,
                      showChips: true,
                    ),
                    _ => const SizedBox.shrink(),
                  },
                  LargeHeader(
                    title: context.tr.address,
                    size: HeaderSize.large,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: context.tr.address,
                    initialValue: state.address,
                    onChanged: bloc.onAddressChanged,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 600,
                    child: AppGenericMap(
                      interactive: true,
                      mode: MapViewMode.picker,
                      hasSearchBar: true,
                      onMapMoved: (event) =>
                          bloc.onLocationChanged(event.latLng),
                      centerMarkerBuilder: (context, key, address) =>
                          AppRodMarker.centerMarker(
                            key: key,
                            title: context.tr.selectedLocation,
                          ),
                      initialLocation: state.location
                          ?.toPlaceFragment(address: state.address ?? "")
                          .toGenericMapPlace(),
                    ),
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
