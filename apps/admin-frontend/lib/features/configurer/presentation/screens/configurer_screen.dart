import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/configurer/presentation/blocs/configurer.bloc.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/configurer_screen.desktop.dart';
import 'package:admin_frontend/features/configurer/presentation/screens/configurer_screen.mobile.dart';

@RoutePage()
class ConfigurerScreen extends StatelessWidget {
  const ConfigurerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConfigurerBloc()),
        BlocProvider.value(value: locator<ConfigBloc>()),
      ],
      child: BlocListener<ConfigBloc, ConfigState>(
        listener: (context, state) {
          if (state.config.data?.isValid == true) {
            context.router.replaceAll([const DashboardRoute()]);
          }
        },
        child: Scaffold(
          body: context.responsive(
            const ConfigurerScreenMobile(),
            lg: const ConfigurerScreenDesktop(),
          ),
        ),
      ),
    );
  }
}
