import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/blocs/parking_dispatcher.cubit.dart';
import 'package:better_icons/better_icons.dart';

class WalletBalance extends StatelessWidget {
  const WalletBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingDispatcherBloc, ParkingDispatcherState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.customerWallets.isLoading,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: context.colors.outline, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  BetterIcons.wallet01Filled,
                  color: context.colors.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  state.mainWallet?.balance.formatCurrency(
                        state.mainWallet!.currency,
                      ) ??
                      '---',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
