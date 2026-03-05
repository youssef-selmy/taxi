import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_status/dropdown_status.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/components/tab_bar/tab_bar.dart';
import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/enums/park_spot_status.dart';
import 'package:admin_frontend/core/enums/park_spot_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/weekday_schedule.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/blocs/park_spot_detail.cubit.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/tabs/park_spot_detail_credit_records_tab.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/tabs/park_spot_detail_details_tab.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/tabs/park_spot_detail_documents_tab.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/tabs/park_spot_detail_facilities_tab.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/tabs/park_spot_detail_feedbacks_tab.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/tabs/park_spot_detail_notes_tab.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/tabs/park_spot_detail_open_hours_tab.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/tabs/park_spot_detail_orders_tab.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/tabs/park_spot_detail_sessions_tab.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/tabs/park_spot_detail_update_password_tab.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class ParkSpotDetailScreen extends StatefulWidget {
  final String parkSpotId;

  const ParkSpotDetailScreen({
    super.key,
    @PathParam("parkSpotId") required this.parkSpotId,
  });

  @override
  State<ParkSpotDetailScreen> createState() => _ParkSpotDetailScreenState();
}

class _ParkSpotDetailScreenState extends State<ParkSpotDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 10, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ParkSpotDetailBloc()..onStarted(parkSpotId: widget.parkSpotId),
      child: SingleChildScrollView(
        child: Container(
          color: context.colors.surface,
          margin: context.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PageHeader(
                title: context.tr.parkingDetails,
                showBackButton: true,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: kShadow(context),
                  border: kBorder(context),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.basicDetails,
                      style: context.textTheme.bodyMedium?.variant(context),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<ParkSpotDetailBloc, ParkSpotDetailState>(
                      builder: (context, state) {
                        final parkSpot = state.parkSpotDetailState.data;
                        return Skeletonizer(
                          enabled: state.parkSpotDetailState.isLoading,
                          enableSwitchAnimation: true,
                          child: Wrap(
                            spacing: 40,
                            runSpacing: 40,
                            children: [
                              UploadFieldSmall(
                                initialValue: parkSpot?.mainImage,
                                onChanged: context
                                    .read<ParkSpotDetailBloc>()
                                    .onMainImageChanged,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    parkSpot?.name ?? "",
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  Text(
                                    parkSpot?.lastActivityAt != null
                                        ? context.tr
                                              .lastActivityAtWithPlaceholder(
                                                parkSpot!
                                                    .lastActivityAt!
                                                    .toTimeAgo,
                                              )
                                        : "-",
                                    style: context.textTheme.labelMedium
                                        ?.variant(context),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.tr.type,
                                    style: context.textTheme.labelMedium
                                        ?.variant(context),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    parkSpot?.type.name(context) ?? "---",
                                    style: context.textTheme.labelMedium,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.tr.registeredOn,
                                    style: context.textTheme.labelMedium
                                        ?.variant(context),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    parkSpot?.createdAt.toTimeAgo ?? "---",
                                    style: context.textTheme.labelMedium,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.tr.rating,
                                    style: context.textTheme.labelMedium
                                        ?.variant(context),
                                  ),
                                  const SizedBox(height: 2),
                                  RatingIndicator(
                                    rating: parkSpot?.ratingAggregate.rating,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.tr.status,
                                    style: context.textTheme.labelMedium
                                        ?.variant(context),
                                  ),
                                  const SizedBox(height: 2),
                                  if (parkSpot?.status != null)
                                    AppDropdownStatus(
                                      initialValue: parkSpot?.status,
                                      onChanged: context
                                          .read<ParkSpotDetailBloc>()
                                          .onStatusChanged,
                                      items: Enum$ParkSpotStatus.values
                                          .toDropdownStatusItems(context),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      context.tr.openHours,
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<ParkSpotDetailBloc, ParkSpotDetailState>(
                      builder: (context, state) {
                        final weekleySchedule =
                            state.parkSpotDetailState.data?.weeklySchedule ??
                            [];
                        return weekleySchedule.toChips(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppTabBar(
                tabController: _tabController,
                isCompact: true,
                tabs: [
                  AppTabItem(
                    title: context.tr.details,
                    iconSelected: BetterIcons.userCircle02Filled,
                    iconUnselected: BetterIcons.userCircle02Outline,
                  ),
                  AppTabItem(
                    title: context.tr.notes,
                    iconSelected: BetterIcons.noteFilled,
                    iconUnselected: BetterIcons.noteOutline,
                  ),
                  AppTabItem(
                    title: context.tr.facilities,
                    iconSelected: BetterIcons.city02Filled,
                    iconUnselected: BetterIcons.city02Outline,
                  ),
                  AppTabItem(
                    title: context.tr.openHours,
                    iconSelected: BetterIcons.clock01Filled,
                    iconUnselected: BetterIcons.clock01Outline,
                  ),
                  AppTabItem(
                    title: context.tr.feedbacks,
                    iconSelected: BetterIcons.message02Filled,
                    iconUnselected: BetterIcons.message02Outline,
                  ),
                  AppTabItem(
                    title: context.tr.orders,
                    iconSelected: BetterIcons.bookOpen01Filled,
                    iconUnselected: BetterIcons.bookOpen01Outline,
                  ),
                  AppTabItem(
                    title: context.tr.financialRecords,
                    iconSelected: BetterIcons.creditCardFilled,
                    iconUnselected: BetterIcons.creditCardOutline,
                  ),
                  AppTabItem(
                    title: context.tr.documents,
                    iconSelected: BetterIcons.folder01Filled,
                    iconUnselected: BetterIcons.folder01Outline,
                  ),
                  AppTabItem(
                    title: context.tr.sessions,
                    iconSelected: BetterIcons.smartPhone01Filled,
                    iconUnselected: BetterIcons.smartPhone01Outline,
                  ),
                  AppTabItem(
                    title: context.tr.updatePassword,
                    iconSelected: BetterIcons.key01Filled,
                    iconUnselected: BetterIcons.key01Outline,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 550,
                child: BlocBuilder<ParkSpotDetailBloc, ParkSpotDetailState>(
                  buildWhen: (previous, current) =>
                      previous.parkSpotDetailState.data?.owner?.id !=
                      current.parkSpotDetailState.data?.owner?.id,
                  builder: (context, state) {
                    final ownerId =
                        state.parkSpotDetailState.data?.owner?.id ?? "";
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        ParkSpotDetailDetailsTab(),
                        ParkSpotDetailNotesTab(parkSpotId: widget.parkSpotId),
                        ParkSpotDetailFacilitiesTab(),
                        ParkSpotDetailOpenHoursTab(),
                        ParkSpotDetailFeedbacksTab(
                          parkSpotId: widget.parkSpotId,
                        ),
                        ParkSpotDetailOrdersTab(parkSpotId: widget.parkSpotId),
                        ParkSpotDetailCreditRecordsTab(
                          parkSpotId: widget.parkSpotId,
                          ownerId: ownerId,
                        ),
                        ParkSpotDetailDocumentsTab(
                          parkSpotId: widget.parkSpotId,
                        ),
                        ParkSpotDetailSessionsTab(ownerId: ownerId),
                        ParkSpotDetailUpdatePasswordTab(ownerId: ownerId),
                      ],
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
}
