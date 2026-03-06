import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:better_design_system/organisms/notification/notification.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class AppNotificationCard extends StatelessWidget {
  const AppNotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          context.isMobile
              ? const EdgeInsets.symmetric(horizontal: 16)
              : EdgeInsets.zero,
      child: AppClickableCard(
        padding: EdgeInsets.zero,
        type: ClickableCardType.elevated,
        elevation: BetterShadow.shadow4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Notification', style: context.textTheme.labelLarge),
            ),
            AppDivider(),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 12,
                left: 12,
                right: 16,
              ),
              child: AppTabMenuHorizontal<String>(
                tabs: [
                  TabMenuHorizontalOption(title: 'View all', value: 'View all'),
                  TabMenuHorizontalOption(title: 'Mentions', value: 'Mentions'),
                ],
                selectedValue: 'View all',
                onChanged: (context) {},
                style: TabMenuHorizontalStyle.soft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppNotification(
                    date: DateTime.now().subtract(const Duration(hours: 1)),
                    actorAvatarUrl: ImageFaker().person.one,
                    actorName: 'John',
                    message: 'Great job on that task',
                    statusBadgeType: StatusBadgeType.online,
                  ),
                  const SizedBox(height: 24),
                  AppNotification(
                    date: DateTime.now().subtract(const Duration(hours: 2)),
                    actorAvatarUrl: ImageFaker().person.two,
                    actorName: 'Victor',
                    message: 'Hello!',
                    statusBadgeType: StatusBadgeType.online,
                  ),
                  const SizedBox(height: 24),
                  AppNotification(
                    date: DateTime.now().subtract(const Duration(hours: 3)),
                    actorAvatarUrl: ImageFaker().person.three,
                    actorName: 'Charles',
                    message: 'Thanks a lot for your help',
                    statusBadgeType: StatusBadgeType.online,
                  ),
                ],
              ),
            ),
            const AppDivider(),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.1,
                right: 15.1,
                bottom: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextButton(
                    color: SemanticColor.primary,
                    size: ButtonSize.large,
                    prefixIcon: BetterIcons.tickDouble02Outline,
                    onPressed: () {},
                    text: 'Mark all as read',
                  ),
                  const Spacer(),
                  AppFilledButton(
                    color: SemanticColor.primary,
                    size: ButtonSize.large,
                    onPressed: () {},
                    text: 'Show all notifications',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
