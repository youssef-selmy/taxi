import 'package:better_design_system/atoms/feedback_tag/feedback_tag.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppFeedbackTag)
Widget appFeedbackTag(BuildContext context) {
  return Column(
    spacing: 20,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AppFeedbackTag(
        title: 'Bad Drive',
        style: FeedbackTagStyle.soft,
        type: FeedbackTagType.disike,
      ),
      AppFeedbackTag(
        title: 'Bad Delivery',
        style: FeedbackTagStyle.ghost,
        type: FeedbackTagType.disike,
      ),
      AppFeedbackTag(
        title: 'Good Delivery',
        style: FeedbackTagStyle.soft,
        type: FeedbackTagType.like,
      ),
      AppFeedbackTag(
        title: 'Good Drive',
        style: FeedbackTagStyle.ghost,
        type: FeedbackTagType.like,
      ),
    ],
  );
}
