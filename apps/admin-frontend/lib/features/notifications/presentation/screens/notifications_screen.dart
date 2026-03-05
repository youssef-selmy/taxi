import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_assets/assets.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:time/time.dart';

import 'package:admin_frontend/core/blocs/notifications.cubit.dart';
import 'package:admin_frontend/core/components/organisms/notification_item.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/components/tab_bar/tab_bar.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/notifications.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/notifications.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:better_icons/better_icons.dart';

// ignore: depend_on_referenced_packages

@RoutePage()
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with TickerProviderStateMixin {
  final _bloc = locator<NotificationsCubit>();
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _bloc.onStarted();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Padding(
        padding: context.pagePaddingVertical,
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: context.pagePaddingHorizontal,
                  child: PageHeader(
                    title: context.tr.notifications,
                    showBackButton: false,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: context.pagePaddingHorizontal,
                  child: AppTabBar(
                    onTabChanged: (index) {
                      _bloc.onTabChanged(index);
                    },
                    tabs: [
                      AppTabItem(
                        title: context.tr.all,
                        badgeCount: state.allNotificationsCount,
                      ),
                      AppTabItem(
                        title: context.tr.supportRequests,
                        badgeCount: state.supportRequestNotifications.length,
                      ),
                      AppTabItem(
                        title: context.tr.usersPendingVerification,
                        badgeCount:
                            state.pendingVerificationNotifications.length,
                      ),
                      AppTabItem(
                        title: context.tr.reviews,
                        badgeCount:
                            state.reviewPendingApprovalNotifications.length,
                      ),
                    ],
                    tabController: _tabController,
                    isCompact: false,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: switch (state.notifications) {
                    ApiResponseInitial() => SizedBox(),
                    ApiResponseLoading() => Skeletonizer(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return NotificationItem(
                            icon: BetterIcons.notification02Filled,
                            title: '-----',
                            description: '-------------',
                            createdAt: 10.minutes.ago,
                            readAt: null,
                            userInformation: (
                              firstName: '-----',
                              lastName: '-----',
                              email: '-----',
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const Divider(height: 32),
                        itemCount: 10,
                      ),
                    ),
                    ApiResponseLoaded() =>
                      state.selectedTabNotifications.isEmpty
                          ? AppEmptyState(
                              image: Assets.images.emptyStates.noNotification,
                              title: context.tr.noNotifications,
                            )
                          : Expanded(
                              child: SafeArea(
                                top: false,
                                child: ListView.separated(
                                  padding: context.pagePaddingHorizontal
                                      .copyWith(bottom: 16),
                                  itemBuilder: (context, index) {
                                    final notification =
                                        state.selectedTabNotifications[index];
                                    return notification.when(
                                      taxiSupportRequestNotification:
                                          (taxiNotification) => taxiNotification
                                              .toNotificationItem(context),
                                      shopSupportRequestNotification:
                                          (shopNotification) => shopNotification
                                              .toNotificationItem(context),
                                      parkingSupportRequestNotification:
                                          (parkingNotification) =>
                                              parkingNotification
                                                  .toNotificationItem(context),
                                      driverPendingVerificationNotification:
                                          (driverPendingVerification) =>
                                              driverPendingVerification
                                                  .toNotificationItem(context),
                                      shopPendingVerificationNotification:
                                          (shopPendingVerification) =>
                                              shopPendingVerification
                                                  .toNotificationItem(context),
                                      parkSpotPendingVerificationNotification:
                                          (parkSpotPendingVerification) =>
                                              parkSpotPendingVerification
                                                  .toNotificationItem(context),
                                      shopReviewPendingApprovalNotification:
                                          (shopReviewPendingApproval) =>
                                              shopReviewPendingApproval
                                                  .toNotificationItem(context),
                                      parkingReviewPendingApprovalNotification:
                                          (parkingReviewPendingApproval) =>
                                              parkingReviewPendingApproval
                                                  .toNotificationItem(context),
                                      orElse: () {
                                        return Text(context.tr.unknown);
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Divider(height: 32),
                                  itemCount:
                                      state.selectedTabNotifications.length,
                                ),
                              ),
                            ),
                    ApiResponseError(:final errorMessage) => Center(
                      child: Text(
                        errorMessage ?? context.tr.errorLoadingNotifications,
                      ),
                    ),
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
