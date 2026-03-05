import 'package:flutter/cupertino.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_detail/presentation/blocs/shop_accounting_detail.cubit.dart';
import 'package:better_icons/better_icons.dart';

class ShopAccoutingDetailHeader extends StatelessWidget {
  const ShopAccoutingDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.pagePadding,
      decoration: BoxDecoration(color: context.colors.primaryBold),
      child: BlocBuilder<ShopAccountingDetailBloc, ShopAccountingDetailState>(
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
                      imageUrl: summary?.shop.image?.address,
                      size: AvatarSize.size80px,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          summary?.shop.name ?? "-",
                          style: context.textTheme.headlineSmall?.apply(
                            color: context.colors.surface,
                          ),
                        ),
                        AppTextButton(
                          onPressed: () {
                            context.router.push(
                              ShopDetailRoute(shopId: summary!.shop.id),
                            );
                          },
                          text: context.tr.viewProfile,
                          suffixIcon: BetterIcons.arrowRight02Outline,
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
