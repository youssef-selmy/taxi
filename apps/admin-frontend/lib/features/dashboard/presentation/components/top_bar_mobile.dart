import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/icon_button.dart';

import 'package:admin_frontend/features/dashboard/presentation/components/drawer.mobile.dart';
import 'package:admin_frontend/features/dashboard/presentation/components/profile_dropdown.dart';
import 'package:better_icons/better_icons.dart';

class TopBarMobile extends StatefulWidget {
  const TopBarMobile({super.key});

  @override
  State<TopBarMobile> createState() => _TopBarMobileState();
}

class _TopBarMobileState extends State<TopBarMobile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
        child: Row(
          children: [
            AppIconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  useSafeArea: false,
                  builder: (context) => DrawerMobile(),
                );
              },
              icon: BetterIcons.menu01Outline,
            ),
            const Spacer(),
            // const SizedBox(width: 16),
            // const DarkLightSwitch(),
            // const SizedBox(width: 16),
            // const LanguageButton(),
            // const SizedBox(width: 16),
            const ProfileDropdown(),
            // TODO: Add Notifications
            // const SizedBox(width: 16),
            // const NotificationButton(),
          ],
        ),
      ),
    );
  }
}
