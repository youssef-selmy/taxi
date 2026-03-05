import 'package:admin_frontend/core/components/map/app_search_location_bar.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/map_pin/rod_pin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/address/address_list_item.dart';
import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/components/upsert_location/upsert_location.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/shop_dispatcher.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/customer_profile.dart';
import 'package:better_icons/better_icons.dart';

class SelectLocation extends StatelessWidget {
  const SelectLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: context.pagePaddingHorizontal,
          child: CustomerProfile(),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: context.pagePaddingHorizontal,
          child: Text(
            context.tr.selectLocations,
            style: context.textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 16),
        if (!context.isDesktop) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppSearchLocationBar(
              onPlaceSelected: (value) => context
                  .read<ShopDispatcherBloc>()
                  .onSearchLocationChanged(value),
            ),
          ),
          const SizedBox(height: 16),
        ],
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAlias,
            margin: context.pagePaddingHorizontal,
            decoration: BoxDecoration(
              border: context.isDesktop
                  ? Border.all(color: context.colors.outline)
                  : null,
              borderRadius: context.isDesktop ? BorderRadius.circular(8) : null,
            ),
            child: Row(
              children: [
                if (context.isDesktop)
                  Expanded(
                    child: BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
                      builder: (context, state) {
                        return AppGenericMap(
                          initialLocation: state.selectedAddress
                              ?.toGenericMapPlace(),
                          markers: [
                            if (state.selectedAddress != null)
                              AppRodPin.markerDestination(
                                id: state.selectedAddress!.id,
                                position: state.selectedAddress!.location
                                    .toLatLngLib(),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                Container(
                  width: 450,
                  padding: context.isDesktop ? const EdgeInsets.all(16) : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              context.tr.savedAddresses,
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                          AppTextButton(
                            text: context.tr.addNewAddress,
                            color: SemanticColor.primary,
                            onPressed: () {
                              showDialog(
                                context: context,
                                useSafeArea: false,
                                builder: (context) =>
                                    const UpsertLocationDialog(),
                              );
                            },
                            prefixIcon: BetterIcons.addCircleOutline,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child:
                            BlocBuilder<
                              ShopDispatcherBloc,
                              ShopDispatcherState
                            >(
                              builder: (context, state) {
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return AddressListItem(
                                      address: state.customerAddresses[index],
                                      onSelected: context
                                          .read<ShopDispatcherBloc>()
                                          .onAddressSelected,
                                    );
                                  },
                                  itemCount: state.customerAddresses.length,
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 48),
        Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: context.colors.outline)),
            color: context.colors.surface,
          ),
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                AppOutlinedButton(
                  prefixIcon: BetterIcons.arrowLeft02Outline,
                  onPressed: context.read<ShopDispatcherBloc>().goBack,
                  text: context.tr.back,
                ),
                const Spacer(),
                AppFilledButton(
                  onPressed: context
                      .read<ShopDispatcherBloc>()
                      .onAddressConfirmed,
                  text: context.tr.actionContinue,
                  suffixIcon: BetterIcons.arrowRight02Outline,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
