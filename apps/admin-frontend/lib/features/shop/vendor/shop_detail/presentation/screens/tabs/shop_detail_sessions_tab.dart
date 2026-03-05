import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_sessions.cubit.dart';

class ShopDetailSessionsTab extends StatelessWidget {
  final String shopId;

  const ShopDetailSessionsTab({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopDetailSessionsBloc()..onStarted(shopId: shopId),
      child: BlocBuilder<ShopDetailSessionsBloc, ShopDetailSessionsState>(
        builder: (context, state) {
          final idSessionRecords =
              state.loginSessionsState.data?.shopLoginSessions
                  .map((session) => (session.id, session.sessionInfo))
                  .toList() ??
              [];
          return idSessionRecords.view(
            context: context,
            isLoading: state.loginSessionsState.isLoading,
            onTerminate: (id) {
              _onTerminateSession(context, id);
            },
          );
        },
      ),
    );
  }

  void _onTerminateSession(BuildContext context, String sessionId) {
    context.read<ShopDetailSessionsBloc>().onTerminateSession(sessionId);
  }
}
