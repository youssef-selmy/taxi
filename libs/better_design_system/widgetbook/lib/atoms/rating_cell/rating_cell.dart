import 'package:better_design_system/atoms/rating_cell/rating_cell.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppRatingCell)
Widget appRatingCell(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 20,
    children: [
      AppRatingCell(
        isActive: context.knobs.boolean(label: 'Active', initialValue: false),
        onPressed: () {},
        isRounded: true,
        type: RatingCellType.star,
        style: context.knobs.object.dropdown(
          label: 'Style',
          options: RatingCellStyle.values,
          labelBuilder: (value) => value.name,
        ),
        size: context.knobs.object.dropdown(
          label: 'Size',
          options: RatingCellSize.values,
          labelBuilder: (value) => value.name,
        ),
      ),
      AppRatingCell(
        isActive: context.knobs.boolean(label: 'Active', initialValue: false),
        onPressed: () {},
        isRounded: true,
        type: RatingCellType.favorite,
        style: context.knobs.object.dropdown(
          label: 'Style',
          options: RatingCellStyle.values,
          labelBuilder: (value) => value.name,
        ),
        size: context.knobs.object.dropdown(
          label: 'Size',
          options: RatingCellSize.values,
          labelBuilder: (value) => value.name,
        ),
      ),
      AppRatingCell(
        isActive: context.knobs.boolean(label: 'Active', initialValue: false),
        onPressed: () {},
        isRounded: true,
        style: context.knobs.object.dropdown(
          label: 'Style',
          options: RatingCellStyle.values,
          labelBuilder: (value) => value.name,
        ),
        type: RatingCellType.number,
        number: 1,
        size: context.knobs.object.dropdown(
          label: 'Size',
          options: RatingCellSize.values,
          labelBuilder: (value) => value.name,
        ),
      ),
      AppRatingCell(
        isActive: context.knobs.boolean(label: 'Active', initialValue: false),
        onPressed: () {},
        style: context.knobs.object.dropdown(
          label: 'Style',
          options: RatingCellStyle.values,
          labelBuilder: (value) => value.name,
        ),
        type: RatingCellType.star,
        size: context.knobs.object.dropdown(
          label: 'Size',
          options: RatingCellSize.values,
          labelBuilder: (value) => value.name,
        ),
      ),
      AppRatingCell(
        isActive: context.knobs.boolean(label: 'Active', initialValue: false),
        onPressed: () {},
        style: context.knobs.object.dropdown(
          label: 'Style',
          options: RatingCellStyle.values,
          labelBuilder: (value) => value.name,
        ),
        type: RatingCellType.favorite,
        size: context.knobs.object.dropdown(
          label: 'Size',
          options: RatingCellSize.values,
          labelBuilder: (value) => value.name,
        ),
      ),
      AppRatingCell(
        isActive: context.knobs.boolean(label: 'Active', initialValue: false),
        onPressed: () {},
        style: context.knobs.object.dropdown(
          label: 'Style',
          options: RatingCellStyle.values,
          labelBuilder: (value) => value.name,
        ),
        size: context.knobs.object.dropdown(
          label: 'Size',
          options: RatingCellSize.values,
          labelBuilder: (value) => value.name,
        ),
        type: RatingCellType.number,
        number: 1,
      ),
    ],
  );
}
