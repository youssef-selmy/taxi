import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_reviews/presentation/blocs/shop_order_detail_reviews.cubit.dart';

class ShopOrderDetailReviewsScreen extends StatelessWidget {
  const ShopOrderDetailReviewsScreen({super.key, required this.shopOrderId});
  final String shopOrderId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopOrderDetailReviewsBloc()..onStarted(shopOrderId),
      child: BlocBuilder<ShopOrderDetailReviewsBloc, ShopOrderDetailReviewsState>(
        builder: (context, state) {
          final reviews =
              state.shopOrderDetailReviewsState.data?.shopOrder.carts;
          return Container(
            decoration: BoxDecoration(
              color: context.colors.surface,
              border: Border.all(color: context.colors.outline),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: LargeHeader(title: context.tr.reviews),
                ),
                const Divider(height: 0),
                const SizedBox(height: 16),
                Skeletonizer(
                  enabled: state.shopOrderDetailReviewsState.isLoading,
                  enableSwitchAnimation: true,
                  child: SizedBox(
                    height: 423,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(height: 32),
                      ),
                      itemCount: state.shopOrderDetailReviewsState.isLoading
                          ? 2
                          : reviews?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final review =
                            state.shopOrderDetailReviewsState.isLoading
                            ? mockFragmentShopBasic1
                            : reviews![index].shop;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      AppAvatar(
                                        imageUrl: review.image?.address,
                                        size: AvatarSize.size40px,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        review.name,
                                        style: context.textTheme.bodyMedium,
                                      ),
                                      const SizedBox(width: 16),
                                      RatingIndicator(
                                        rating: review.ratingAggregate?.rating,
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
                                children:
                                    (state.shopOrderDetailReviewsState.isLoading
                                            ? [
                                                mockShopFeedback1,
                                                mockReviewShop4,
                                              ]
                                            : reviews![index].feedbacks!)
                                        .map((parametr) {
                                          return Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  parametr.comment ?? '',
                                                  style: context
                                                      .textTheme
                                                      .labelMedium
                                                      ?.variant(context),
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              Row(
                                                children: [
                                                  if (parametr.parameters
                                                      .where(
                                                        (e) => e.isGood == true,
                                                      )
                                                      .isNotEmpty) ...[
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Wrap(
                                                          spacing: 4,
                                                          runSpacing: 4,
                                                          children: parametr
                                                              .parameters
                                                              .where(
                                                                (e) =>
                                                                    e.isGood ==
                                                                    true,
                                                              )
                                                              .map(
                                                                (e) => e.view(
                                                                  context,
                                                                ),
                                                              )
                                                              .toList(),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                  if (parametr.parameters
                                                      .where(
                                                        (e) => e.isGood == true,
                                                      )
                                                      .isNotEmpty)
                                                    const SizedBox(width: 24),
                                                  if (parametr.parameters
                                                      .where(
                                                        (e) =>
                                                            e.isGood == false,
                                                      )
                                                      .isNotEmpty) ...[
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Wrap(
                                                          spacing: 4,
                                                          runSpacing: 4,
                                                          children: parametr
                                                              .parameters
                                                              .where(
                                                                (e) =>
                                                                    e.isGood ==
                                                                    false,
                                                              )
                                                              .map(
                                                                (e) => e.view(
                                                                  context,
                                                                ),
                                                              )
                                                              .toList(),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ],
                                              ),
                                              const SizedBox(height: 16),
                                            ],
                                          );
                                        })
                                        .toList(),
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
          );
        },
      ),
    );
  }
}
