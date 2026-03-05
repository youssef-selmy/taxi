import 'package:admin_frontend/core/blocs/notifications.cubit.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/dashboard/presentation/blocs/dashboard.cubit.dart';
import 'package:admin_frontend/features/dashboard/presentation/components/drawer.desktop.dart';
import 'package:admin_frontend/features/dashboard/presentation/components/top_bar_desktop.dart';
import 'package:admin_frontend/features/dashboard/presentation/components/top_bar_mobile.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    locator<ConfigBloc>().onStarted();
    locator<AuthBloc>().add(AuthEvent$OnStarted());
    locator<DashboardBloc>().onStarted();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: locator<ConfigBloc>()),
          BlocProvider.value(value: locator<DashboardBloc>()),
          BlocProvider.value(value: locator<AuthBloc>()),
          BlocProvider.value(value: locator<NotificationsCubit>()),
        ],
        child: BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.selectedAppType != current.selectedAppType,
          listener: (context, state) {},
          child: Column(
            children: [
              context.responsive(TopBarMobile(), lg: const TopBarDesktop()),
              Expanded(
                child: Row(
                  children: [
                    if (context.isDesktop)
                      Container(
                        padding: EdgeInsets.only(right: 1),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: context.colors.outline),
                          ),
                        ),
                        child: DrawerDesktop(),
                      ),
                    Expanded(child: AutoRouter()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
