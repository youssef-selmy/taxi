import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/atoms/info_tile/info_tile.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/select_items.cubit.dart';
import 'package:better_icons/better_icons.dart';

class WalletBalance extends StatelessWidget {
  const WalletBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectItemsBloc, SelectItemsState>(
      builder: (context, state) {
        return InfoTile(
          isLoading: state.walletBalance.isLoading,
          iconData: BetterIcons.wallet01Filled,
          data:
              state.walletBalance.data?.balance.formatCurrency(
                state.walletBalance.data!.currency,
              ) ??
              "---",
        );
      },
    );
  }
}
