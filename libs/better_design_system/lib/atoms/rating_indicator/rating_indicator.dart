import 'package:better_assets/assets.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

enum RatingIndicatorStyle {
  longWithoutText,
  longWithText,
  compactWithText,
  compactWithShortText,
}

typedef BetterRatingIndicator = AppRatingIndicator;

class AppRatingIndicator extends StatelessWidget {
  const AppRatingIndicator({
    super.key,
    this.direction = Axis.horizontal,
    this.style = RatingIndicatorStyle.compactWithShortText,
    this.rating,
    this.reviewCount,
  });

  final Axis direction;
  final RatingIndicatorStyle style;
  final double? rating;
  final int? reviewCount;

  @override
  Widget build(BuildContext context) {
    return Flex(
      crossAxisAlignment: direction == Axis.vertical
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      direction: direction,
      spacing: style == RatingIndicatorStyle.compactWithShortText ? 4 : 8,
      children: [
        if ([
          RatingIndicatorStyle.longWithText,
          RatingIndicatorStyle.longWithoutText,
        ].contains(style))
          Row(
            spacing: 2,
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(5, (index) => _getIcon(index + 1, context)),
            ],
          ),

        if ([
          RatingIndicatorStyle.compactWithShortText,
          RatingIndicatorStyle.compactWithText,
        ].contains(style)) ...[
          Icon(
            BetterIcons.starFilled,
            size: style == RatingIndicatorStyle.compactWithShortText ? 16 : 20,
            color: context.colors.warning,
          ),
        ],
        _getText(context),
      ],
    );
  }

  Widget _getText(BuildContext context) {
    return switch (style) {
      RatingIndicatorStyle.longWithText ||
      RatingIndicatorStyle.compactWithText => Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: rating?.toStringAsFixed(1) ?? '-',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.onSurface,
              ),
            ),
            TextSpan(
              text: ' / 5 Ratings - ${formatReviewCount()} review ',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      RatingIndicatorStyle.compactWithShortText => Row(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating?.toStringAsFixed(1) ?? '-',
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colors.warning,
            ),
          ),
          Text(
            '(${reviewCount ?? 0})',
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colors.onSurfaceVariantLow,
            ),
          ),
        ],
      ),
      RatingIndicatorStyle.longWithoutText => const SizedBox(),
    };
  }

  String formatReviewCount() {
    if (reviewCount == null) return '0';

    if (reviewCount! < 1000) {
      return reviewCount.toString();
    } else {
      final double countInK = reviewCount! / 1000;

      if (countInK == countInK.floorToDouble()) {
        return '${countInK.toInt()}K';
      } else {
        return '${countInK.toStringAsFixed(1)}K';
      }
    }
  }

  Widget _getIcon(int index, BuildContext context) {
    if ((rating ?? 0) >= index) {
      return Icon(
        BetterIcons.starFilled,
        size: 20,
        color: context.colors.warning,
      );
    } else if ((rating ?? 0) >= index - 0.5) {
      return Assets.images.shapes.starHalf.svg(
        colorFilter: ColorFilter.mode(context.colors.warning, BlendMode.srcIn),
      );
    } else {
      return Icon(
        BetterIcons.starOutline,
        size: 20,
        color: context.colors.warning,
      );
    }
  }
}
