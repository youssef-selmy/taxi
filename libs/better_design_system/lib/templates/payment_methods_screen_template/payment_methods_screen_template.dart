import 'package:api_response/api_response.dart';
import 'package:better_assets/assets.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/entities/wallet_activity_item.entity.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/molecules/saved_payment_method_card/saved_payment_method_card.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:better_design_system/organisms/wallet_activity_item/wallet_activity_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef BetterPaymentMethodsScreenTemplate = AppPaymentMethodsScreenTemplate;

class AppPaymentMethodsScreenTemplate extends StatelessWidget {
  final Function()? onMobileBackPressed;
  final ApiResponse<List<PaymentMethodEntity>> paymentMethods;
  final Function(PaymentMethodEntity) onPaymentMethodSelected;
  final Function(PaymentMethodEntity) onMarkAsDefaultPressed;
  final Function(PaymentMethodEntity) onDeletePaymentMethodPressed;
  final Function() onAddPaymentMethodPressed;
  final ApiResponse<List<WalletActivityItemEntity>> walletActivities;

  const AppPaymentMethodsScreenTemplate({
    super.key,
    this.onMobileBackPressed,
    required this.paymentMethods,
    required this.onPaymentMethodSelected,
    required this.onAddPaymentMethodPressed,
    required this.onMarkAsDefaultPressed,
    required this.onDeletePaymentMethodPressed,
    required this.walletActivities,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: context.isDesktop
            ? const BoxConstraints(maxWidth: 600)
            : null,
        color: context.colors.surface,
        child: CustomScrollView(
          slivers: [
            if (context.isMobile && onMobileBackPressed != null)
              SliverAppBar(
                title: Text(
                  context.strings.paymentMethods,
                  style: context.textTheme.titleSmall,
                ),
                backgroundColor: context.colors.surface,
                surfaceTintColor: context.colors.surface,
                leadingWidth: 64,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: AppIconButton(
                    icon: BetterIcons.arrowLeft02Outline,
                    style: IconButtonStyle.ghost,
                    onPressed: onMobileBackPressed,
                  ),
                ),
                pinned: true,
                floating: true,
              ),
            if (paymentMethods.isLoaded && paymentMethods.data!.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CupertinoButton(
                    onPressed: onAddPaymentMethodPressed,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 56,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: context.colors.surfaceVariantLow,
                        border: Border.all(color: context.colors.outline),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.colors.surface,
                              border: Border.all(
                                color: context.colors.outline,
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              BetterIcons.addCircleFilled,
                              color: context.colors.primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            context.strings.addNewPaymentMethod,
                            style: context.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            if (paymentMethods.data?.isNotEmpty ?? true) ...[
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: CarouselView(
                    itemExtent: 450,
                    shrinkExtent: 350,
                    onTap: (index) {
                      onPaymentMethodSelected(paymentMethods.data![index]);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    itemSnapping: true,
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    children: paymentMethods.isLoading
                        ? List.generate(
                            5,
                            (_) => const AppSavedPaymentMethodCard(
                              title: '**** **** **** ****',
                              expirationDate: 'MM/YY',
                              holderName: '---------',
                              isLoading: true,
                              cardType: PaymentMethodCard.visa,
                            ),
                          )
                        : paymentMethods.data?.map((paymentMethod) {
                                return AppSavedPaymentMethodCard(
                                  cardType: paymentMethod.card,
                                  title: paymentMethod.title,
                                  expirationDate:
                                      paymentMethod.expirationDate ?? '--/--',
                                  holderName: paymentMethod.holderName ?? 'N/A',
                                  isLoading: false,
                                  onPressed: () {
                                    onPaymentMethodSelected(paymentMethod);
                                  },
                                  onDeletePressed: () {
                                    onDeletePaymentMethodPressed(paymentMethod);
                                  },
                                  onMarkAsDefaultPressed: () {
                                    onMarkAsDefaultPressed(paymentMethod);
                                  },
                                );
                              }).toList() ??
                              [],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AppListItem(
                        title: context.strings.addNewPaymentMethod,
                        onTap: (_) => onAddPaymentMethodPressed(),
                        isCompact: true,
                        icon: BetterIcons.addCircleFilled,
                        iconColor: SemanticColor.primary,
                      ),
                    ),
                    const AppDivider(height: 64),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        context.strings.activities,
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  bottom: 16 + context.bottomPadding,
                  left: 16,
                  right: 16,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (walletActivities.isLoading) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AppWalletActivityItem(
                            title: 'Loading...',
                            currency: 'USD',
                            amount: 0,
                            date: DateTime.now(),
                            icon: BetterIcons.car01Filled,
                            isLoading: true,
                          ),
                        );
                      }
                      final activity = walletActivities.data?.elementAtOrNull(
                        index,
                      );
                      if (walletActivities.data?.isEmpty ?? true) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            height: 400,
                            child: AppEmptyState(
                              title: context.strings.noActivitiesYet,
                              image: Assets.images.emptyStates.moneySaving,
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: index < walletActivities.data!.length - 1
                            ? const EdgeInsets.only(bottom: 16)
                            : EdgeInsets.zero,
                        child: AppWalletActivityItem(
                          title: activity?.title ?? '',
                          currency: activity?.currency ?? '',
                          amount: activity?.amount ?? 0,
                          date: activity?.date ?? DateTime.now(),
                          icon: activity?.icon ?? BetterIcons.car01Filled,
                          onPressed: null,
                        ),
                      );
                    },
                    childCount: walletActivities.isLoading
                        ? 5
                        : walletActivities.data?.length ?? 1,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
