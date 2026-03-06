import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/switch/switch.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class SwitchProfileCard extends StatefulWidget {
  const SwitchProfileCard({super.key});

  @override
  State<SwitchProfileCard> createState() => _SwitchProfileCardState();
}

class _SwitchProfileCardState extends State<SwitchProfileCard> {
  List<String> selecteditems = ['Notification'];

  void _onItemSelected(String value) {
    if (selecteditems.contains(value)) {
      setState(() {
        selecteditems.removeWhere((element) => element == value);
      });
    } else {
      setState(() {
        selecteditems.add(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              spacing: 12,
              children: [
                AppAvatar(
                  imageUrl: ImageFaker().person.two,
                  size: AvatarSize.size48px,
                  statusBadgeType: StatusBadgeType.online,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text('Dennis Gordon', style: context.textTheme.titleSmall),
                    Text(
                      'Dennis.Gordon@Gmail.com',
                      style: context.textTheme.bodySmall?.variant(context),
                    ),
                  ],
                ),
              ],
            ),
            AppDivider(height: 36),

            Column(
              spacing: 20,
              children: [
                _buildProfileItem(
                  context,
                  icon: BetterIcons.userOutline,
                  title: 'Profile',
                ),
                _buildProfileItem(
                  context,
                  icon: BetterIcons.moon02Outline,
                  title: 'Dark Mode',
                  isSelected: selecteditems.contains('Dark Mode'),
                  onChanged: (_) {
                    _onItemSelected('Dark Mode');
                  },
                ),
                _buildProfileItem(
                  context,
                  icon: BetterIcons.notification02Outline,
                  title: 'Notification',
                  isSelected: selecteditems.contains('Notification'),
                  onChanged: (_) {
                    _onItemSelected('Notification');
                  },
                ),
              ],
            ),
            AppDivider(height: 36),
            Row(
              spacing: 8,
              children: [
                Icon(
                  BetterIcons.arrowLeft03Outline,
                  size: 20,
                  color: context.colors.error,
                ),
                Text(
                  'Log out',
                  style: context.textTheme.labelLarge?.copyWith(
                    color: context.colors.error,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    bool? isSelected,
    void Function(bool)? onChanged,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        spacing: 8,
        children: [
          Icon(icon, size: 20, color: context.colors.onSurface),
          Text(title, style: context.textTheme.labelLarge),
        ],
      ),
      if (isSelected != null)
        AppSwitch(isSelected: isSelected, onChanged: onChanged),
    ],
  );
}
