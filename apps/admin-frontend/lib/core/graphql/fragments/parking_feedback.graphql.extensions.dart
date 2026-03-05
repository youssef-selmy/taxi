import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:admin_frontend/core/components/feedback/feedback_with_order_redirection.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:better_design_system/atoms/feedback_tag/feedback_tag.dart';

extension ParkingFeedbackGqlX on Fragment$parkingFeedback {
  Widget toViewWithOrderRedirection(BuildContext context) =>
      FeedbackWithOrderRedirection(
        submittedBy: order.carOwner?.fullName ?? context.tr.unknown,
        submittedAt: createdAt,
        submittedByAvatar: order.carOwner?.media,
        review: comment,
        rating: score,
        goodPoints: parameters
            .where((element) => element.isGood)
            .map((parameter) => parameter.name)
            .toList(),
        badPoints: parameters
            .where((element) => !element.isGood)
            .map((parameter) => parameter.name)
            .toList(),
        onOrderTap: () => context.router.push(
          ParkingOrderDetailRoute(parkingOrderId: order.id),
        ),
      );
}

extension ReviewTaxiParameterExtension on Fragment$parkingFeedbackParameter {
  Widget view(BuildContext context) {
    return AppFeedbackTag(
      type: isGood ? FeedbackTagType.like : FeedbackTagType.disike,
      title: name,
      style: FeedbackTagStyle.soft,
    );
  }
}

extension ParkReviewParameterListItemX
    on Fragment$parkingFeedbackParameterListItem {
  int get feedbacksCount => feedbacksAggregate.firstOrNull?.count?.id ?? 0;
}

extension ReviewTaxiParameterListItemListX
    on List<Fragment$parkingFeedbackParameterListItem> {
  List<Fragment$parkingFeedbackParameterListItem> get positivePoints =>
      where((element) => element.isGood).toList();
  List<Fragment$parkingFeedbackParameterListItem> get negativePoints =>
      where((element) => !element.isGood).toList();

  int get totalFeedbacks => fold(
    0,
    (previousValue, element) => previousValue + element.feedbacksCount,
  );
}
