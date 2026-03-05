import 'package:flutter/cupertino.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/presentation/blocs/customer_accounting_detail.bloc.dart';
import 'package:better_icons/better_icons.dart';

class CustomerAccoutingDetailHeader extends StatelessWidget {
  const CustomerAccoutingDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.pagePadding,
      decoration: BoxDecoration(color: context.colors.primaryBold),
      child:
          BlocBuilder<
            CustomerAccountingDetailBloc,
            CustomerAccountingDetailState
          >(
            builder: (context, state) {
              final summary = state.walletSummaryState.data;
              return Column(
                children: [
                  Row(
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => context.router.back(),
                        minimumSize: Size(0, 0),
                        child: Row(
                          children: [
                            Icon(
                              BetterIcons.arrowLeft01Outline,
                              color: context.colors.surface,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        context.tr.walletDetails,
                        style: context.textTheme.headlineSmall?.apply(
                          color: context.colors.surface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  Skeletonizer(
                    enabled: state.walletSummaryState.isLoading,
                    enableSwitchAnimation: true,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppAvatar(
                          imageUrl: summary?.rider.media?.address,
                          size: AvatarSize.size80px,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              summary?.rider.fullName ?? "-",
                              style: context.textTheme.headlineSmall?.apply(
                                color: context.colors.surface,
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: summary == null
                                  ? null
                                  : () {
                                      context.router.navigate(
                                        CustomerShellRoute(
                                          children: [
                                            CustomerDetailsRoute(
                                              customerId: summary.rider.id,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                              minimumSize: Size(0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    context.tr.viewProfile,
                                    style: context.textTheme.labelMedium?.apply(
                                      color: context.colors.surface,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    BetterIcons.arrowRight02Outline,
                                    color: context.colors.surface,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.responsive(32, lg: 16)),
                ],
              );
            },
          ),
    );
  }
}
