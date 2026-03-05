import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class ParkingFacilityView extends StatelessWidget {
  final IconData iconData;
  final String title;
  final ParkingFacilityIconColor iconColor;

  const ParkingFacilityView({
    super.key,
    required this.iconData,
    required this.title,
    this.iconColor = ParkingFacilityIconColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(iconData, color: _iconColor(context), size: 16),
        const SizedBox(height: 4),
        Text(title, style: context.textTheme.labelMedium?.variant(context)),
      ],
    );
  }

  Color _iconColor(BuildContext context) => switch (iconColor) {
    ParkingFacilityIconColor.primary => context.colors.primary,
    ParkingFacilityIconColor.orange => context.colors.warning,
  };
}

enum ParkingFacilityIconColor { primary, orange }
