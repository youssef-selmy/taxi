import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/select_items.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/screens/dialogs/item_details.dart';
import 'package:better_icons/better_icons.dart';

class ItemCard extends StatelessWidget {
  final Fragment$shopItemListItem item;
  final String currency;

  const ItemCard({super.key, required this.item, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        boxShadow: kElevation1(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (item.image != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: item.image!.address,
                height: 132,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
          ],
          // if (shop.rating != null) ...[
          //   Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       const Icon(
          //         BetterIcons.starFilled,
          //         color: AppColors.orange300,
          //         size: 16,
          //       ),
          //       const SizedBox(width: 4),
          //       Text(
          //         (shop.rating! / 20).toStringAsFixed(1),
          //         style: AppTextStyle.desktopCaptionSMedium,
          //       ),
          //     ],
          //   ),
          //   const SizedBox(height: 8),
          // ],
          Text(item.name, style: context.textTheme.labelMedium),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  item.basePrice.formatCurrency(currency),
                  style: context.textTheme.labelMedium,
                ),
              ),
              AppIconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ItemDetails(
                        item: item,
                        shop: context
                            .read<SelectItemsBloc>()
                            .state
                            .selectedShop!,
                      );
                    },
                  );
                },
                icon: BetterIcons.creditCardFilled,
                color: SemanticColor.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
