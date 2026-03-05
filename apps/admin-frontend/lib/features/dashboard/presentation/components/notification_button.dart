import 'package:admin_frontend/core/blocs/notifications.cubit.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/navbar/navbar_icon.dart';

import 'package:admin_frontend/features/dashboard/presentation/components/notification_panel/notifications_panel.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationButton extends StatefulWidget {
  const NotificationButton({super.key});

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  final controller = OverlayPortalController();
  final _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: controller,
      overlayChildBuilder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            controller.hide();
          },
          child: CompositedTransformFollower(
            link: _link,
            targetAnchor: Alignment.bottomRight,
            followerAnchor: Alignment.topRight,
            child: Align(
              alignment: Alignment.topRight,
              child: NotificationsPanel(controller: controller),
            ),
          ),
        );
      },
      child: CompositedTransformTarget(
        link: _link,
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            return AppNavbarIcon(
              badgeNumber: state.allNotificationsCount,
              icon: BetterIcons.notification02Filled,
              onPressed: () {
                controller.toggle();
              },
            );
          },
        ),
      ),
    );
  }
}
