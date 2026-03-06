import 'package:better_design_system/molecules/rating_arc/rating_arc.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppRatingArc)
Widget appRatingArc(BuildContext context) {
  return AppRatingArc(
    rating: context.knobs.double.slider(
      label: 'Rating',
      initialValue: 0,
      max: 100,
    ),
    title: 'Label',
    subtitle: 'Description here',
  );
}
