import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';

import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

class ReviewParking extends StatelessWidget {
  final Fragment$parkingFeedback review;

  const ReviewParking({super.key, required this.review});

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
                            imageUrl: review.order.parkSpot.mainImage?.address,
                            size: AvatarSize.size40px,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            review.order.parkSpot.name ??
                                review.order.parkSpot.address ??
                                "",
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
                          ParkingShellRoute(
                            children: [
                              ParkingOrderShellRoute(
                                children: [
                                  ParkingOrderShellRoute(
                                    children: [
                                      ParkingOrderDetailRoute(
                                        parkingOrderId: review.order.id,
                                      ),
                                    ],
                                  ),
                                ],
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
            const SizedBox(height: 8),
            Text(
              review.comment ?? "-",
              style: context.textTheme.labelMedium?.variant(context),
            ),
            if (review.parameters.isNotEmpty) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  if (review.parameters
                      .where((e) => e.isGood == true)
                      .isNotEmpty) ...[
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
                          children: review.parameters
                              .where((e) => e.isGood == true)
                              .map((e) => e.view(context))
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                  if (review.parameters
                      .where((e) => e.isGood == false)
                      .isNotEmpty) ...[
                    const SizedBox(width: 24),
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
                          children: review.parameters
                              .where((e) => e.isGood == false)
                              .map((e) => e.view(context))
                              .toList(),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
