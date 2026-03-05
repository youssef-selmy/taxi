import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';

import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';

class ReviewShop extends StatelessWidget {
  final Fragment$shopFeedback review;

  const ReviewShop({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.tr.reviewFor,
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          AppAvatar(
                            imageUrl: review.orderCart.shop.image?.address,
                            size: AvatarSize.size40px,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            review.orderCart.shop.name,
                            style: context.textTheme.labelMedium,
                          ),
                          const SizedBox(width: 8),
                          RatingIndicator(rating: review.score),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      review.createdAt.formatDateTime,
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    const SizedBox(height: 8),
                    AppLinkButton(
                      text: context.tr.viewOrder,
                      onPressed: () {
                        context.navigateTo(
                          ShopShellRoute(
                            children: [
                              ShopOrderDetailRoute(
                                shopOrderId: review.orderCart.order.id,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            if (review.comment != null) ...[
              const SizedBox(height: 8),
              Text(
                review.comment ?? "",
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
