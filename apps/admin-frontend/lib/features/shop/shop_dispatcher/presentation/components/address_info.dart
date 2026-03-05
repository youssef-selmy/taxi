import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/shop_dispatcher.cubit.dart';
import 'package:better_icons/better_icons.dart';

class AddressInfo extends StatelessWidget {
  const AddressInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
      builder: (context, state) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: Icon(
                BetterIcons.gps01Filled,
                color: context.colors.primary,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.selectedAddress?.title ?? "",
                  style: context.textTheme.labelMedium,
                ),
                Text(
                  state.selectedAddress?.details ?? "",
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
