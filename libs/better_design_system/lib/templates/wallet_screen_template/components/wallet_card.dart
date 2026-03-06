import 'package:api_response/api_response.dart';
import 'package:better_assets/assets.dart';
import 'package:better_design_system/entities/wallet_item.entity.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

typedef BetterWalletCard = AppWalletCard;

class AppWalletCard extends StatelessWidget {
  const AppWalletCard({super.key, required this.walletItems});

  final ApiResponse<List<WalletItemEntity>> walletItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: Assets.images.cardBackgrounds.simpleCard.provider(),
          fit: BoxFit.cover,
        ),
      ),
      height: 172,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: context.colors.onPrimary,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  BetterIcons.wallet01Filled,
                  color: context.colors.onPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                context.strings.wallet,
                style: context.textTheme.labelLarge?.copyWith(
                  color: context.colors.onPrimary,
                ),
              ),
              const Spacer(),
            ],
          ),
          const Spacer(),
          Text(
            context.strings.totalBalance,
            style: context.textTheme.labelMedium?.apply(
              color: context.colors.onPrimary,
            ),
          ),
          Skeletonizer(
            enabled: walletItems.isLoading,
            child: Text(
              walletItems.data?.firstOrNull?.balance.formatCurrency(
                    walletItems.data?.firstOrNull?.currency ?? 'USD',
                  ) ??
                  '0.00',
              style: context.textTheme.headlineMedium?.apply(
                color: context.colors.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
