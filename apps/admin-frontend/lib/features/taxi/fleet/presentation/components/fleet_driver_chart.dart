import 'package:flutter/material.dart';

class FleetDriverChart extends StatefulWidget {
  const FleetDriverChart({super.key});

  @override
  State<FleetDriverChart> createState() => _FleetDriverChartState();
}

class _FleetDriverChartState extends State<FleetDriverChart> {
  @override
  Widget build(BuildContext context) {
    // TODO: Connect to the backend
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [],
    );
  }
}
