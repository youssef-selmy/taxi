import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_reviews/presentation/bloc/taxi_order_detail_reviews.cubit.dart';

class TaxiOrderDetailReviwsScreen extends StatelessWidget {
  const TaxiOrderDetailReviwsScreen({super.key, required this.taxiOrderId});

  final String taxiOrderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaxiOrderDetailReviewsBloc()..onStarted(taxiOrderId),
      child:
          BlocBuilder<TaxiOrderDetailReviewsBloc, TaxiOorderDetailReviewsState>(
            builder: (context, state) {
              final taxiOrderReviews = state.taxiOrderReviewsState.data;
              return Container(
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  border: Border.all(color: context.colors.outline),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: LargeHeader(title: context.tr.reviews),
                    ),
                    Skeletonizer(
                      enabled: state.taxiOrderReviewsState.isLoading,
                      enableSwitchAnimation: true,
                      child: SizedBox(
                        height: 460,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(height: 32),
                            itemCount: state.taxiOrderReviewsState.isLoading
                                ? 3
                                : taxiOrderReviews
                                          ?.taxiOrderReviews
                                          .nodes
                                          .length ??
                                      0,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final review =
                                  state.taxiOrderReviewsState.isLoading
                                  ? mockReviewTaxi1
                                  : taxiOrderReviews
                                        ?.taxiOrderReviews
                                        .nodes[index];
                              return Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      AppAvatar(
                                        imageUrl: review?.driver.media?.address,
                                        size: AvatarSize.size40px,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        review?.driver.fullName ?? '',
                                        style: context.textTheme.bodyMedium,
                                      ),
                                      const SizedBox(width: 16),
                                      RatingIndicator(rating: review?.score),
                                      const Spacer(),
                                      Text(
                                        review
                                                ?.reviewTimestamp
                                                .formatDateTime ??
                                            '',
                                        style: context.textTheme.labelMedium
                                            ?.variant(context),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      review?.description ?? '',
                                      style: context.textTheme.labelMedium
                                          ?.variant(context),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      if (review!.parameters
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
                                                    color:
                                                        context.colors.success,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Wrap(
                                              spacing: 4,
                                              runSpacing: 4,
                                              children: review.parameters
                                                  .where(
                                                    (e) => e.isGood == true,
                                                  )
                                                  .map((e) => e.view(context))
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
                                                    color: context.colors.error,
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Wrap(
                                              spacing: 4,
                                              runSpacing: 4,
                                              children: review.parameters
                                                  .where(
                                                    (e) => e.isGood == false,
                                                  )
                                                  .map((e) => e.view(context))
                                                  .toList(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}
