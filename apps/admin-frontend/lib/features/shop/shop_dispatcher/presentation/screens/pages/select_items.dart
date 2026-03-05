import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/atoms/button/back_button.dart';
import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/select_items.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/shop_dispatcher.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/address_info.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/cart/cart.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/customer_profile.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/delivery_fee_time.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/items_grid.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/shop_categories_tab_bar.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/shops_grid.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/wallet_balance.dart';
import 'package:better_icons/better_icons.dart';

class SelectItems extends StatelessWidget {
  const SelectItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopDispatcherBloc, ShopDispatcherState>(
      listenWhen: (previous, current) =>
          previous.selectedCustomer != current.selectedCustomer ||
          previous.selectedAddress != current.selectedAddress,
      listener: (context, state) {
        if (state.selectedCustomer != null && state.selectedAddress != null) {
          context.read<SelectItemsBloc>().init(
            customerId: context
                .read<ShopDispatcherBloc>()
                .state
                .selectedCustomer!
                .id,
            addressId: context
                .read<ShopDispatcherBloc>()
                .state
                .selectedAddress!
                .id,
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                CustomerProfile(),
                SizedBox(width: 8),
                Expanded(child: AddressInfo()),
                WalletBalance(),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: BlocBuilder<SelectItemsBloc, SelectItemsState>(
                      builder: (context, state) {
                        if (state.selectedShop == null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextField(
                                isFilled: false,
                                prefixIcon: Icon(BetterIcons.search01Filled),
                                hint: context.tr.searchForShops,
                              ),
                              SizedBox(height: 8),
                              ShopCategoriesTabBar(),
                              SizedBox(height: 24),
                              Expanded(child: ShopsGrid()),
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextField(
                                isFilled: false,
                                prefixIcon: Icon(BetterIcons.search01Filled),
                                hint: context.tr.searchForItems,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  AppBackButton(
                                    onPressed: () {
                                      context
                                          .read<SelectItemsBloc>()
                                          .goBackFromShop();
                                    },
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${state.selectedShopCategory!.name} > ",
                                    style: context.textTheme.labelMedium,
                                  ),
                                  Text(
                                    state.selectedShop!.name,
                                    style: context.textTheme.labelMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (state.selectedShop?.image != null) ...[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            state.selectedShop!.image!.address,
                                        height: 90,
                                        width: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                  ],
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.selectedShop!.name,
                                          style: context.textTheme.titleMedium,
                                        ),
                                        RatingIndicator(
                                          rating: state
                                              .selectedShop!
                                              .ratingAggregate
                                              ?.rating,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      DeliveryFeeTime(
                                        shop: state.selectedShop!,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              const Expanded(child: ItemsGrid()),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (context.isDesktop) ...[
                    const SizedBox(
                      width: 250,
                      child: Column(children: [Cart()]),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: context.colors.outline)),
              color: context.colors.surface,
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                AppOutlinedButton(
                  prefixIcon: BetterIcons.arrowLeft02Outline,
                  onPressed: context.read<ShopDispatcherBloc>().goBack,
                  text: context.tr.back,
                ),
                const Spacer(),
                BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
                  builder: (context, state) {
                    return AppFilledButton(
                      isDisabled: state.carts.isEmpty,
                      onPressed: context
                          .read<ShopDispatcherBloc>()
                          .onItemsConfirmed,
                      text: context.tr.actionContinue,
                      suffixIcon: BetterIcons.arrowRight02Outline,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
