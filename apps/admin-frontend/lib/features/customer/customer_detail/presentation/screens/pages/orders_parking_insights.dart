import 'package:flutter/material.dart';

class OrdersParkingInsights extends StatefulWidget {
  final String customerId;

  const OrdersParkingInsights({super.key, required this.customerId});

  @override
  State<OrdersParkingInsights> createState() => _OrdersParkingInsightsState();
}

class _OrdersParkingInsightsState extends State<OrdersParkingInsights> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('OrdersParkingInsights'));
  }
}
