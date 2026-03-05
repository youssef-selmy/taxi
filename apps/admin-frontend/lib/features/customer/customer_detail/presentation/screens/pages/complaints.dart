import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/tab_bar_apps/tab_bar_apps.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/complaints_parking.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/complaints_shop.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/complaints_taxi.dart';

class CustomerDetailsComplaints extends StatelessWidget {
  final String customerId;

  const CustomerDetailsComplaints({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return TabBarApps(
      taxiChild: CustomerComplaintsTaxi(customerId: customerId),
      shopChild: CustomerComplaintsShop(customerId: customerId),
      parkingChild: CustomerComplaintsParking(customerId: customerId),
    );
  }
}
