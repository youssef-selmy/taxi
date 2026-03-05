import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/blocs/staff_role_details.cubit.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/components/all_panel_permision.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/components/parking_panel_permision.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/components/shop_panel_permision.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/components/taxi_panel_permision.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

@RoutePage()
class StaffRoleDetailScreen extends StatefulWidget {
  const StaffRoleDetailScreen({
    super.key,
    @QueryParam('staffRoleId') required this.id,
  });

  final String? id;

  @override
  State<StaffRoleDetailScreen> createState() => _StaffRoleDetailScreenState();
}

class _StaffRoleDetailScreenState extends State<StaffRoleDetailScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TabController? _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaffRoleDetailsBloc()..onStarted(widget.id),
      child: Container(
        color: context.colors.surface,
        margin: context.pagePadding,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              BlocConsumer<StaffRoleDetailsBloc, StaffRoleDetailsState>(
                listener: (context, state) {
                  if (state.networkStateSave.isError) {
                    context.showToast(
                      state.networkStateSave.errorMessage ?? context.tr.error,
                      type: SemanticColor.error,
                    );
                  }
                  if (state.networkStateSave.isLoaded) {
                    context.showToast(
                      context.tr.savedSuccessfully,
                      type: SemanticColor.success,
                    );
                  }
                },
                builder: (context, state) {
                  return PageHeader(
                    title: widget.id == null
                        ? context.tr.createNewRole
                        : context.tr.editRole,
                    subtitle: context.tr.adminUserRoleDefinitions,
                    showBackButton: true,
                    onBackButtonPressed: () {
                      context.router.replace(StaffRoleListRoute());
                    },
                    actions: <Widget>[
                      if (widget.id != null)
                        AppOutlinedButton(
                          isDisabled: state.networkStateSave.isLoading,
                          onPressed: () {
                            context
                                .read<StaffRoleDetailsBloc>()
                                .deleteStaffRole();
                          },
                          prefixIcon: BetterIcons.delete03Outline,
                          text: context.tr.delete,
                          color: SemanticColor.error,
                        ),
                      AppFilledButton(
                        isDisabled: state.networkStateSave.isLoading,
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          context.read<StaffRoleDetailsBloc>().saveChanges();
                        },
                        text: context.tr.saveChanges,
                      ),
                    ],
                  );
                },
              ),
              Expanded(
                child: BlocConsumer<StaffRoleDetailsBloc, StaffRoleDetailsState>(
                  listener: (context, state) {
                    if (state.networkStateSave is ApiResponseLoaded) {
                      if (locator<AuthBloc>().state.profile?.role != null &&
                          locator<AuthBloc>().state.profile?.role?.id ==
                              state.staffRoleId) {
                        context.read<AuthBloc>().add(
                          AuthEvent$RefreshProfile(),
                        );
                      }
                      context.router.replace(StaffRoleListRoute());
                    }
                  },
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: kThemeAnimationDuration,
                      child: switch (state.staffRole) {
                        ApiResponseInitial() => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        ApiResponseError() => Center(
                          child: Text(context.tr.error),
                        ),
                        ApiResponseLoading() => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        ApiResponseLoaded() => Skeletonizer(
                          enabled: state.staffRole.isLoading,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 32),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: AppTextField(
                                              label: context.tr.title,
                                              validator: context.validateName,
                                              hint: context.tr.enterTitle,
                                              initialValue: state.title,
                                              onChanged: context
                                                  .read<StaffRoleDetailsBloc>()
                                                  .onTitleChanged,
                                            ),
                                          ),
                                          const Expanded(child: SizedBox()),
                                        ],
                                      ),
                                      const SizedBox(height: 32),
                                      SwitcherWidget(
                                        icon: BetterIcons.taxiFilled,
                                        active: state.allowedAppTypes.contains(
                                          Enum$AppType.Taxi,
                                        ),
                                        onChanged: context
                                            .read<StaffRoleDetailsBloc>()
                                            .onTaxiPanelSwitchChanged,
                                        title: context.tr.taxiPanel,
                                        subtitle: context
                                            .tr
                                            .disableTaxiPanelAccessConsequence,
                                      ),
                                      const SizedBox(height: 16),
                                      SwitcherWidget(
                                        icon: BetterIcons.shoppingBag02Filled,
                                        active: state.allowedAppTypes.contains(
                                          Enum$AppType.Shop,
                                        ),
                                        onChanged: context
                                            .read<StaffRoleDetailsBloc>()
                                            .onShopPanelSwitchChanged,
                                        title: context.tr.shopPanel,
                                        subtitle: context
                                            .tr
                                            .disableShopPanelAccessConsequence,
                                      ),
                                      const SizedBox(height: 16),
                                      SwitcherWidget(
                                        icon:
                                            BetterIcons.parkingAreaSquareFilled,
                                        active: state.allowedAppTypes.contains(
                                          Enum$AppType.Parking,
                                        ),
                                        onChanged: context
                                            .read<StaffRoleDetailsBloc>()
                                            .onParkingPanelSwitchChanged,
                                        title: context.tr.parkingPanel,
                                        subtitle: context
                                            .tr
                                            .disableParkingPanelAccessConsequence,
                                      ),
                                      const SizedBox(height: 32),
                                      LargeHeader(
                                        title: context.tr.permissions,
                                      ),
                                      const SizedBox(height: 34),
                                      AppTabMenuHorizontal(
                                        controller: _tabController,
                                        style: TabMenuHorizontalStyle.soft,
                                        color: SemanticColor.primary,
                                        selectedValue: _currentIndex,
                                        onChanged: (value) {
                                          _tabController?.animateTo(value);
                                          setState(() {
                                            _currentIndex = value;
                                          });
                                        },
                                        tabs: [
                                          TabMenuHorizontalOption(
                                            title:
                                                context.tr.allPanelsPermissions,
                                            value: 0,
                                          ),
                                          TabMenuHorizontalOption(
                                            title: context
                                                .tr
                                                .taxiPanelsPermissions,
                                            value: 1,
                                          ),
                                          TabMenuHorizontalOption(
                                            title: context
                                                .tr
                                                .shopPanelsPermissions,
                                            value: 2,
                                          ),
                                          TabMenuHorizontalOption(
                                            title: context
                                                .tr
                                                .parkingPanelsPermissions,
                                            value: 3,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 32),
                                      SizedBox(
                                        height: 900,
                                        child: TabBarView(
                                          controller: _tabController,
                                          children: <Widget>[
                                            AllPanelPermision(
                                              enabledPermissions:
                                                  state.permissions,
                                            ),
                                            TaxiPanelPermision(
                                              enabledPermissions:
                                                  state.taxiPermissions,
                                            ),
                                            ShopPanelPermision(
                                              enabledPermissions:
                                                  state.shopPermissions,
                                            ),
                                            ParkingPanelPermision(
                                              enabledPermissions:
                                                  state.parkingPermissions,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
}

class SwitcherWidget extends StatelessWidget {
  const SwitcherWidget({
    super.key,
    required this.icon,
    required this.active,
    required this.title,
    required this.subtitle,
    required this.onChanged,
  });

  final IconData icon;
  final bool active;
  final String title;
  final String subtitle;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: context.colors.primary),
            const SizedBox(width: 8),
            Text(title, style: context.textTheme.bodyMedium),
            const Spacer(),
            Switch(value: active, onChanged: onChanged),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                subtitle,
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(height: 1),
      ],
    );
  }
}
