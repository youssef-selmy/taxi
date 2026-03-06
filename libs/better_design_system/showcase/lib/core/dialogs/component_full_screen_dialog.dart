import 'package:better_design_showcase/core/components/feature_title.dart';
import 'package:better_design_showcase/core/enums/full_screen_type.dart';
import 'package:better_design_system/better_design_system.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter/material.dart';

class AppComponentFullScreenDialog extends StatelessWidget {
  final FullScreenType fullScreenType;
  final Widget child;
  final String title;
  const AppComponentFullScreenDialog({
    super.key,
    required this.child,
    required this.title,
    this.fullScreenType = FullScreenType.block,
  });

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      contentPadding: EdgeInsets.zero,
      defaultDialogType: DialogType.fullScreen,
      desktopDialogType: DialogType.fullScreen,

      child:
          fullScreenType == FullScreenType.dashboard
              ? child
              : Container(
                color: context.colors.surfaceVariantLow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [FeatureTitle(title: title), child, SizedBox()],
                ),
              ),
    );
  }
}
