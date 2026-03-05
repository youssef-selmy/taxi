import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/tag/tag.dart';

import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:better_icons/better_icons.dart';

class FeedbackWithOrderRedirection extends StatelessWidget {
  final String submittedBy;
  final Fragment$Media? submittedByAvatar;
  final DateTime submittedAt;
  final String? review;
  final int rating;
  final Function()? onOrderTap;
  final List<String> goodPoints;
  final List<String> badPoints;

  const FeedbackWithOrderRedirection({
    super.key,
    required this.submittedBy,
    required this.submittedByAvatar,
    required this.submittedAt,
    required this.review,
    required this.rating,
    this.onOrderTap,
    required this.goodPoints,
    required this.badPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Review by',
                  style: context.textTheme.labelMedium?.variant(context),
                ),
                Text(
                  submittedAt.formatDateTime,
                  style: context.textTheme.labelMedium?.variant(context),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    AppAvatar(
                      imageUrl: submittedByAvatar?.address,
                      size: AvatarSize.size40px,
                    ),
                    const SizedBox(width: 8),
                    Text(submittedBy, style: context.textTheme.bodyMedium),
                    const SizedBox(width: 16),
                    RatingIndicator(rating: rating),
                  ],
                ),
                AppTextButton(
                  text: context.tr.viewOrder,
                  suffixIcon: BetterIcons.arrowRight02Outline,
                  onPressed: onOrderTap,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                review ?? '',
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (goodPoints.isNotEmpty) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr.goodPoints,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.colors.success,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: goodPoints
                            .map(
                              (e) =>
                                  AppTag(color: SemanticColor.success, text: e),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ],
                if (badPoints.isNotEmpty) const SizedBox(width: 24),
                if (badPoints.isNotEmpty) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr.badPoints,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.colors.error,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: badPoints
                            .map(
                              (e) => AppTag(
                                style: TagStyle.outline,
                                color: SemanticColor.error,
                                text: e,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
