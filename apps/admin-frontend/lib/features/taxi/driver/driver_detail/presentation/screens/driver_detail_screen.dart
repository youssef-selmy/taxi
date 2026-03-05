import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_timesheet/presentation/screens/driver_detail_timesheet_screen.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/components/tab_bar/tab_bar.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/blocs/driver_detail.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/components/driver_detail_header.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/components/driver_detail_tab.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/presentation/screens/driver_detail_credit_records_screen.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_documents/presentation/screens/driver_detail_documents_screen.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_notes/presentation/screens/driver_detail_notes_screen.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_orders/presentation/screens/driver_detail_orders_screen.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_password/presentation/screens/driver_detail_password_screen.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_reviews/presentation/screens/driver_detail_reviews_screen.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class DriverDetailScreen extends StatefulWidget {
  const DriverDetailScreen({
    super.key,
    @PathParam('driverId') required this.driverId,
  });
  final String driverId;

  @override
  State<DriverDetailScreen> createState() => _DriverDetailScreenState();
}

class _DriverDetailScreenState extends State<DriverDetailScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _tabController = TabController(length: 8, vsync: this);
    super.initState();
  }

  late final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverDetailBloc()..onStarted(widget.driverId),
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
                  context.router.replace(DriverListRoute()),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<DriverDetailBloc, DriverDetailState>(
                buildWhen: (previous, current) =>
                    previous.driverDetailResponse !=
                    current.driverDetailResponse,
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: kThemeAnimationDuration,
                    child: switch (state.driverDetailResponse) {
                      ApiResponseInitial() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      ApiResponseError(:final message) => Center(
                        child: Text(message),
                      ),
                      ApiResponseLoading() || ApiResponseLoaded() => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const DriverDetailHeader(),
                          const SizedBox(height: 16),
                          _buildTabBar(context, _tabController),
                          const SizedBox(height: 16),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                DriverDetailTab(),
                                DriverDetailNotesScreen(
                                  driverId: widget.driverId,
                                ),
                                DriverDetailTimesheetScreen(
                                  driverId: widget.driverId,
                                ),
                                DriverDetailOrdersScreen(
                                  driverId: widget.driverId,
                                ),
                                DriverDetailCreditRecordsScreen(
                                  driverId: widget.driverId,
                                ),
                                DriverDetailReviewsScreen(
                                  driverId: widget.driverId,
                                ),
                                DriverDetailDocumentsScreen(
                                  driverId: widget.driverId,
                                ),
                                // DriverDetailActiveDevicesScreen(
                                //   driverId: widget.driverId,
                                // ),
                                DriverDetailPasswordScreen(
                                  driverId: widget.driverId,
                                ),
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
        title: context.tr.notes,
        iconUnselected: BetterIcons.noteOutline,
        iconSelected: BetterIcons.noteFilled,
      ),
      AppTabItem(
        title: context.tr.timesheet,
        iconUnselected: BetterIcons.clock01Outline,
        iconSelected: BetterIcons.clock01Filled,
      ),
      AppTabItem(
        title: context.tr.orders,
        iconUnselected: BetterIcons.bookOpen01Outline,
        iconSelected: BetterIcons.bookOpen01Filled,
      ),
      AppTabItem(
        title: context.tr.creditRecords,
        iconUnselected: BetterIcons.creditCardOutline,
        iconSelected: BetterIcons.creditCardFilled,
      ),
      AppTabItem(
        title: context.tr.reviews,
        iconUnselected: BetterIcons.message02Outline,
        iconSelected: BetterIcons.message02Filled,
      ),
      AppTabItem(
        title: context.tr.documents,
        iconUnselected: BetterIcons.folder01Outline,
        iconSelected: BetterIcons.folder01Filled,
      ),
      // AppTabItem(
      //   title: context.tr.activeDevices,
      //   iconUnselected: BetterIcons.smartPhone01Outline,
      //   iconSelected: BetterIcons.smartPhone01Filled,
      // ),
      AppTabItem(
        title: context.tr.password,
        iconUnselected: BetterIcons.key01Outline,
        iconSelected: BetterIcons.key01Filled,
      ),
    ],
  );
}
