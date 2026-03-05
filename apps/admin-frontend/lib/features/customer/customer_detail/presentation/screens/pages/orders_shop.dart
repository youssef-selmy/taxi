import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';

import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/orders_shop_insights.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/orders_shop_list.dart';
import 'package:better_localization/localizations.dart';

class OrdersShop extends StatefulWidget {
  final String customerId;

  const OrdersShop({super.key, required this.customerId});

  @override
  State<OrdersShop> createState() => _OrdersShopState();
}

class _OrdersShopState extends State<OrdersShop> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppToggleSwitchButtonGroup(
          selectedValue: _pageController.page?.round() ?? 0,
          onChanged: (value) => _pageController.jumpToPage(value),
          options: [
            ToggleSwitchButtonGroupOption(label: context.tr.orders, value: 0),
            ToggleSwitchButtonGroupOption(label: context.tr.insights, value: 1),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: PageView(
            children: [
              OrdersShopList(customerId: widget.customerId),
              OrdersShopInsights(customerId: widget.customerId),
            ],
          ),
        ),
      ],
    );
  }
}
