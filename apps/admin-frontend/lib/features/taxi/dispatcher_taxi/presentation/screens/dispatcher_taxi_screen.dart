import 'package:admin_frontend/core/router/app_router.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:better_design_system/organisms/step_indicator/horizontal_step_indicator.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/dispatcher_select_customer/select_customer.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/blocs/dispatcher_taxi.cubit.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/screens/pages/searching_for_driver.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/screens/pages/select_location.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/presentation/screens/pages/select_service.dart';

part 'dispatcher_taxi_screen.desktop.dart';
part 'dispatcher_taxi_screen.mobile.dart';

@RoutePage()
class DispatcherTaxiScreen extends StatelessWidget {
  const DispatcherTaxiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DispatcherTaxiBloc(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<DispatcherTaxiBloc, DispatcherTaxiState>(
            listenWhen: (previous, current) =>
                previous.isSuccessful != current.isSuccessful &&
                current.isSuccessful,
            listener: (context, state) {
              context.router.replace(TaxiOrderListRoute());
            },
          ),
          BlocListener<DispatcherTaxiBloc, DispatcherTaxiState>(
            listenWhen: (previous, current) =>
                previous.networkState != current.networkState &&
                current.networkState.isError,
            listener: (context, state) {
              context.showFailure(state.networkState);
            },
          ),
        ],
        child: Container(
          color: context.colors.surface,
          child: context.responsive(
            const DispatcherTaxiScreenMobile(),
            lg: const DispatcherTaxiScreenDesktop(),
          ),
        ),
      ),
    );
  }
}
