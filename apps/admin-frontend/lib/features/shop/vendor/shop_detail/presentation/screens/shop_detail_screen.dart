import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/router/app_router.dart';
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
import 'package:admin_frontend/core/enums/shop_order_queue_level.dart';
import 'package:admin_frontend/core/enums/shop_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/weekday_schedule.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail.cubit.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_credit_records_tab.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_delivery_tab.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_details_tab.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_documents_tab.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_feedbacks_tab.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_items_and_categories_tab/shop_detail_items_and_categories_tab.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_notes_tab.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_open_hours_tab.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_orders_tab.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_sessions_tab.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_update_password_tab.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class ShopDetailScreen extends StatefulWidget {
  final String shopId;

  const ShopDetailScreen({
    super.key,
    @PathParam("shopId") required this.shopId,
  });

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 11, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopDetailBloc()..onStarted(shopId: widget.shopId),
      child: Container(
        color: context.colors.surface,
        margin: context.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              title: context.tr.shopDetails,
              showBackButton: true,
              onBackButtonPressed: () {
                context.router.navigate(VendorListRoute());
              },
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
                  BlocBuilder<ShopDetailBloc, ShopDetailState>(
                    builder: (context, state) {
                      final shop = state.shopDetailState.data;
                      return Skeletonizer(
                        enabled: state.shopDetailState.isLoading,
                        enableSwitchAnimation: true,
                        child: Wrap(
                          spacing: 40,
                          runSpacing: 40,
                          children: [
                            UploadFieldSmall(
                              initialValue: shop?.image,
                              onChanged: context
                                  .read<ShopDetailBloc>()
                                  .onMainImageChanged,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  shop?.name ?? "",
                                  style: context.textTheme.bodyMedium,
                                ),
                                Text(
                                  shop?.lastActivityAt != null
                                      ? context.tr
                                            .lastActivityAtWithPlaceholder(
                                              shop!.lastActivityAt!.toTimeAgo,
                                            )
                                      : "-",
                                  style: context.textTheme.labelMedium?.variant(
                                    context,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr.registeredOn,
                                  style: context.textTheme.labelMedium?.variant(
                                    context,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  shop?.createdAt.formatDateTime ?? "---",
                                  style: context.textTheme.labelMedium,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr.rating,
                                  style: context.textTheme.labelMedium?.variant(
                                    context,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                RatingIndicator(
                                  rating: shop?.ratingAggregate?.rating,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr.status,
                                  style: context.textTheme.labelMedium?.variant(
                                    context,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                if (shop?.status != null)
                                  AppDropdownStatus<Enum$ShopStatus>(
                                    initialValue: shop?.status,
                                    onChanged: context
                                        .read<ShopDetailBloc>()
                                        .onStatusChanged,
                                    items: Enum$ShopStatus.values
                                        .toDropdownStatusItems(context),
                                  ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr.orderQueue,
                                  style: context.textTheme.labelMedium?.variant(
                                    context,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                if (shop != null)
                                  shop.orderQueueLevel.toChip(context),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.tr.categories,
                                  style: context.textTheme.labelMedium?.variant(
                                    context,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                BlocBuilder<ShopDetailBloc, ShopDetailState>(
                                  builder: (context, state) {
                                    final categories =
                                        state
                                            .shopDetailState
                                            .data
                                            ?.categories ??
                                        [];
                                    return categories.toChips();
                                  },
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
                  BlocBuilder<ShopDetailBloc, ShopDetailState>(
                    builder: (context, state) {
                      final weekleySchedule =
                          state.shopDetailState.data?.weeklySchedule ?? [];
                      return weekleySchedule.toChips(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: AppTabBar(
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
                    title: context.tr.itemsAndCategories,
                    iconSelected: BetterIcons.layers01Filled,
                    iconUnselected: BetterIcons.layers01Outline,
                  ),
                  AppTabItem(
                    title: context.tr.orders,
                    iconSelected: BetterIcons.bookOpen01Filled,
                    iconUnselected: BetterIcons.bookOpen01Outline,
                  ),
                  AppTabItem(
                    title: context.tr.delivery,
                    iconSelected: BetterIcons.creditCardFilled,
                    iconUnselected: BetterIcons.creditCardOutline,
                  ),
                  AppTabItem(
                    title: context.tr.openHours,
                    iconSelected: BetterIcons.clock01Filled,
                    iconUnselected: BetterIcons.clock01Outline,
                  ),
                  AppTabItem(
                    title: context.tr.financialRecords,
                    iconSelected: BetterIcons.creditCardFilled,
                    iconUnselected: BetterIcons.creditCardOutline,
                  ),
                  AppTabItem(
                    title: context.tr.feedbacks,
                    iconSelected: BetterIcons.message02Filled,
                    iconUnselected: BetterIcons.message02Outline,
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
            ),
            const SizedBox(height: 16),
            Expanded(
              // height: 550,
              child: TabBarView(
                controller: _tabController,
                children: [
                  ShopDetailDetailsTab(),
                  ShopDetailNotesTab(shopId: widget.shopId),
                  ShopDetailItemsAndCategoriesTab(shopId: widget.shopId),
                  ShopDetailOrdersTab(shopId: widget.shopId),
                  BlocBuilder<ShopDetailBloc, ShopDetailState>(
                    builder: (context, state) {
                      return ShopDetailDeliveryTab(
                        shopId: widget.shopId,
                        shopCurrency:
                            state.shopDetailState.data?.currency ??
                            Env.defaultCurrency,
                      );
                    },
                  ),
                  ShopDetailOpenHoursTab(),
                  ShopDetailCreditRecordsTab(shopId: widget.shopId),
                  ShopDetailFeedbacksTab(shopId: widget.shopId),
                  ShopDetailDocumentsTab(shopId: widget.shopId),
                  ShopDetailSessionsTab(shopId: widget.shopId),
                  ShopDetailUpdatePasswordTab(shopId: widget.shopId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
