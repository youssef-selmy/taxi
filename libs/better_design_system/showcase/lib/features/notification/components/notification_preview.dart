import 'dart:ui';

import 'package:better_design_system/better_design_system.dart';
import 'package:flutter/material.dart';

class NotificationPreview extends StatelessWidget {
  final Widget notification;
  const NotificationPreview({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1440,
      child: Stack(
        alignment: AlignmentGeometry.centerRight,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 88, vertical: 84),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 289,
                  height: 40,
                  decoration: BoxDecoration(
                    color: context.colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 24,
                        decoration: BoxDecoration(
                          color: context.colors.surfaceVariant,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  spacing: 65,
                  children: [
                    _buildContainerItem(context),
                    _buildContainerItem(context),
                    _buildContainerItem(context),
                  ],
                ),
                SizedBox(height: 48),
                Row(
                  spacing: 65,
                  children: [
                    _buildContainerItem(context),
                    _buildContainerItem(context),
                    _buildContainerItem(context),
                  ],
                ),
                SizedBox(height: 48),
                Row(
                  spacing: 65,
                  children: [
                    _buildContainerItem(context),
                    _buildContainerItem(context),
                    _buildContainerItem(context),
                  ],
                ),
              ],
            ),
          ),

          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: context.colors.surfaceMuted.withValues(alpha: 0.08),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 414,
            child: Positioned.fill(top: 0, right: 0, child: notification),
          ),
        ],
      ),
    );
  }

  Expanded _buildContainerItem(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Container(
            height: 165,
            decoration: BoxDecoration(
              color: context.colors.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Container(
            width: 128,
            height: 16,
            decoration: BoxDecoration(
              color: context.colors.surfaceVariant,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Container(
            height: 22,
            decoration: BoxDecoration(
              color: context.colors.surfaceVariant,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      ),
    );
  }
}
