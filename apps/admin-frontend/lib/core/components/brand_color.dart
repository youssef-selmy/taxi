import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

class BrandColor extends StatelessWidget {
  final List<Color> colors;

  const BrandColor({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 20,
      child: Stack(
        children: colors.reversed.mapIndexed((index, color) {
          return Positioned(
            left: index * 10.0,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(width: 1.5, color: Colors.white),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
