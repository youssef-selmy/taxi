import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:generic_map/generic_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class ParkingMarker extends StatelessWidget {
  final double price;
  final String currency;
  final bool isSelected;
  final Function() onTap;

  const ParkingMarker({
    super.key,
    required this.price,
    required this.currency,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        onTap();
      },
      minimumSize: Size(0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: kThemeAnimationDuration,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: backgroundColor(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  price.formatCurrency(currency),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: foregroundColor(context),
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -4),
            child: Transform.flip(
              flipY: true,
              child: AnimatedContainer(
                duration: kThemeAnimationDuration,
                width: 16,
                height: 15,
                decoration: ShapeDecoration(
                  color: backgroundColor(context),
                  shape: const StarBorder.polygon(sides: 3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color backgroundColor(BuildContext context) =>
      isSelected ? context.colors.primary : context.colors.surface;

  Color foregroundColor(BuildContext context) =>
      isSelected ? context.colors.onPrimary : context.colors.onSurface;
}

extension ParkingMarkerX on ParkingMarker {
  CustomMarker toCustomMarker(LatLng point) {
    return CustomMarker(
      id: 'parking',
      position: point,
      width: 77,
      height: 57,
      widget: this,
    );
  }
}
