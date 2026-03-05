import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/components/tab_bar_bordered/tab_item_bordered.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/shop_dispatcher.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/delivery_fee_time.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/plus_minus_cart.dart';
import 'package:better_icons/better_icons.dart';

class ItemDetails extends StatefulWidget {
  final Fragment$shopItemListItem item;
  final Fragment$DispatcherShop shop;

  const ItemDetails({super.key, required this.item, required this.shop});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  late Fragment$ItemVariant selectedVariant;
  List<Fragment$ItemOption> selectedToppings = [];
  int quantity = 1;

  @override
  void initState() {
    selectedVariant = widget.item.variants.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      maxWidth: 700,
      icon: BetterIcons.creditCardFilled,
      title: context.tr.addToCart,
      onClosePressed: () {
        Navigator.of(context).pop();
      },
      child: BlocProvider(
        create: (context) => ShopDispatcherBloc(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.item.image != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: widget.item.image!.address,
                        height: 186,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    RatingIndicator(rating: widget.item.ratingAggregate.rating),
                    const SizedBox(height: 8),
                    Text(widget.item.name, style: context.textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (widget.shop.image != null) ...[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CachedNetworkImage(
                              imageUrl: widget.shop.image!.address,
                              height: 24,
                              width: 24,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          widget.shop.name,
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DeliveryFeeTime(shop: widget.shop),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr.selectSize,
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 10),
                  ...widget.item.variants.map((variant) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TabItemBordered(
                        padding: const EdgeInsets.all(8),
                        title: variant.name,
                        value: variant,
                        selectedValue: selectedVariant,
                        subtitle: variant.description,
                        suffixWidget: Text(
                          variant.price.formatCurrency(widget.shop.currency),
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.primary,
                          ),
                        ),
                        onSelected: (value) {
                          setState(() {
                            selectedVariant = value;
                          });
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  Text(
                    context.tr.selectYourToppings,
                    style: context.textTheme.bodyMedium,
                  ),
                  Text(
                    context.tr.chooseUpTo3Toppings,
                    style: context.textTheme.labelMedium,
                  ),
                  const SizedBox(height: 10),
                  ...widget.item.options.map((option) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Row(
                        children: [
                          Text(
                            option.name,
                            style: context.textTheme.labelMedium,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            option.price.formatCurrency(widget.shop.currency),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colors.primary,
                            ),
                          ),
                          const Spacer(),
                          Checkbox(
                            value: selectedToppings.contains(option),
                            onChanged: (value) {
                              if (value == true) {
                                if (selectedToppings.length < 3) {
                                  setState(() {
                                    selectedToppings.add(option);
                                  });
                                }
                              } else {
                                setState(() {
                                  selectedToppings.remove(option);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
                        builder: (context, state) {
                          return PlusMinusCart(
                            quantity: quantity,
                            onChanged: (quantity) {
                              setState(() {
                                this.quantity = quantity;
                              });
                            },
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AppFilledButton(
                          onPressed: () {
                            context.read<ShopDispatcherBloc>().onAddToCart(
                              shop: widget.shop,
                              item: widget.item,
                              itemVariant: selectedVariant,
                              itemOptions: selectedToppings,
                              quantity: quantity,
                            );
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                context.tr.addToCart,
                                style: context.textTheme.labelMedium,
                              ),
                              const Spacer(),
                              Text(
                                calculateTotalPrice().formatCurrency(
                                  widget.shop.currency,
                                ),
                                style: context.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTotalPrice() {
    double total = 0;
    total += selectedVariant.price;
    for (var option in selectedToppings) {
      total += option.price;
    }
    return total * quantity;
  }
}
