import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_feedbacks.cubit.dart';

class ShopDetailFeedbacksTab extends StatelessWidget {
  final String shopId;

  const ShopDetailFeedbacksTab({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopDetailFeedbacksBloc()..onStarted(shopId: shopId),
      child: BlocBuilder<ShopDetailFeedbacksBloc, ShopDetailFeedbacksState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${context.tr.reviews} (${state.shopFeedbacksState.data?.shopFeedbacks.nodes.length ?? ""})",
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Skeletonizer(
                  enabled: state.shopFeedbacksState.isLoading,
                  enableSwitchAnimation: true,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final feedback =
                          state
                              .shopFeedbacksState
                              .data
                              ?.shopFeedbacks
                              .nodes[index] ??
                          mockShopFeedback1;
                      return feedback.toViewWithOrderRedirection(context);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount:
                        state
                            .shopFeedbacksState
                            .data
                            ?.shopFeedbacks
                            .nodes
                            .length ??
                        5,
                  ),
                ),
              ),
              const SizedBox(height: 120),
            ],
          );
        },
      ),
    );
  }
}
