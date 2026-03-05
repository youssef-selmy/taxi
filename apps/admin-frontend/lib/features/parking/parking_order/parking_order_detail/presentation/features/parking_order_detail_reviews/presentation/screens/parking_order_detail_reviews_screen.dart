import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_reviews/presentation/blocs/parking_order_detail_reviews.cubit.dart';

class ParkingOrderDetailReviewScreen extends StatelessWidget {
  const ParkingOrderDetailReviewScreen({
    super.key,
    required this.parkingOrderId,
  });

  final String parkingOrderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ParkingOrderDetailReviewsBloc()..onStarted(parkingOrderId),
      child:
          BlocBuilder<
            ParkingOrderDetailReviewsBloc,
            ParkingOrderDetailReviewsState
          >(
            builder: (context, state) {
              final reviews =
                  state.parkingOrderReviewState.data?.parkOrder.feedbacks;
              return SafeArea(
                top: false,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    border: kBorder(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        child: LargeHeader(
                          title: context.tr.customersRateReview,
                        ),
                      ),
                      const Divider(height: 1),
                      Expanded(
                        child: Skeletonizer(
                          enabled: state.parkingOrderReviewState.isLoading,
                          enableSwitchAnimation: true,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Divider(height: 32),
                            ),
                            itemCount: state.parkingOrderReviewState.isLoading
                                ? 3
                                : reviews?.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final review =
                                  state.parkingOrderReviewState.isLoading
                                  ? mockParkingFeedback1
                                  : reviews![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            AppAvatar(
                                              imageUrl: review
                                                  .order
                                                  .parkSpot
                                                  .mainImage
                                                  ?.address,
                                              size: AvatarSize.size40px,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              review.order.parkSpot.name ?? '-',
                                              style:
                                                  context.textTheme.bodyMedium,
                                            ),
                                            const SizedBox(width: 16),
                                            RatingIndicator(
                                              rating: review.score,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          review.createdAt.formatDateTime,
                                          style: context.textTheme.labelMedium
                                              ?.variant(context),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            review.comment ?? "-",
                                            style: context.textTheme.labelMedium
                                                ?.variant(context),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            if (review.parameters
                                                .where((e) => e.isGood == true)
                                                .isNotEmpty) ...[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    context.tr.goodPoints,
                                                    style: context
                                                        .textTheme
                                                        .labelMedium
                                                        ?.copyWith(
                                                          color: context
                                                              .colors
                                                              .success,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Wrap(
                                                    spacing: 4,
                                                    runSpacing: 4,
                                                    children: review.parameters
                                                        .where(
                                                          (e) =>
                                                              e.isGood == true,
                                                        )
                                                        .map(
                                                          (e) =>
                                                              e.view(context),
                                                        )
                                                        .toList(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                            if (review.parameters
                                                .where((e) => e.isGood == true)
                                                .isNotEmpty)
                                              const SizedBox(width: 24),
                                            if (review.parameters
                                                .where((e) => e.isGood == false)
                                                .isNotEmpty) ...[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    context.tr.badPoints,
                                                    style: context
                                                        .textTheme
                                                        .labelMedium
                                                        ?.copyWith(
                                                          color: context
                                                              .colors
                                                              .error,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Wrap(
                                                    spacing: 4,
                                                    runSpacing: 4,
                                                    children: review.parameters
                                                        .where(
                                                          (e) =>
                                                              e.isGood == false,
                                                        )
                                                        .map(
                                                          (e) =>
                                                              e.view(context),
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
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
