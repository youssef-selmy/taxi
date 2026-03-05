import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/sidebar_navigation/sidebar_navigation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/settings/presentation/blocs/settings.bloc.dart';
import 'package:admin_frontend/features/settings/presentation/screens/settings_shell_screen.desktop.dart';

class SettingsShellScreenMobile extends StatelessWidget {
  final Widget child;

  const SettingsShellScreenMobile({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return switch (state.selectedRoute) {
          null => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PageHeader(
                title: context.tr.settings,
                subtitle: context.tr.manageAccountSettingsPreferences,
              ),
              Expanded(
                child: AppSidebarNavigation<PageRouteInfo?>(
                  itemHorizontalPadding: 0,
                  selectedItem: state.selectedRoute,
                  onItemSelected: (item) {
                    context.read<SettingsBloc>().goToRoute(item);
                    context.router.replaceAll([item!]);
                  },
                  data: navigationItemsFor(context),
                ),
              ),
            ].separated(separator: const SizedBox(height: 16)),
          ),
          _ => child,
        };
      },
    );
  }
}
