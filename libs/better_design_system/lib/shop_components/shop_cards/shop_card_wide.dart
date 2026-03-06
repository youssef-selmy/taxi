import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/rating_indicator/rating_indicator.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShopEntity {
  final String name;
  final String? headerImage;
  final String? avatarImage;
  final bool isInactive;
  final double? deliveryFee;
  final int? deliveryTimeMin;
  final int? deliveryTimeMax;
  final int? rating;
  final int? reviewCount;
  final String? description;

  ShopEntity({
    required this.name,
    required this.headerImage,
    required this.avatarImage,
    required this.isInactive,
    required this.deliveryFee,
    required this.deliveryTimeMin,
    required this.deliveryTimeMax,
    required this.rating,
    required this.reviewCount,
    required this.description,
  });
}

typedef BetterShopCardWide = AppShopCardWide;

class AppShopCardWide extends StatelessWidget {
  final ApiResponse<ShopEntity> shopResponse;
  final String currency;
  final Function() onPressed;

  const AppShopCardWide({
    super.key,
    required this.shopResponse,
    required this.onPressed,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final shop = shopResponse.data;
    return Skeletonizer(
      enabled: shopResponse.isLoading,
      enableSwitchAnimation: true,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300, maxHeight: 250),
        child: AppClickableCard(
          onTap: onPressed,
          elevation: context.isDark
              ? BetterShadow.shadow0
              : BetterShadow.shadow8,
          type: ClickableCardType.elevated,
          isDisabled: shop?.isInactive ?? false,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned.fill(
                      child: _featureImage(
                        shop?.headerImage,
                        shop?.isInactive ?? false,
                        context,
                      ),
                    ),
                    Positioned(
                      left: 4,
                      bottom: -24,
                      child: _avatar(
                        shop?.avatarImage,
                        shop?.isInactive ?? false,
                        context,
                      ),
                    ),
                    if (shop?.rating != null && (shop?.reviewCount ?? 0) > 0)
                      Positioned(
                        right: 0,
                        bottom: -24,
                        child: AppRatingIndicator(
                          rating: (shop?.rating?.toDouble() ?? 0) / 20,
                          reviewCount: shop?.reviewCount ?? 10,
                        ),
                      ),
                    if (shop?.isInactive ?? false)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: AppTag(
                          text: context.strings.closed,
                          color: SemanticColor.error,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                shop?.name ?? '---------',
                style: context.textTheme.bodyLarge,
              ),
              if (shop?.description != null || shopResponse.isLoading) ...[
                const SizedBox(height: 8),
                Text(
                  shop?.description ??
                      '---------------------------------------------------------------',
                  style: context.textTheme.bodySmall?.variantLow(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (shopResponse.isLoading == false &&
                  (shop?.deliveryFee != null ||
                      (shop?.deliveryTimeMin != null &&
                          shop?.deliveryTimeMax != null))) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (shop?.deliveryFee != null) ...[
                      Icon(
                        BetterIcons.truckDeliveryOutline,
                        color: context.colors.primary,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        shop?.deliveryFee?.formatCurrency(currency) ?? '-----',
                        style: context.textTheme.bodySmall?.variant(context),
                      ),
                    ],
                    if (shop?.deliveryTimeMin != null &&
                        shop?.deliveryTimeMax != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colors.onSurfaceVariantLow,
                        ),
                      ),

                      const SizedBox(width: 8),
                      Icon(
                        BetterIcons.clock01Outline,
                        color: context.colors.onSurfaceVariantLow,
                        size: 16,
                      ),

                      const SizedBox(width: 4),
                      Text(
                        '${shop?.deliveryTimeMin} - ${shop?.deliveryTimeMax} min',
                        style: context.textTheme.bodySmall?.variant(context),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureImage(
    String? imageUrl,
    bool isInactive,
    BuildContext context,
  ) => switch (imageUrl) {
    String() => ColorFiltered(
      colorFilter: isInactive
          ? const ColorFilter.mode(Colors.grey, BlendMode.saturation)
          : ColorFilter.mode(context.colors.transparent, BlendMode.multiply),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: 100,
          fit: BoxFit.fill,
        ),
      ),
    ),
    null => Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: context.colors.surfaceContainer,
      ),
    ),
  };

  Widget _avatar(String? imageUrl, bool isInactive, BuildContext context) =>
      switch (imageUrl) {
        String() => ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: ColorFiltered(
            colorFilter: isInactive
                ? const ColorFilter.mode(Colors.grey, BlendMode.saturation)
                : ColorFilter.mode(
                    context.colors.transparent,
                    BlendMode.multiply,
                  ),
            child: AppAvatar(
              imageUrl: imageUrl,
              size: AvatarSize.size40px,
              enabledBorder: true,
            ),
          ),
        ),
        null => const SizedBox(width: 40, height: 40),
      };
}
