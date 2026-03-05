import 'package:admin_frontend/core/router/app_router.dart';
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
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_detail.cubit.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/financial_records.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/fleet_detail.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/fleet_drivers_tab.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/orders_tab.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/staffs_tab.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class FleetAccountDetailScreen extends StatefulWidget {
  const FleetAccountDetailScreen({super.key, required this.fleetId});
  final String fleetId;
  @override
  State<FleetAccountDetailScreen> createState() =>
      _FleetAccountDetailScreenState();
}

class _FleetAccountDetailScreenState extends State<FleetAccountDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FleetDetailBloc()
        ..onStarted(widget.fleetId)
        ..onIdChanged(widget.fleetId),
      child: BlocListener<FleetDetailBloc, FleetDetailState>(
        listener: (context, state) {},
        child: Container(
          color: context.colors.surface,
          margin: context.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PageHeader(
                title: context.tr.accountDetails,
                showBackButton: true,
                onBackButtonPressed: () =>
                    context.router.replace(FleetListRoute()),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: BlocBuilder<FleetDetailBloc, FleetDetailState>(
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: kThemeAnimationDuration,
                      child: switch (state.fleet) {
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
                            _buildTabBar(context),
                            const SizedBox(height: 16),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  FleetDetailTab(data: data),
                                  FinancialRecordsTab(fleetId: widget.fleetId),
                                  FleetOrdersTab(fleetId: widget.fleetId),
                                  FleetStaffsTab(fleetId: widget.fleetId),
                                  FleetDriversTab(fleetId: widget.fleetId),
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
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Query$fleetDetails data) {
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
                  imageUrl: data.fleet.profilePicture?.address,
                  size: AvatarSize.size56px,
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
                      data.fleet.createdAt?.formatDateTime ?? "-",
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
                    if (data.fleet.isBlocked)
                      AppPopupMenuItem(
                        title: context.tr.unblockUser,
                        icon: BetterIcons.squareUnlock02Outline,
                        color: SemanticColor.success,
                        onPressed: () async {
                          await context.read<FleetDetailBloc>().unblockFleet();
                          context.showToast(
                            context.tr.unblockUserSuccess,
                            type: SemanticColor.success,
                          );
                        },
                      ),
                    if (!data.fleet.isBlocked)
                      AppPopupMenuItem(
                        title: context.tr.blockUser,
                        icon: BetterIcons.securityBlockOutline,
                        color: SemanticColor.error,
                        onPressed: () async {
                          await context.read<FleetDetailBloc>().blockFleet();
                          context.showToast(
                            context.tr.blockUserSuccess,
                            type: SemanticColor.success,
                          );
                        },
                      ),
                    AppPopupMenuItem(
                      title: context.tr.delete,
                      icon: BetterIcons.delete03Outline,
                      color: SemanticColor.error,
                      onPressed: () async {
                        context.read<FleetDetailBloc>().deleteFleet();
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

  Widget _buildTabBar(BuildContext context) {
    return AppTabBar(
      tabController: _tabController,
      isCompact: true,
      tabs: [
        AppTabItem(
          title: context.tr.details,
          iconSelected: BetterIcons.userCircle02Filled,
          iconUnselected: BetterIcons.userCircle02Outline,
        ),
        AppTabItem(
          title: context.tr.financialRecords,
          iconSelected: BetterIcons.creditCardFilled,
          iconUnselected: BetterIcons.creditCardOutline,
        ),
        AppTabItem(
          title: context.tr.orders,
          iconSelected: BetterIcons.bookOpen01Filled,
          iconUnselected: BetterIcons.bookOpen01Outline,
        ),
        AppTabItem(
          title: context.tr.staff,
          iconSelected: BetterIcons.userMultipleFilled,
          iconUnselected: BetterIcons.userMultipleOutline,
        ),
        AppTabItem(
          title: context.tr.drivers,
          iconSelected: BetterIcons.car05Filled,
          iconUnselected: BetterIcons.car05Outline,
        ),
      ],
    );
  }
}
