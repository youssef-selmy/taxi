import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/headers/header_tag.dart';
import 'package:admin_frontend/core/enums/complaint_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/shop_overview/presentation/blocs/shop_overview.bloc.dart';

class ShopOverviewPendingSupportRequests extends StatelessWidget {
  const ShopOverviewPendingSupportRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOverviewBloc, ShopOverviewState>(
      builder: (context, state) {
        final data = state.pendingSupportRequestsState.data;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      context.tr.pendingSupportRequests,
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(width: 8),
                    HeaderTag(
                      text:
                          "${data?.shopSupportRequests.totalCount ?? 0} ${context.tr.unresolved}",
                    ),
                    Spacer(),
                    AppOutlinedButton(
                      onPressed: () {
                        context.router.push(ShopSupportRequestListRoute());
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
                    itemCount: state.pendingSupportRequestsState.isLoading
                        ? 5
                        : data?.shopSupportRequests.nodes.length ?? 0,
                    itemBuilder: (context, index) {
                      final supportRequest = state.pendingShopsState.isLoading
                          ? mockShopSupportRequest1
                          : data?.shopSupportRequests.nodes[index];
                      if (supportRequest == null) {
                        return const SizedBox();
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              supportRequest.createdAt.toTimeAgo,
                              style: context.textTheme.labelMedium,
                            ),
                          ),
                          if (context.isDesktop) ...[
                            const SizedBox(width: 8),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [supportRequest.status.chip(context)],
                              ),
                            ),
                          ],
                          Expanded(
                            child: supportRequest.assignedToStaffs
                                .map((staff) => staff.media)
                                .toList()
                                .avatarsView(
                                  context: context,
                                  totalCount:
                                      supportRequest.assignedToStaffs.length,
                                  size: AvatarGroupSize.medium,
                                ),
                          ),
                          const SizedBox(width: 16),
                          AppTextButton(
                            text: context.tr.viewDetails,
                            onPressed: () {
                              context.router.push(
                                ShopSupportRequestDetailRoute(
                                  id: supportRequest.id,
                                ),
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
