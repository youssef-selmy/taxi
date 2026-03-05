import 'package:flutter/material.dart';

class ShopDetailDocumentsTab extends StatelessWidget {
  final String shopId;

  const ShopDetailDocumentsTab({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Documents Tab"));
  }
}
