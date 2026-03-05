import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/feedback_tag/feedback_tag.dart';

import 'package:admin_frontend/core/components/feedback/feedback_with_order_redirection.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';

extension ShopFeedbackGqlX on Fragment$shopFeedback {
  Widget toViewWithOrderRedirection(BuildContext context) =>
      FeedbackWithOrderRedirection(
        submittedBy: orderCart.order.customer.fullName,
        submittedAt: createdAt,
        submittedByAvatar: orderCart.order.customer.media,
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
          ShopOrderDetailRoute(shopOrderId: orderCart.order.id),
        ),
      );
}

extension ReviewTaxiParameterExtension on Fragment$shopFeedbackParameter {
  Widget view(BuildContext context) {
    return AppFeedbackTag(
      type: isGood ? FeedbackTagType.like : FeedbackTagType.disike,
      title: name,
      style: FeedbackTagStyle.soft,
    );
  }
}
