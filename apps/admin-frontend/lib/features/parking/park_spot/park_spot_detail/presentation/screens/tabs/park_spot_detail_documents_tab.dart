import 'package:flutter/material.dart';

class ParkSpotDetailDocumentsTab extends StatelessWidget {
  final String parkSpotId;

  const ParkSpotDetailDocumentsTab({super.key, required this.parkSpotId});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Documents Tab"));
  }
}
