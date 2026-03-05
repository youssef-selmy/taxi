import 'package:flutter/material.dart';

import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/orders_taxi_insights.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/orders_taxi_list.dart';

class OrdersTaxi extends StatefulWidget {
  final String customerId;

  const OrdersTaxi({super.key, required this.customerId});

  @override
  State<OrdersTaxi> createState() => _OrdersTaxiState();
}

class _OrdersTaxiState extends State<OrdersTaxi> {
  late PageController _pageController;
  // int _currentPage = 0;

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
        // AppToggleSwitchButtonGroup(
        //   selectedValue: _currentPage,
        //   onChanged: (value) {
        //     _pageController.jumpToPage(value);
        //     setState(() {
        //       _currentPage = value;
        //     });
        //   },
        //   options: [
        //     ToggleSwitchButtonGroupOption(label: context.tr.orders, value: 0),
        //     ToggleSwitchButtonGroupOption(label: context.tr.insights, value: 1),
        //   ],
        // ),
        // const SizedBox(height: 16),
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              // setState(() {
              //   _currentPage = index;
              // });
            },
            children: [
              OrdersTaxiList(customerId: widget.customerId),
              OrdersTaxiInsights(customerId: widget.customerId),
            ],
          ),
        ),
      ],
    );
  }
}
