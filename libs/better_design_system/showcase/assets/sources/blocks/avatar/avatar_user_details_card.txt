import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:image_faker/image_faker.dart';

class AvatarUserDetailsCard extends StatelessWidget {
  const AvatarUserDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 302,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            Row(
              children: [
                Text('User Details', style: context.textTheme.labelMedium),
              ],
            ),
            SizedBox(height: 16),
            AppAvatar(
              imageUrl: ImageFaker().person.three,
              size: AvatarSize.size80px,
            ),
            SizedBox(height: 12),
            Text('Carter Botosh', style: context.textTheme.labelLarge),
            SizedBox(height: 4),
            Text(
              'carter@better.com',
              style: context.textTheme.labelSmall?.variant(context),
            ),
            SizedBox(height: 16),
            Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildContactItem(
                  context,
                  icon: BetterIcons.messageMultiple01Filled,
                ),
                _buildContactItem(context, icon: BetterIcons.mail02Filled),
                _buildContactItem(context, icon: BetterIcons.call02Filled),
                _buildContactItem(context, icon: BetterIcons.share08Filled),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildContactItem(BuildContext context, {required IconData icon}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.outline),
      ),
      child: Icon(icon, size: 20, color: context.colors.onSurfaceVariant),
    );
  }
}
