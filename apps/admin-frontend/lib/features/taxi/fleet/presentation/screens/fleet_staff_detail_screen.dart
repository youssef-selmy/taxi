import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/tag/tag.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:better_design_system/molecules/popup_menu_button/popup_menu_button.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/components/tab_bar/tab_bar.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_staff_detail.cubit.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/fleet_staff_detail_profile.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/fleet_staff_device.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/fleet_staff_password_tab.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/fleet_staff_permisons.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class FleetStaffDetailScreen extends StatefulWidget {
  const FleetStaffDetailScreen({super.key, required this.id});

  final String id;

  @override
  State<FleetStaffDetailScreen> createState() => _FleetStaffDetailScreenState();
}

class _FleetStaffDetailScreenState extends State<FleetStaffDetailScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  late final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FleetStaffDetailBloc()
        ..onStarted(widget.id)
        ..onIdChanged(widget.id),
      child: Container(
        color: context.colors.surface,
        margin: context.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(title: context.tr.accountDetails, showBackButton: true),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<FleetStaffDetailBloc, FleetStaffDetailState>(
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: kThemeAnimationDuration,
                    child: switch (state.fleetStaff) {
                      ApiResponseInitial() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      ApiResponseError() => Center(
                        child: Text(context.tr.error),
                      ),
                      ApiResponseLoading() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      ApiResponseLoaded(:final data) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeader(context, data),
                          const SizedBox(height: 16),
                          _buildTabBar(context, _tabController),
                          const SizedBox(height: 16),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: const [
                                FleetStaffDetailProfile(),
                                FleetStaffPermission(),
                                StaffDetailsDevices(),
                                FleetStaffPasswordTab(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader(BuildContext context, Fragment$fleetStaffs data) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.tr.basicDetails,
            style: context.textTheme.bodyMedium?.variant(context),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatar(
                imageUrl: data.profileImage?.address,
                size: AvatarSize.size56px,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.firstName} ${data.lastName}",
                    style: context.textTheme.bodyMedium,
                  ),
                  Text(
                    "${context.tr.lastActive} ${data.lastActivityAt ?? context.tr.never}",
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                ],
              ),
              const SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr.registeredOn,
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.registeredAt.formatDateTime,
                    style: context.textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.tr.status,
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                  const SizedBox(height: 4),
                  AppTag(
                    prefixIcon: BetterIcons.checkmarkCircle02Filled,
                    color: SemanticColor.success,
                    text: context.tr.enabled,
                  ),
                ],
              ),
              const Spacer(),
              AppPopupMenuButton(
                items: [
                  if (data.isBlocked)
                    AppPopupMenuItem(
                      title: context.tr.unblockUser,
                      icon: BetterIcons.squareUnlock02Outline,
                      color: SemanticColor.success,
                      onPressed: () async {
                        await context
                            .read<FleetStaffDetailBloc>()
                            .unblockStaff();
                        context.showToast(
                          context.tr.unblockUserSuccess,
                          type: SemanticColor.success,
                        );
                      },
                    ),
                  if (!data.isBlocked)
                    AppPopupMenuItem(
                      title: context.tr.blockUser,
                      icon: BetterIcons.securityBlockOutline,
                      color: SemanticColor.error,
                      onPressed: () async {
                        await context.read<FleetStaffDetailBloc>().blockStaff();
                        context.showToast(
                          context.tr.blockUserSuccess,
                          type: SemanticColor.success,
                        );
                      },
                    ),
                  AppPopupMenuItem(
                    title: context.tr.deleteUser,
                    icon: BetterIcons.delete03Outline,
                    color: SemanticColor.error,
                    onPressed: () async {
                      await context.read<FleetStaffDetailBloc>().deleteStaff();
                      context.showToast(
                        context.tr.success,
                        type: SemanticColor.success,
                      );
                      context.router.back();
                    },
                  ),
                ],
                childBuilder: (onPressed) => AppIconButton(
                  icon: BetterIcons.moreVerticalCircle01Filled,
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildTabBar(BuildContext context, TabController tabController) {
  return AppTabBar(
    tabController: tabController,
    isCompact: true,
    tabs: [
      AppTabItem(
        title: context.tr.details,
        iconSelected: BetterIcons.userCircle02Filled,
        iconUnselected: BetterIcons.userCircle02Outline,
      ),
      AppTabItem(
        title: context.tr.permissions,
        iconSelected: BetterIcons.blockedFilled,
        iconUnselected: BetterIcons.blockedOutline,
      ),
      AppTabItem(
        title: context.tr.activeDevices,
        iconSelected: BetterIcons.smartPhone01Filled,
        iconUnselected: BetterIcons.smartPhone01Outline,
      ),
      AppTabItem(
        title: context.tr.password,
        iconSelected: BetterIcons.key01Filled,
        iconUnselected: BetterIcons.key01Outline,
      ),
    ],
  );
}
