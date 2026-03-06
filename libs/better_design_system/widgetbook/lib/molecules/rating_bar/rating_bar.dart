import 'package:better_design_system/molecules/rating_bar/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppRatingBar)
Widget appRatingBar(BuildContext context) {
  final rate = context.knobs.double.slider(
    label: 'Rate',
    initialValue: 0,
    max: 5,
  );
  return Column(
    spacing: 20,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AppRatingBar(
        rate: rate,
        onPressed: (value) {},
        isRounded: true,
        style: RatingCellStyle.outline,
      ),
      AppRatingBar(
        rate: rate,
        onPressed: (value) {},
        style: RatingCellStyle.outline,
      ),
      AppRatingBar(
        rate: rate,
        onPressed: (value) {},
        style: RatingCellStyle.outline,
        type: RatingCellType.favorite,
      ),
      AppRatingBar(
        rate: rate,
        onPressed: (value) {},
        style: RatingCellStyle.outline,
        type: RatingCellType.number,
      ),
      AppRatingBar(
        rate: rate,
        onPressed: (value) {},
        style: RatingCellStyle.ghost,
        type: RatingCellType.number,
      ),
      AppRatingBar(
        rate: rate,
        onPressed: (value) {},
        style: RatingCellStyle.ghost,
        type: RatingCellType.star,
      ),
      AppRatingBar(
        rate: rate,
        onPressed: (value) {},
        style: RatingCellStyle.ghost,
        type: RatingCellType.favorite,
      ),
    ],
  );
}
