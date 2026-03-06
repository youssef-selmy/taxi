import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar_number_position.dart';
import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar_size.dart';
import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar_status.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'linear_progress_bar_size.dart';
export 'linear_progress_bar_status.dart';
export 'linear_progress_bar_number_position.dart';

/// A customizable linear progress bar widget that shows progress and can have additional features like
/// a label, subtitle, cancel button, and progress percentage.
typedef BetterLinearProgressBar = AppLinearProgressBar;

class AppLinearProgressBar extends StatelessWidget {
  /// Size of the linear progress bar.
  final LinearProgressBarSize size;

  /// Label to display alongside the progress bar.
  final String? label;

  /// Function to be called when the cancel button is pressed.
  final void Function()? onCancelPressed;

  /// Subtitle text displayed below the progress bar.
  final String? subtitle;

  /// Color used for the progress bar when the status is uploading.
  final SemanticColor color;

  /// Whether the subtitle should have an icon beside it.
  final bool hasSubtitleIcon;

  /// Whether to display the progress percentage.
  final bool showProgressNumber;

  /// The current progress value between 0.0 (0%) and 1.0 (100%).
  final double progress;

  /// Defines the position of the progress number (either at the top or right).
  final LinearProgressBarNumberPosition linearProgressBarNumberPosition;

  /// Current status of the progress bar, which affects its appearance.
  final LinearProgressBarStatus linearProgressBarStatus;

  /// Creates a new instance of [AppLinearProgressBar].
  ///
  /// Defaults:
  /// - size: [LinearProgressBarSize.small]
  /// - progress: 0.5 (50%)
  /// - linearProgressBarStatus: [LinearProgressBarStatus.pending]
  const AppLinearProgressBar({
    super.key,
    this.size = LinearProgressBarSize
        .small, // Defines the size of the progress bar (default: small)
    this.label, // Optional label to display
    this.onCancelPressed, // Optional cancel action
    this.subtitle, // Optional subtitle below the progress bar
    this.color = SemanticColor
        .primary, // Primary color for uploading status (default: primary)
    this.hasSubtitleIcon =
        false, // Whether the subtitle should have an icon (default: false)
    this.showProgressNumber =
        false, // Whether to show the progress number (default: false)
    this.progress = 0.5, // Progress value between 0.0 and 1.0 (default: 0.5)
    this.linearProgressBarNumberPosition = LinearProgressBarNumberPosition
        .top, // Defines number position (default: top)
    this.linearProgressBarStatus = LinearProgressBarStatus
        .pending, // Current progress status (default: pending)
  }) : assert(
         progress >= 0.0 &&
             progress <= 1.0, // Ensures that progress is within a valid range
         'Progress must be between 0 and 1',
       );

  @override
  Widget build(BuildContext context) {
    bool isRight =
        linearProgressBarNumberPosition ==
        LinearProgressBarNumberPosition.right;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row to display the label and cancel icon (if any)
              Row(
                mainAxisAlignment: label == null
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (label != null)
                    Text(
                      label!, // Display label if provided
                      style: context.textTheme.labelLarge?.copyWith(
                        color: context.colors.onSurface,
                      ),
                    ),
                  Row(
                    children: [
                      if (!isRight)
                        if (showProgressNumber)
                          _getProgressNumber(
                            context,
                          ), // Display progress number if necessary
                      if (onCancelPressed != null) ...[
                        const SizedBox(width: 12),
                        _getCancelIcon(
                          context,
                        ), // Display cancel icon if action is provided
                      ],
                    ],
                  ),
                ],
              ),
              // Adjust spacing based on the position of the progress number
              if (onCancelPressed != null || label != null) ...[
                SizedBox(
                  height: isRight
                      ? showProgressNumber
                            ? 3
                            : 10
                      : 10,
                ),
              ],

              // Linear progress bar
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(100),
                      value: progress.clamp(
                        0.0,
                        1.0,
                      ), // Clamp the progress value between 0 and 1
                      backgroundColor: context.colors.outline,
                      valueColor: AlwaysStoppedAnimation(
                        _getColor(context),
                      ), // Dynamic color based on progress status
                      minHeight: size.value,
                    ),
                  ),
                  if (isRight) ...[
                    if (showProgressNumber) ...[
                      const SizedBox(width: 10),
                      _getProgressNumber(
                        context,
                      ), // Display progress number at the right if specified
                    ],
                  ],
                ],
              ),
              // Subtitle and optional icon
              if (subtitle != null || hasSubtitleIcon) ...[
                SizedBox(
                  height: !isRight
                      ? 10
                      : showProgressNumber
                      ? 3
                      : 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasSubtitleIcon) ...[
                      Icon(
                        BetterIcons.alertCircleFilled,
                        size: 12,
                        color:
                            linearProgressBarStatus ==
                                LinearProgressBarStatus.uploading
                            ? context.colors.onSurfaceVariant
                            : _getColor(context), // Color based on status
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (subtitle != null)
                      Expanded(
                        child: Text(
                          subtitle!, // Display subtitle if provided
                          style: context.textTheme.labelMedium?.copyWith(
                            color:
                                linearProgressBarStatus ==
                                    LinearProgressBarStatus.uploading
                                ? context.colors.onSurfaceVariant
                                : _getColor(context),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // Returns the cancel icon button, if a cancel action is provided
  Widget _getCancelIcon(BuildContext context) => CupertinoButton(
    padding: const EdgeInsets.only(bottom: 4),
    onPressed: onCancelPressed,
    minimumSize: const Size(0, 0), // Executes the cancel function
    child: Icon(
      BetterIcons.cancel01Outline,
      size: 20,
      color: context.colors.onSurfaceVariant,
    ),
  );

  // Returns the progress number with an optional icon
  Widget _getProgressNumber(BuildContext context) => Row(
    children: [
      _getProgressIcon(context), // Icon representing progress status
      const SizedBox(width: 4),
      Text(
        '${(progress * 100).toStringAsFixed(0)}%', // Display progress percentage
        style: context.textTheme.bodySmall?.copyWith(
          color:
              linearProgressBarStatus == LinearProgressBarStatus.pending ||
                  linearProgressBarStatus == LinearProgressBarStatus.uploading
              ? context.colorScheme.onSurfaceVariant
              : _getColor(context),
        ),
      ),
    ],
  );

  // Returns the appropriate icon based on the current progress status
  Widget _getProgressIcon(BuildContext context) =>
      switch (linearProgressBarStatus) {
        LinearProgressBarStatus.pending ||
        LinearProgressBarStatus.uploading => Icon(
          BetterIcons.loading03Filled,
          size: 16,
          color: context.colors.onSurface,
        ),
        LinearProgressBarStatus.error => Icon(
          BetterIcons.alertCircleFilled,
          size: 16,
          color: _getColor(context),
        ),
        LinearProgressBarStatus.success => Icon(
          BetterIcons.checkmarkCircle02Filled,
          size: 16,
          color: _getColor(context),
        ),
      };

  // Determines the color of the progress bar based on the current status
  Color _getColor(BuildContext context) => switch (linearProgressBarStatus) {
    LinearProgressBarStatus.pending => context.colors.warning,
    LinearProgressBarStatus.uploading => color.main(context),
    LinearProgressBarStatus.error => context.colors.error,
    LinearProgressBarStatus.success => context.colors.success,
  };
}
