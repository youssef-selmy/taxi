import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/rating_indicator/rating_indicator.dart';
import 'package:better_design_system/atoms/tag/tag.dart';

import 'package:skeletonizer/skeletonizer.dart';

class ProductEntity {
  final String id;
  final String name;
  final String? description;
  final int stockQuantity;
  final double basePrice;
  final DateTime? discountUntil;
  final double discountPercentage;
  final int discountedQuantity;
  final int usedDiscountedQuantity;
  final String image;
  final String shopImage;
  final String shopName;
  final int minimumPreparationTime;
  final int maximumPreparationTime;
  final int? rating;
  final int reviewCount;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.stockQuantity,
    required this.basePrice,
    required this.discountUntil,
    required this.discountPercentage,
    required this.discountedQuantity,
    required this.usedDiscountedQuantity,
    required this.image,
    required this.shopImage,
    required this.shopName,
    required this.minimumPreparationTime,
    required this.maximumPreparationTime,
    required this.rating,
    required this.reviewCount,
  });
}

typedef BetterFoodProductCard = AppFoodProductCard;

class AppFoodProductCard extends StatelessWidget {
  final ApiResponse<ProductEntity> itemResponse;
  final String currency;
  final Function() onPressed;

  const AppFoodProductCard({
    super.key,
    required this.itemResponse,
    required this.currency,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final item = itemResponse.data;
    return Skeletonizer(
      enabled: itemResponse.isLoading,
      enableSwitchAnimation: true,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 350, maxHeight: 250),
        decoration: BoxDecoration(
          boxShadow: context.isDark ? [] : [kShadow8(context)],
        ),
        child: AppClickableCard(
          onTap: onPressed,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (item != null)
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: ColorFiltered(
                            colorFilter: (item.stockQuantity) < 0
                                ? const ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode.saturation,
                                  )
                                : ColorFilter.mode(
                                    context.colors.transparent,
                                    BlendMode.multiply,
                                  ),
                            child: CachedNetworkImage(
                              imageUrl: item.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    if (item?.discountPercentage != null &&
                        (item?.discountPercentage ?? 0) > 0)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: AppTag(
                          style: TagStyle.fill,
                          text: '${item!.discountPercentage}%',
                          color: SemanticColor.success,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(
                        color: context.colors.outline,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        AppAvatar(
                          imageUrl: item?.shopImage,
                          placeholder: AvatarPlaceholder.shop,
                          size: AvatarSize.md16px,
                          enabledBorder: true,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item?.shopName ?? '------',
                          style: context.textTheme.bodySmall?.variant(context),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (item?.rating != null && (item?.reviewCount ?? 0) > 0)
                    AppRatingIndicator(
                      rating: (item?.rating?.toDouble() ?? 0) / 20,
                      reviewCount: item?.reviewCount ?? 10,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(item?.name ?? '------', style: context.textTheme.bodyMedium),
              if (itemResponse.isLoading == false && item?.description != null)
                Text(
                  itemResponse.isLoading ? 'Loading...' : item!.description!,
                  style: context.textTheme.bodySmall?.variantLow(context),
                ),
              const SizedBox(height: 4),
              if ((item?.discountPercentage ?? 0) > 0)
                Row(
                  children: [
                    Text(
                      _discountedPrice.formatCurrency(currency),
                      style: context.textTheme.labelLarge,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      (item?.basePrice ?? 0).formatCurrency(currency),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colors.onSurfaceVariant,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              if ((item?.discountPercentage ?? 0) <= 0)
                Text(
                  (item?.basePrice ?? 0).formatCurrency(currency),
                  style: context.textTheme.labelLarge,
                ),
            ],
          ),
        ),
      ),
    );
  }

  double get _discountedPrice =>
      (itemResponse.data?.basePrice ?? 0) *
      (1 - (itemResponse.data?.discountPercentage ?? 0) / 100);
}
