import 'package:api_response/api_response.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/top_bar_icon_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/select_payment_method_button/select_payment_method_button.dart';
import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:better_design_system/organisms/mobile_top_bar/mobile_top_bar.dart';
import 'package:better_design_system/organisms/wallet_activity_item/wallet_activity_item.dart';
import 'package:better_design_system/templates/wallet_screen_template/components/wallet_screen_activities_dialog.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

import 'components/wallet_card.dart';
import '../../entities/wallet_activity_item.entity.dart';
import '../../entities/wallet_item.entity.dart';

typedef BetterWalletScreenTemplate = AppWalletScreenTemplate;

class AppWalletScreenTemplate extends StatelessWidget {
  final ApiResponse<List<WalletItemEntity>> walletItems;
  final ApiResponse<List<WalletActivityItemEntity>> walletActivityItems;
  final ApiResponse<PaymentMethodEntity?> defaultPaymentMethod;
  final Function()? onRedeemGiftCardPressed;
  final Function() onAddCreditPressed;
  final Function()? onSelectPaymentMethodPressed;
  final Function()? onMobileBackPressed;

  const AppWalletScreenTemplate({
    super.key,
    required this.walletItems,
    required this.walletActivityItems,
    required this.defaultPaymentMethod,
    required this.onRedeemGiftCardPressed,
    required this.onAddCreditPressed,
    this.onSelectPaymentMethodPressed,
    this.onMobileBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final paymentMethod = defaultPaymentMethod.data;
    if (walletItems.isError) {
      return Center(
        child: AppEmptyState(
          image: Assets.images.emptyStates.error,
          title: walletItems.errorMessage ?? context.strings.somethingWentWrong,
        ),
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(color: context.colors.surface),
      child: Align(
        alignment: context.isMobile ? Alignment.center : Alignment.topCenter,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.isMobile ? double.infinity : 460,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: context.isDesktop
              ? SingleChildScrollView(
                  child: _buildContent(context, paymentMethod),
                )
              : _buildContent(context, paymentMethod),
        ),
      ),
    );
  }

  SafeArea _buildContent(
    BuildContext context,
    PaymentMethodEntity? paymentMethod,
  ) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppMobileTopBar(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
            childAlignment: context.isMobile
                ? MobileTopBarChildAlignment.center
                : MobileTopBarChildAlignment.start,
            title: context.strings.wallet,
            suffixActions: [
              AppTopBarIconButton(
                icon: BetterIcons.clock01Outline,
                onPressed: () {
                  showDialog(
                    context: context,
                    useSafeArea: false,
                    builder: (context) {
                      return AppWalletScreenActivitiesDialog(
                        activities: walletActivityItems.data ?? [],
                      );
                    },
                  );
                },
              ),
            ],
            onBackPressed: context.isMobile && onMobileBackPressed != null
                ? () {
                    onMobileBackPressed?.call();
                  }
                : null,
          ),
          AppWalletCard(walletItems: walletItems),
          const SizedBox(height: 16),
          if (onRedeemGiftCardPressed != null) ...[
            AppListItem(
              title: context.strings.redeemGiftCard,
              iconColor: SemanticColor.primary,
              isCompact: true,
              onTap: (_) => onRedeemGiftCardPressed?.call(),
              icon: BetterIcons.giftFilled,
            ),
            const AppDivider(height: 32),
          ],
          if (onSelectPaymentMethodPressed != null) ...[
            Text(
              context.strings.paymentMethod,
              style: context.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            if (paymentMethod != null)
              AppSelectPaymentMethodButton(
                paymentMethod: paymentMethod,
                onPressed: onSelectPaymentMethodPressed!,
                backgroundColor: context.colors.surfaceVariant,
              ),
            if (paymentMethod == null)
              AppListItem(
                title: context.strings.addPaymentMethod,
                icon: BetterIcons.creditCardFilled,
                iconColor: SemanticColor.primary,
                isCompact: true,
                onTap: (_) => onSelectPaymentMethodPressed!.call(),
              ),
          ],
          if (context.isMobile) const Spacer(),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: AppFilledButton(
              prefixIcon: BetterIcons.addCircleFilled,
              text: context.strings.addCredit,
              onPressed: () {
                onAddCreditPressed();
              },
            ),
          ),
          const SizedBox(height: 16),
          if (context.isDesktop)
            Column(
              spacing: 8,
              children: [
                for (
                  int index = 0;
                  index < (walletActivityItems.data ?? []).length;
                  index++
                ) ...[
                  Builder(
                    builder: (context) {
                      final activity = (walletActivityItems.data ?? [])[index];
                      return AppWalletActivityItem(
                        title: activity.title,
                        currency: activity.currency,
                        amount: activity.amount,
                        date: activity.date,
                        icon: activity.icon,
                      );
                    },
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}
