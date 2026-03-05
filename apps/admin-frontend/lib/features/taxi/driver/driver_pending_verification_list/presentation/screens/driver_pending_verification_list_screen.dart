import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_list/presentation/blocs/driver_pending_verification_list.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_list/presentation/components/driver_pending_verification_list_table.dart';

@RoutePage()
class DriverPendingVerificationListScreen extends StatelessWidget {
  const DriverPendingVerificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverPendingVerificationListBloc()..onStarted(),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(
              title: context.tr.pendingVerificationDrivers,
              subtitle: context.tr.listOfDriversWaitingToBeRegistered,
            ),
            SizedBox(height: 16),
            Expanded(child: DriverPendingVerificationListTable()),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
