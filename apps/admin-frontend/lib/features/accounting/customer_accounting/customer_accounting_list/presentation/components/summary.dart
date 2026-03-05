import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/kpi_card/kpi_card_style_b.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_list/presentation/blocs/customer_accounting_list.bloc.dart';

class CustomerAccountingListSummary extends StatelessWidget {
  const CustomerAccountingListSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerAccountingListBloc, CustomerAccountingListState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.walletSummaryState.isLoading,
          child: LayoutGrid(
            columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
            rowSizes: const [auto, auto],
            columnGap: 16,
            rowGap: 16,
            children: [
              KPICardStyleB(
                title: context.tr.totalUserWallets,
                value:
                    (state
                                .walletSummaryState
                                .data
                                ?.walletsCount
                                .firstOrNull
                                ?.count
                                ?.id ??
                            0)
                        .toStringAsFixed(0),
              ),
              KPICardStyleB(
                title: context.tr.totalWalletBalances,
                value:
                    (state
                                .walletSummaryState
                                .data
                                ?.totalWalletBalance
                                .firstOrNull
                                ?.sum
                                ?.balance ??
                            0)
                        .toStringAsFixed(0),
              ),
            ],
          ),
        );
      },
    );
  }
}
