import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppComponentDoc extends StatelessWidget {
  const AppComponentDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          context.isMobile
              ? const EdgeInsets.symmetric(horizontal: 16.0)
              : EdgeInsets.zero,
      child: AppClickableCard(
        padding: EdgeInsets.zero,
        type: ClickableCardType.elevated,
        elevation: BetterShadow.shadow4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: context.colors.outline),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        BetterIcons.folder01Filled,
                        color: context.colors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Component Documentation',
                    style: context.textTheme.labelLarge,
                  ),
                  const Spacer(),
                  AppIconButton(
                    icon: BetterIcons.moreHorizontalCircle01Filled,
                    size: ButtonSize.small,
                    iconColor: context.colors.onSurface,
                    iconSize: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              child: AppLinearProgressBar(
                label: 'Label',
                showProgressNumber: true,
                progress: 0.6,
                subtitle: '20/30 Components documented',
                size: LinearProgressBarSize.medium,
                linearProgressBarNumberPosition:
                    LinearProgressBarNumberPosition.right,
                linearProgressBarStatus: LinearProgressBarStatus.uploading,
                onCancelPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
