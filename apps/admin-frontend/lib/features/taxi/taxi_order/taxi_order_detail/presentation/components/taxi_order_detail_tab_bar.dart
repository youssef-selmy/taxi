import 'package:admin_frontend/core/components/tab_bar/tab_bar.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class TaxiOrderDetailTabBar extends StatelessWidget {
  final TabController tabController;
  final bool hasDetailsTab;
  const TaxiOrderDetailTabBar({
    super.key,
    required this.tabController,
    this.hasDetailsTab = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppTabBar(
      color: SemanticColor.neutral,
      tabController: tabController,
      isCompact: true,
      tabs: [
        if (hasDetailsTab) ...[
          AppTabItem(
            title: context.tr.details,
            iconSelected: BetterIcons.informationCircleFilled,
            iconUnselected: BetterIcons.informationCircleOutline,
          ),
        ],
        AppTabItem(
          title: context.tr.notes,
          iconSelected: BetterIcons.noteFilled,
          iconUnselected: BetterIcons.noteOutline,
        ),
        AppTabItem(
          title: context.tr.transactions,
          iconSelected: BetterIcons.creditCardFilled,
          iconUnselected: BetterIcons.creditCardOutline,
        ),
        AppTabItem(
          title: context.tr.reviews,
          iconSelected: BetterIcons.message02Filled,
          iconUnselected: BetterIcons.message02Outline,
        ),
        AppTabItem(
          title: context.tr.complaints,
          iconSelected: BetterIcons.headphonesFilled,
          iconUnselected: BetterIcons.headphonesOutline,
        ),
        AppTabItem(
          title: context.tr.chatHistory,
          iconSelected: BetterIcons.chatting01Filled,
          iconUnselected: BetterIcons.chatting01Outline,
        ),
      ],
    );
  }
}
