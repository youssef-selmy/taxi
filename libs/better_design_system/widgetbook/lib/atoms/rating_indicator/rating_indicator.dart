import 'package:better_design_system/atoms/rating_indicator/rating_indicator.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppRatingIndicator)
Widget appRatingReview(BuildContext context) {
  return AppRatingIndicator(
    rating: context.knobs.double.slider(label: 'Rating', max: 5),
    style: context.knobs.object.dropdown(
      label: 'Style',
      options: RatingIndicatorStyle.values,
      labelBuilder: (value) => value.name,
    ),
    direction: context.knobs.object.dropdown(
      label: 'Direction',
      options: Axis.values,
      labelBuilder: (value) => value.name,
    ),
    reviewCount: 1230,
  );
}
