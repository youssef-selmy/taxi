import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/presentation/blocs/taxi_orders_list.bloc.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/presentation/components/taxi_active_order_summary_desktop.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/presentation/components/taxi_active_orders_table.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';

part 'taxi_order_list_screen.desktop.dart';
part 'taxi_order_list_screen.mobile.dart';

@RoutePage()
class TaxiOrderListScreen extends StatelessWidget {
  const TaxiOrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TaxiOrdersListBloc()..add(TaxiOrdersListEvent.started()),
      child: context.responsive(
        const TaxiOrderListScreenMobile(),
        lg: const TaxiOrderListScreenDesktop(),
      ),
    );
  }
}
