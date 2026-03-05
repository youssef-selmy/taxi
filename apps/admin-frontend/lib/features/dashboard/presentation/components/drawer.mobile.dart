import 'package:admin_frontend/features/dashboard/presentation/components/app_switcher_v2.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter/cupertino.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/dashboard/presentation/blocs/dashboard.cubit.dart';
import 'package:admin_frontend/features/dashboard/presentation/components/drawer.desktop.dart';

class DrawerMobile extends StatelessWidget {
  const DrawerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      defaultDialogType: DialogType.fullScreenBottomSheet,
      desktopDialogType: DialogType.fullScreenBottomSheet,
      contentPadding: EdgeInsets.zero,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: locator<ConfigBloc>()),
          BlocProvider.value(value: locator<AuthBloc>()),
          BlocProvider.value(value: locator<DashboardBloc>()),
        ],
        child: BlocBuilder<ConfigBloc, ConfigState>(
          builder: (context, state) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                return BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, stateDashboard) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 16),
                      child: AppSidebarNavigation<PageRouteInfo?>(
                        header: AppSwitcherV2(),
                        selectedItem: stateDashboard.selectedRoute,
                        onItemSelected: (item) {
                          context.read<DashboardBloc>().goToRoute(item);
                          context.router.replaceAll([item!]);
                          Navigator.of(context).pop();
                        },
                        data: navigationItemsFor(
                          context,
                          authState.selectedAppType,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
