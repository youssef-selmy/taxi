import 'package:better_design_system/atoms/feedback_tag/feedback_tag.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.dart';

extension ReviewTaxiParameterExtension on Fragment$reviewTaxiParameter {
  Widget view(BuildContext context) {
    return AppFeedbackTag(
      type: isGood ? FeedbackTagType.like : FeedbackTagType.disike,
      title: title,
      style: FeedbackTagStyle.soft,
    );
  }
}

extension ReviewParameterListItemX on Fragment$reviewTaxiParameterListItem {
  int get feedbacksCount => feedbacksAggregate.firstOrNull?.count?.id ?? 0;
}

extension ReviewTaxiParameterListItemListX
    on List<Fragment$reviewTaxiParameterListItem> {
  List<Fragment$reviewTaxiParameterListItem> get positivePoints =>
      where((element) => element.isGood).toList();
  List<Fragment$reviewTaxiParameterListItem> get negativePoints =>
      where((element) => !element.isGood).toList();

  int get totalFeedbacks => fold(
    0,
    (previousValue, element) => previousValue + element.feedbacksCount,
  );
}
