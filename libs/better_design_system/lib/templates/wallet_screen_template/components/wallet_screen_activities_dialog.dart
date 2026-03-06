import 'package:better_design_system/entities/wallet_activity_item.entity.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system/organisms/mobile_top_bar/mobile_top_bar.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_design_system/organisms/wallet_activity_item/wallet_activity_item.dart';
import 'package:flutter/material.dart';

typedef BetterWalletScreenActivitiesDialog = AppWalletScreenActivitiesDialog;

class AppWalletScreenActivitiesDialog extends StatelessWidget {
  final List<WalletActivityItemEntity> activities;

  const AppWalletScreenActivitiesDialog({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      defaultDialogType: DialogType.fullScreen,
      desktopDialogType: DialogType.fullScreen,
      child: SafeArea(
        bottom: false,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.isDesktop ? 480 : double.infinity,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppMobileTopBar(
                onBackPressed: () {
                  Navigator.of(context).maybePop();
                },
                title: context.strings.activities,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.paddingOf(context).bottom + 16,
                  ),
                  itemBuilder: (context, index) {
                    final activity = activities[index];
                    return AppWalletActivityItem(
                      title: activity.title,
                      currency: activity.currency,
                      amount: activity.amount,
                      date: activity.date,
                      icon: activity.icon,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: activities.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
