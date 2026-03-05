import 'package:better_assets/assets.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:better_design_system/organisms/step_indicator/horizontal_step_indicator.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/dispatcher_select_customer/select_customer.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/blocs/parking_dispatcher.cubit.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/screens/pages/location_and_date.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/screens/pages/select_spot.dart';

part 'parking_dispatcher_screen.desktop.dart';
part 'parking_dispatcher_screen.mobile.dart';

@RoutePage()
class ParkingDispatcherScreen extends StatelessWidget {
  const ParkingDispatcherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParkingDispatcherBloc(),
      child: context.responsive(
        const ParkingDispatcherScreenMobile(),
        lg: const ParkingDispatcherScreenDesktop(),
      ),
    );
  }
}
