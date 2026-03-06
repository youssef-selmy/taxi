import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

typedef BetterRatingDistribution = AppRatingDistribution;

class AppRatingDistribution extends StatelessWidget {
  final int oneStar;
  final int twoStar;
  final int threeStar;
  final int fourStar;
  final int fiveStar;
  final int? average;
  final int total;
  final bool isLoading;

  const AppRatingDistribution({
    super.key,
    required this.oneStar,
    required this.twoStar,
    required this.threeStar,
    required this.fourStar,
    required this.fiveStar,
    required this.average,
    required this.total,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final max =
        ((maxBy([oneStar, twoStar, threeStar, fourStar, fiveStar], (e) => e) ??
                    0) *
                1.4)
            .ceil();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(
              BetterIcons.starFilled,
              color: context.colors.warning,
              size: 32,
            ),
            const SizedBox(width: 4),
            Text(
              average == null ? '-' : (average! / 20).toStringAsFixed(1),
              style: context.textTheme.headlineSmall?.apply(
                color: context.colors.warning,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Based on $total ratings',
              style: context.textTheme.labelLarge?.variant(context),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _ratingDistributionItem(
          context: context,
          rating: 5,
          total: fiveStar,
          max: max,
        ),
        const SizedBox(height: 4),
        _ratingDistributionItem(
          context: context,
          rating: 4,
          total: fourStar,
          max: max,
        ),
        const SizedBox(height: 4),
        _ratingDistributionItem(
          context: context,
          rating: 3,
          total: threeStar,
          max: max,
        ),
        const SizedBox(height: 4),
        _ratingDistributionItem(
          context: context,
          rating: 2,
          total: twoStar,
          max: max,
        ),
        const SizedBox(height: 4),
        _ratingDistributionItem(
          context: context,
          rating: 1,
          total: oneStar,
          max: max,
        ),
      ],
    );
  }

  Row _ratingDistributionItem({
    required BuildContext context,
    required int rating,
    required int total,
    required int max,
  }) {
    return Row(
      spacing: 4,
      children: [
        ...List.generate(
          5,
          (index) => Icon(
            index < rating ? BetterIcons.starFilled : BetterIcons.starOutline,
            color: context.colors.warning,
            size: 16,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: LinearProgressIndicator(
            value: total / max,
            backgroundColor: context.colors.outline,
            valueColor: AlwaysStoppedAnimation(context.colors.warning),
            borderRadius: BorderRadius.circular(6),
            minHeight: 6,
          ),
        ),
        const SizedBox(width: 16),
        Text('$total', style: context.textTheme.labelMedium),
      ],
    );
  }
}
