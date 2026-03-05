import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/settings/presentation/blocs/settings.bloc.dart';
import 'package:admin_frontend/features/settings/presentation/screens/settings_shell_screen.desktop.dart';
import 'package:admin_frontend/features/settings/presentation/screens/settings_shell_screen.mobile.dart';

@RoutePage()
class SettingsShellScreen extends StatelessWidget {
  const SettingsShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: AutoTabsRouter.pageView(
        routes: [
          SettingsGeneralRoute(),
          SettingsAppearanceRoute(),
          SettingsBrandingRoute(),
          SettingsNotificationRoute(),
          SettingsDispatchRoute(),
          SettingsMapRoute(),
          SettingsSystemRoute(),
          // SettingsSessionsRoute(),
          SettingsPasswordRoute(),
          SettingsSubscriptionRoute(),
        ],
        physics: const NeverScrollableScrollPhysics(),
        builder: (context, child, controller) {
          return BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) => Container(
              color: context.colors.surface,
              margin: context.pagePadding,
              child: context.responsive(
                SettingsShellScreenMobile(child: child),
                lg: SettingsShellScreenDesktop(child: child),
              ),
            ),
          );
        },
      ),
    );
  }
}
