import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/blocs/notifications.cubit.dart';
import 'package:admin_frontend/core/components/tab_bar/tab_bar.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/dashboard/presentation/components/notification_panel/notification_list.dart';

class NotificationsPanel extends StatefulWidget {
  final OverlayPortalController controller;

  const NotificationsPanel({super.key, required this.controller});

  @override
  State<NotificationsPanel> createState() => _NotificationsPanelState();
}

class _NotificationsPanelState extends State<NotificationsPanel>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _bloc = locator<NotificationsCubit>();

  @override
  void initState() {
    _bloc.onStarted();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Container(
        width: context.width > 600 ? 600 : (context.width - 30),
        decoration: BoxDecoration(
          boxShadow: context.isDark ? null : kShadow(context),
          border: Border.all(color: context.colors.outline, width: 1),
          borderRadius: BorderRadius.circular(8),
          color: context.colors.surface,
        ),
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    context.tr.notifications,
                    style: context.textTheme.titleMedium,
                  ),
                ),
                const Divider(),
                AppTabBar(
                  isCompact: true,
                  tabController: _tabController,
                  tabs: [
                    AppTabItem(
                      badgeCount: state.supportRequestNotifications.length,
                      title: context.tr.supportRequests,
                    ),
                    AppTabItem(
                      badgeCount: state.pendingVerificationNotifications.length,
                      title: context.tr.pendingVerificationUsers,
                    ),
                    AppTabItem(
                      badgeCount:
                          state.reviewPendingApprovalNotifications.length,
                      title: context.tr.reviews,
                    ),
                  ],
                ),
                SizedBox(
                  height: 400,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      NotificationList(
                        notifications: state.supportRequestNotifications,
                      ),
                      NotificationList(
                        notifications: state.pendingVerificationNotifications,
                      ),
                      NotificationList(
                        notifications: state.reviewPendingApprovalNotifications,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: context.colors.outline, width: 1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: context.colors.shadow,
                        offset: const Offset(0, -4),
                        blurRadius: 16,
                      ),
                    ],
                    color: context.colors.surface,
                  ),
                  child: Row(
                    children: [
                      // const ReadAllButton(),
                      const Spacer(),
                      AppFilledButton(
                        text: context.tr.viewAll,
                        onPressed: () {
                          widget.controller.hide();
                          context.router.navigate(NotificationsRoute());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
