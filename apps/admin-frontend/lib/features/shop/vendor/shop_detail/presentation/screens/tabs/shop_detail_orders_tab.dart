import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/blocs/shop_detail_orders.cubit.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_orders_active_tab.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/presentation/screens/tabs/shop_detail_orders_history_tab.dart';

class ShopDetailOrdersTab extends StatelessWidget {
  final String shopId;

  const ShopDetailOrdersTab({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopDetailOrdersBloc()..onStarted(shopId: shopId),
      child: BlocBuilder<ShopDetailOrdersBloc, ShopDetailOrdersState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppToggleSwitchButtonGroup<int>(
                options: [
                  ToggleSwitchButtonGroupOption(
                    label: context.tr.active,
                    value: 0,
                  ),
                  ToggleSwitchButtonGroupOption(
                    label: context.tr.history,
                    value: 1,
                  ),
                ],
                selectedValue: state.selectedTab,
                onChanged: context.read<ShopDetailOrdersBloc>().onTabSelected,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: IndexedStack(
                  index: state.selectedTab,
                  children: [
                    ShopDetailOrdersActiveTab(shopId: shopId),
                    ShopDetailOrdersHistoryTab(shopId: shopId),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
