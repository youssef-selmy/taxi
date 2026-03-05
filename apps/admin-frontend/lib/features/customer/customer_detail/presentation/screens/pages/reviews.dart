import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/tab_bar_apps/tab_bar_apps.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/reviews_parking.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/reviews_shop.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/pages/reviews_taxi.dart';

class CustomerDetailsReviews extends StatelessWidget {
  final String customerId;

  const CustomerDetailsReviews({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return TabBarApps(
      taxiChild: ReviewsTaxi(customerId: customerId),
      shopChild: ReviewsShop(customerId: customerId),
      parkingChild: ReviewsParking(customerId: customerId),
    );
  }
}
