import 'package:flutter/material.dart';
import 'package:better_design_system/molecules/rating_distribution/rating_distribution.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppRatingDistribution)
Widget defaultRatingDistribution(BuildContext context) {
  return SizedBox(
    width: 500,
    child: AppRatingDistribution(
      oneStar: 10,
      twoStar: 20,
      threeStar: 30,
      fourStar: 40,
      fiveStar: 50,
      average: 94,
      total: 150,
    ),
  );
}
