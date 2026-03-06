import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/atoms/feedback_tag/feedback_tag_style.dart';
import 'package:better_design_system/atoms/feedback_tag/feedback_tag_type.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
export 'feedback_tag_style.dart';
export 'feedback_tag_type.dart';

typedef BetterFeedbackTag = AppFeedbackTag;

class AppFeedbackTag extends StatelessWidget {
  const AppFeedbackTag({
    super.key,
    required this.title,
    this.style = FeedbackTagStyle.soft,
    this.type = FeedbackTagType.like,
  });

  final String title;
  final FeedbackTagStyle style;
  final FeedbackTagType type;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getIconBackgroundColor(context),
          ),
          child: Icon(
            type == FeedbackTagType.like
                ? BetterIcons.thumbsUpFilled
                : BetterIcons.thumbsDownFilled,

            color: type == FeedbackTagType.like
                ? context.colors.success
                : context.colors.error,

            size: 16,
          ),
        ),
        const SizedBox(width: 8),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: type == FeedbackTagType.like
                ? context.colors.successContainer
                : context.colors.errorContainer,
          ),
          child: Text(
            title,
            style: context.textTheme.labelMedium?.copyWith(
              color: type == FeedbackTagType.like
                  ? context.colors.success
                  : context.colors.error,
            ),
          ),
        ),
      ],
    );
  }

  Color? _getIconBackgroundColor(BuildContext context) {
    switch (style) {
      case FeedbackTagStyle.soft:
        if (type == FeedbackTagType.like) {
          return context.colors.successContainer;
        } else {
          return context.colors.errorContainer;
        }
      case FeedbackTagStyle.ghost:
        return null;
    }
  }
}
