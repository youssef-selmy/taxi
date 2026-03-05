import 'package:flutter/material.dart';

import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';

class InfoTile extends StatelessWidget {
  final bool isLoading;
  final String? data;
  final IconData iconData;

  const InfoTile({
    super.key,
    required this.isLoading,
    this.data,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: kBorder(context),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(iconData, color: context.colors.primary),
            const SizedBox(width: 8),
            Text(data ?? "---"),
          ],
        ),
      ),
    );
  }
}
