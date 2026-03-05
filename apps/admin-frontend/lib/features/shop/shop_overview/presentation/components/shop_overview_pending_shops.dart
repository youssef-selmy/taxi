import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/header_tag.dart';
import 'package:admin_frontend/core/enums/shop_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/shop_overview/presentation/blocs/shop_overview.bloc.dart';

class ShopOverviewPendingShops extends StatelessWidget {
  const ShopOverviewPendingShops({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOverviewBloc, ShopOverviewState>(
      builder: (context, state) {
        final data = state.pendingShopsState.data;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      context.tr.pendingShops,
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(width: 8),
                    HeaderTag(
                      text:
                          "${data?.shops.totalCount ?? 0} ${context.tr.unverified}",
                    ),
                    Spacer(),
                    AppOutlinedButton(
                      onPressed: () {
                        context.router.push(
                          VendorListPendingVerificationRoute(),
                        );
                      },
                      color: SemanticColor.neutral,
                      text: context.tr.viewAll,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 320,
                  child: ListView.separated(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: state.pendingShopsState.isLoading
                        ? 5
                        : data?.shops.nodes.length ?? 0,
                    itemBuilder: (context, index) {
                      final shop = state.pendingShopsState.isLoading
                          ? mockShopListItem1
                          : data?.shops.nodes[index];
                      if (shop == null) {
                        return const SizedBox();
                      }
                      return Row(
                        children: [
                          if (shop.image != null) ...[
                            shop.image!.roundedWidget(size: 40),
                            const SizedBox(width: 8),
                          ],
                          Expanded(
                            child: Text(
                              shop.name,
                              style: context.textTheme.labelMedium,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              shop.createdAt.toTimeAgo,
                              style: context.textTheme.labelMedium,
                            ),
                          ),
                          if (context.isDesktop) ...[
                            const SizedBox(width: 8),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [shop.status.chip(context)],
                              ),
                            ),
                          ],
                          const SizedBox(width: 16),
                          AppTextButton(
                            text: context.tr.viewProfile,
                            onPressed: () {
                              context.router.push(
                                ShopDetailRoute(shopId: shop.id),
                              );
                            },
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(height: 24),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
