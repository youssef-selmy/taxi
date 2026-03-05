import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_list/presentation/blocs/parking_order_list.cubit.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_list/presentation/components/parking_order_list_statistics_box.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_list/presentation/components/parking_order_list_tab_bar.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_list/presentation/components/parking_order_list_table.dart';

part 'parking_order_list_screen.desktop.dart';
part 'parking_order_list_screen.mobile.dart';

@RoutePage()
class ParkingOrderListScreen extends StatelessWidget {
  const ParkingOrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: BlocProvider(
        create: (context) => ParkingOrderListBloc()..onStarted(),
        child: context.responsive(
          const ParkingOrderListScreenMobile(),
          lg: const ParkingOrderListScreenDesktop(),
        ),
      ),
    );
  }
}
