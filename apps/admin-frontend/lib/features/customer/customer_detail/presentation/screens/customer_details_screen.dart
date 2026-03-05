import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/rating_indicator/rating_indicator.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:better_design_system/molecules/popup_menu_button/popup_menu_button.dart';
import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/components/tab_bar/tab_bar.dart';
import 'package:admin_frontend/core/enums/customer_status_enum.dart';
import 'package:admin_frontend/core/enums/gender.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/customer_details.cubit.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/addresses.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/complaints.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/credit_records.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/notes.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/orders.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/profile.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/reviews.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class CustomerDetailsScreen extends StatefulWidget {
  const CustomerDetailsScreen({
    super.key,
    @PathParam('customerId') required this.customerId,
  });

  final String customerId;

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerDetailsBloc()..onStarted(widget.customerId),
      child: PageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              title: context.tr.customerProfile,
              showBackButton: true,
              onBackButtonPressed: () =>
                  context.router.replace(CustomersRoute()),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocConsumer<CustomerDetailsBloc, CustomerDetailsState>(
                listener: (context, state) {
                  if (state.deleteUserState.isLoaded) {
                    context.router.replace(CustomersRoute());
                    context.showToast(
                      context.tr.accountDeleted,
                      type: SemanticColor.success,
                    );
                  }
                },
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: kThemeAnimationDuration,
                    child: switch (state.customerDetailsState) {
                      ApiResponseInitial() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      ApiResponseError(:final errorMessage) => Center(
                        child: Text(
                          errorMessage ?? context.tr.somethingWentWrong,
                        ),
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
                                const CustomerDetailsProfile(),
                                CustomerDetailsOrders(
                                  customerId: widget.customerId,
                                ),
                                CustomerDetailsCreditRecords(
                                  customerId: widget.customerId,
                                ),
                                CustomerDetailsAddresses(
                                  customerId: widget.customerId,
                                ),
                                CustomerDetailsReviews(
                                  customerId: widget.customerId,
                                ),
                                CustomerDetailsComplaints(
                                  customerId: widget.customerId,
                                ),
                                // CustomerDetailsDevices(
                                //   customerId: widget.customerId,
                                // ),
                                CustomerDetailsNotes(
                                  customerId: widget.customerId,
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

  Widget _buildHeader(BuildContext context, Fragment$customerDetails data) {
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
                Expanded(
                  child: Wrap(
                    spacing: 40,
                    runSpacing: 16,
                    children: [
                      Row(
                        children: [
                          AppAvatar(
                            imageUrl: data.avatarUrl,
                            size: AvatarSize.size56px,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.fullName,
                                style: context.textTheme.bodyMedium,
                              ),
                              Text(
                                "${context.tr.lastActive} ${data.lastActivityAt?.toTimeAgo ?? context.tr.never}",
                                style: context.textTheme.labelMedium?.variant(
                                  context,
                                ),
                              ),
                            ],
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
                          const SizedBox(height: 4),
                          Text(
                            data.registrationTimestamp.formatDateTime,
                            style: context.textTheme.labelMedium,
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
                          const SizedBox(height: 4),
                          data.status.chip(context),
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
                          const SizedBox(height: 4),
                          if (data.ratingAggregate?.rating != null)
                            AppRatingIndicator(
                              rating:
                                  data.ratingAggregate?.rating?.toDouble() ?? 0,
                            ),
                          if (data.ratingAggregate?.rating == null)
                            Text("-", style: context.textTheme.labelMedium),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.tr.gender,
                            style: context.textTheme.labelMedium?.variant(
                              context,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data.gender?.name(context) ?? "-",
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AppPopupMenuButton(
                  showArrow: false,
                  items: [
                    if (data.status == Enum$RiderStatus.Disabled)
                      AppPopupMenuItem(
                        title: context.tr.unblockUser,
                        icon: BetterIcons.squareUnlock02Outline,
                        color: SemanticColor.success,
                        onPressed: () async {
                          await context
                              .read<CustomerDetailsBloc>()
                              .updateCustomerDetails(
                                Input$RiderInput(
                                  status: Enum$RiderStatus.Enabled,
                                ),
                              );
                          context.showToast(
                            context.tr.unblockUserSuccess,
                            type: SemanticColor.success,
                          );
                        },
                      ),
                    if (data.status == Enum$RiderStatus.Enabled)
                      AppPopupMenuItem(
                        title: context.tr.blockUser,
                        icon: BetterIcons.securityBlockOutline,
                        color: SemanticColor.error,
                        onPressed: () async {
                          await context
                              .read<CustomerDetailsBloc>()
                              .updateCustomerDetails(
                                Input$RiderInput(
                                  status: Enum$RiderStatus.Disabled,
                                ),
                              );
                          context.showToast(
                            context.tr.blockUserSuccess,
                            type: SemanticColor.error,
                          );
                        },
                      ),
                    AppPopupMenuItem(
                      title: context.tr.deleteUser,
                      icon: BetterIcons.delete03Outline,
                      color: SemanticColor.error,
                      onPressed: () async {
                        await context.read<CustomerDetailsBloc>().deleteUser();
                        context.showToast(
                          context.tr.accountDeleted,
                          type: SemanticColor.error,
                        );
                        context.router.replace(CustomersRoute());
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
          title: context.tr.addresses,
          iconUnselected: BetterIcons.gps01Outline,
          iconSelected: BetterIcons.gps01Filled,
        ),
        AppTabItem(
          title: context.tr.reviews,
          iconUnselected: BetterIcons.message02Outline,
          iconSelected: BetterIcons.message02Filled,
        ),
        AppTabItem(
          title: context.tr.complaints,
          iconUnselected: BetterIcons.headphonesOutline,
          iconSelected: BetterIcons.headphonesFilled,
        ),
        // AppTabItem(
        //   title: context.tr.activeDevices,
        //   iconUnselected: BetterIcons.smartPhone01Outline,
        //   iconSelected: BetterIcons.smartPhone01Filled,
        // ),
        AppTabItem(
          title: context.tr.notes,
          iconUnselected: BetterIcons.noteOutline,
          iconSelected: BetterIcons.noteFilled,
        ),
      ],
    );
  }
}
