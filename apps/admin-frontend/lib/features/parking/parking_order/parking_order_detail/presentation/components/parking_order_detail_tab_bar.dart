import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/tab_bar/tab_bar.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class ParkingOrderDetailTabBar extends StatelessWidget {
  const ParkingOrderDetailTabBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppTabBar(
      tabController: tabController,
      isCompact: true,
      tabs: [
        AppTabItem(
          title: context.tr.notes,
          iconSelected: BetterIcons.userCircle02Filled,
          iconUnselected: BetterIcons.userCircle02Outline,
        ),
        AppTabItem(
          title: context.tr.transactions,
          iconSelected: BetterIcons.creditCardFilled,
          iconUnselected: BetterIcons.creditCardOutline,
        ),
        AppTabItem(
          title: context.tr.feedbacks,
          iconSelected: BetterIcons.message02Filled,
          iconUnselected: BetterIcons.message02Outline,
        ),
        AppTabItem(
          title: context.tr.supportRequests,
          iconSelected: BetterIcons.headphonesFilled,
          iconUnselected: BetterIcons.headphonesOutline,
        ),
      ],
    );
  }
}
