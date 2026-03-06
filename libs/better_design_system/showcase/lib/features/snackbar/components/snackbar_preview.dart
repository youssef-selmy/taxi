import 'package:better_design_system/better_design_system.dart';
import 'package:flutter/material.dart';

class SnackbarPreview extends StatelessWidget {
  final Widget child;

  const SnackbarPreview({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1440,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 88, vertical: 84),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(
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

            Positioned(right: 0, bottom: 0, child: child),
          ],
        ),
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
