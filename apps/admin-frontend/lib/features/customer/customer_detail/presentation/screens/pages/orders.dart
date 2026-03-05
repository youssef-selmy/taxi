import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/tab_bar_apps/tab_bar_apps.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/orders_parking.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/orders_shop.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/orders_taxi.dart';

class CustomerDetailsOrders extends StatelessWidget {
  final String customerId;

  const CustomerDetailsOrders({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return TabBarApps(
      taxiChild: OrdersTaxi(customerId: customerId),
      shopChild: OrdersShop(customerId: customerId),
      parkingChild: OrdersParking(customerId: customerId),
    );
  }
}
