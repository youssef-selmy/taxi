import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/sessions.cubit.dart';

class CustomerDetailsDevices extends StatelessWidget {
  final String customerId;

  const CustomerDetailsDevices({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionsBloc()..onStarted(customerId: customerId),
      child: BlocBuilder<SessionsBloc, SessionsState>(
        builder: (context, state) {
          final sessionIdInfoRecords =
              state.networkState.data
                  ?.map((session) => (session.id, session.sessionInfo))
                  .toList() ??
              [];
          return sessionIdInfoRecords.view(
            context: context,
            isLoading: state.networkState.isLoading,
            onTerminate: context.read<SessionsBloc>().onTerminate,
          );
        },
      ),
    );
  }
}
