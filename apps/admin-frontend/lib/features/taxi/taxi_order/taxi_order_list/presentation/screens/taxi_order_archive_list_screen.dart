import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/presentation/blocs/taxi_orders_archive_list.cubit.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/presentation/components/taxi_archive_orders_summary.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/presentation/components/taxi_archive_orders_table.dart';

part 'taxi_order_archive_list_screen.desktop.dart';
part 'taxi_order_archive_list_screen.mobile.dart';

@RoutePage()
class TaxiOrderArchiveListScreen extends StatelessWidget {
  const TaxiOrderArchiveListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaxiOrdersArchiveListBloc()..onStarted(),
      child: context.responsive(
        const TaxiOrderArchiveListScreenMobile(),
        lg: const TaxiOrderArchiveListScreenDesktop(),
      ),
    );
  }
}
