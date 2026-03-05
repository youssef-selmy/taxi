import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:better_assets/assets.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
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
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/blocs/staff_details.cubit.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/components/password.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/components/profile.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class StaffDetailScreen extends StatefulWidget {
  const StaffDetailScreen({super.key, required this.id});

  final String id;

  @override
  State<StaffDetailScreen> createState() => _StaffDetailScreenState();
}

class _StaffDetailScreenState extends State<StaffDetailScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  late final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaffDetailsBloc()..onStarted(id: widget.id),
      child: Container(
        color: context.colors.surface,
        margin: context.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(title: context.tr.accountDetails, showBackButton: true),
            const SizedBox(height: 24),
            Expanded(
              child: BlocConsumer<StaffDetailsBloc, StaffDetailsState>(
                listener: (context, state) {
                  if (state.staff.isError) {
                    context.showToast(
                      state.staff.errorMessage ?? context.tr.somethingWentWrong,
                      type: SemanticColor.error,
                    );
                    context.router.replace(StaffListRoute());
                  }
                  switch (state.networkStateSave) {
                    case ApiResponseError():
                      context.showToast(
                        state.networkStateSave.errorMessage ??
                            context.tr.somethingWentWrong,
                        type: SemanticColor.error,
                      );
                      break;

                    case ApiResponseLoaded():
                      context.showToast(
                        context.tr.updatedSuccessfully,
                        type: SemanticColor.success,
                      );
                      break;

                    default:
                      break;
                  }
                },
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: kThemeAnimationDuration,
                    child: switch (state.staff) {
                      ApiResponseInitial() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      ApiResponseError() => Center(
                        child: AppEmptyState(
                          title: context.tr.error,
                          image: Assets.images.emptyStates.error,
                        ),
                      ),
                      ApiResponseLoading() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      ApiResponseLoaded(:final data) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeader(context, data!),
                          const SizedBox(height: 16),
                          _buildTabBar(context, _tabController),
                          const SizedBox(height: 16),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: const [
                                StaffDetailProfile(),
                                // StaffDetailsDevices(),
                                StaffPassword(),
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

Widget _buildHeader(BuildContext context, Fragment$staffDetails data) {
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
                imageUrl: data.media?.address,
                size: AvatarSize.size56px,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.lastName ?? '',
                    style: context.textTheme.bodyMedium,
                  ),
                  Text(
                    "${context.tr.lastActive} ${data.lastActivity?.toTimeAgo ?? context.tr.never}",
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
                    data.createdAt?.formatDateTime ?? '-',
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
                    text: data.isBlocked
                        ? context.tr.blocked
                        : context.tr.active,
                    prefixIcon: data.isBlocked
                        ? BetterIcons.cancelCircleFilled
                        : BetterIcons.checkmarkCircle02Filled,
                    color: data.isBlocked
                        ? SemanticColor.error
                        : SemanticColor.success,
                  ),
                ],
              ),
              const Spacer(),
              AppPopupMenuButton(
                showArrow: false,
                items: [
                  if (data.isBlocked)
                    AppPopupMenuItem(
                      title: context.tr.unblockUser,
                      icon: BetterIcons.squareUnlock02Outline,
                      color: SemanticColor.success,
                      onPressed: () async {
                        await context.read<StaffDetailsBloc>().unblockStaff();
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
                        await context.read<StaffDetailsBloc>().blockStaff();
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
                      final authenticatedUserId = context
                          .read<AuthBloc>()
                          .state
                          .profile
                          ?.id;
                      if (authenticatedUserId == data.id) {
                        context.showToast(
                          context.tr.cannotDeleteOwnAccount,
                          type: SemanticColor.error,
                        );
                        return;
                      }
                      await context.read<StaffDetailsBloc>().deleteStaff();
                      context.showToast(
                        context.tr.accountDeleted,
                        type: SemanticColor.success,
                      );
                      context.router.replace(StaffListRoute());
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
