import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:intl/intl.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_currency/droopdown_currency.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/presentation/blocs/shop_payout_session_list.cubit.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/presentation/components/shop_payout_session_list_new_payout_session_card.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/presentation/components/shop_payout_session_list_pending_sessions_card.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/presentation/components/shop_payout_session_list_sessions_list.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/presentation/components/shop_payout_session_list_transactions_records.dart';

@RoutePage()
class ShopPayoutSessionListScreen extends StatelessWidget {
  const ShopPayoutSessionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopPayoutSessionListBloc()
        ..onStarted(currency: context.read<AuthBloc>().state.selectedCurrency),
      child: SingleChildScrollView(
        child: Container(
          color: context.colors.surface,
          margin: context.pagePadding.copyWith(bottom: 0),
          child: Column(
            children: [
              PageHeader(
                title: context.tr.shopPayouts,
                subtitle: DateFormat('dd MMM, yyyy').format(DateTime.now()),
                actions: const [
                  SizedBox(
                    width: 170,
                    child: AppDroopdownCurrency(
                      isCompact: true,
                      showTitle: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              LayoutGrid(
                columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
                rowSizes: context.responsive([200.px, 200.px], lg: [200.px]),
                rowGap: 16,
                columnGap: 16,
                children: const [
                  ShopPayoutSessionListNewPayoutSessionCard(),
                  // ShopPayoutSessionListScheduledPayoutsCard(),
                  ShopPayoutSessionListPendingSessionsCard(),
                ],
              ),
              const SizedBox(height: 16),
              const SizedBox(
                height: 400,
                child: ShopPayoutSessionListSessionsList(),
              ),
              const SizedBox(height: 16),
              const SizedBox(
                height: 400,
                child: ShopPayoutSessionListTransactionsRecords(),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
