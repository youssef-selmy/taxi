import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/templates/profile_screen_template/profile_screen_template.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppProfileScreenTemplate)
Widget defaultProfileScreenTemplate(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 200,
        child: AppProfileScreenTemplate(
          selectedTab: 'editProfile1',
          onTabSelected: (_) {},
          onMobileBackPressed: () {},
          fullName: "Max Brown",
          phoneNumber: "+1 (650) 555-1234",
          kpiItems: [
            KpiItem(
              title: "Total Rides",
              value: "112",
              icon: BetterIcons.car01Filled,
            ),
            KpiItem(
              title: "Total Distance",
              value: "1,234 km",
              icon: BetterIcons.mapsFilled,
            ),
          ],
          actions: [
            NavigationTabItem(
              title: 'Edit Profile',
              icon: BetterIcons.userFilled,
              value: 'editProfile1',
              child: Text("Edit Profile"),
            ),
            NavigationTabItem(
              title: 'Payment Methods',
              icon: BetterIcons.creditCardFilled,
              value: 'payment Methods',
              child: Text("Payment Methods"),
            ),
            NavigationTabItem(
              title: 'Favorite Drivers',
              icon: BetterIcons.favouriteFilled,
              value: 'Favorite Drivers',
              child: Text("Favorite Drivers"),
            ),
          ],
        ),
      ),
    ],
  );
}

@UseCase(name: 'Logged Out', type: AppProfileScreenTemplate)
Widget loggedOutProfileScreenTemplate(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        height: 200,
        child: AppProfileScreenTemplate(
          onMobileBackPressed: () {},
          selectedTab: 'editProfile1',
          onTabSelected: (_) {},
        ),
      ),
    ],
  );
}
