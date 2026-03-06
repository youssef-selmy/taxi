import 'dart:math';

import 'package:better_design_system/atoms/circular_progress_bar/circular_progress_bar_size.dart';
import 'package:better_design_system/atoms/circular_progress_bar/circular_progress_bar_status.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
export 'circular_progress_bar_size.dart';
export 'circular_progress_bar_status.dart';

typedef BetterCircularProgressBar = AppCircularProgressBar;

class AppCircularProgressBar extends StatelessWidget {
  /// Defines the size of the circular progress bar. Defaults to [CircularProgressBarSize.size24px].
  final CircularProgressBarSize size;

  /// Specifies the current status of the progress bar. Defaults to [CircularProgressBarStatus.pending].
  final CircularProgressBarStatus status;

  /// Whether the progress percentage should be displayed inside the circle. Defaults to false.
  final bool showProgressNumber;

  /// Progress value between 0.0 (0%) and 1.0 (100%). Defaults to 0.0.
  final double progress;

  /// Color used when the status is uploading. Defaults to [SemanticColor.primary].
  final SemanticColor color;

  const AppCircularProgressBar({
    super.key,

    /// Default size of the progress bar is 24px
    this.size = CircularProgressBarSize.size24px,

    /// Default status of the progress bar is 'pending'
    this.status = CircularProgressBarStatus.pending,

    /// Default behavior is not to show the progress percentage inside the circle
    this.showProgressNumber = false,

    /// Default progress value is 0.0 (representing 0% progress)
    this.progress = 0.0,

    /// Default color is the primary color used for the 'uploading' status
    this.color = SemanticColor.primary,

    /// Ensures the progress value is between 0 and 1
  }) : assert(
         progress >= 0.0 && progress <= 1.0,
         'Progress must be between 0 and 1',
       );

  @override
  Widget build(BuildContext context) {
    double progressBarSize = size
        .value; // The actual size of the progress bar based on the selected size
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: progressBarSize,
          height: progressBarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.colors.transparent,
          ),
          child: Center(
            child: _getCenterIcon(context),
          ), // Displays the central icon based on the current status
        ),

        Positioned(
          child: CustomPaint(
            size: Size(progressBarSize, progressBarSize),
            painter: _CircularProgressPainter(
              value: progress, // Passes the progress value to the painter
              status: status, // Passes the status to the painter
              backgroundColor: _getBackgroundColor(
                context,
              ), // Sets the background color based on the status
              foregroundColor: _getColor(
                context,
              ), // Sets the foreground color based on the status
            ),
          ),
        ),
      ],
    );
  }

  /// Returns the progress percentage text if progress is displayed
  Widget _getProgressNumber(BuildContext context) {
    if (size == CircularProgressBarSize.size24px ||
        size == CircularProgressBarSize.size32px) {
      return const SizedBox(); // No number displayed for small sizes
    } else {
      return Text(
        '${(progress * 100).toInt()}%', // Display progress as percentage
        style: _getTextStyle(
          context,
        ), // Returns appropriate text style based on size
      );
    }
  }

  /// Returns the text style based on the size of the progress bar
  TextStyle? _getTextStyle(BuildContext context) {
    switch (size) {
      case CircularProgressBarSize.size24px:
      case CircularProgressBarSize.size32px:
        return null; // No text style for smaller sizes
      case CircularProgressBarSize.size40px:
      case CircularProgressBarSize.size48px:
      case CircularProgressBarSize.size52px:
      case CircularProgressBarSize.size64px:
        return context.textTheme.labelSmall?.copyWith(
          color: context.colors.onSurface,
          fontSize: 10, // Set font size for medium to large sizes
        );
      case CircularProgressBarSize.size72px:
        return context.textTheme.labelMedium?.copyWith(
          color: context.colors.onSurface,
          fontSize: 12, // Larger font size for the largest size
        );
    }
  }

  /// Returns the appropriate color for the progress bar based on its status
  Color _getColor(BuildContext context) {
    switch (status) {
      case CircularProgressBarStatus.pending:
        return context.colors.warning; // Yellow for pending status
      case CircularProgressBarStatus.uploading:
        return color.main(context); // Custom color for uploading status
      case CircularProgressBarStatus.error:
        return context.colors.error; // Red for error status
      case CircularProgressBarStatus.success:
        return context.colors.success; // Green for success status
    }
  }

  /// Returns the background color of the progress bar based on its status
  Color _getBackgroundColor(BuildContext context) {
    switch (status) {
      case CircularProgressBarStatus.pending:
      case CircularProgressBarStatus.uploading:
      case CircularProgressBarStatus.success:
        return context.colors.outline; // Light outline for most statuses
      case CircularProgressBarStatus.error:
        return context.colors.errorVariantLow; // Dimmed red for error status
    }
  }

  /// Returns the central icon based on the current status
  Widget _getCenterIcon(BuildContext context) {
    switch (status) {
      case CircularProgressBarStatus.pending:
        return Icon(
          BetterIcons.loading03Filled, // Icon for pending status
          size: size.iconSize, // Icon size based on progress bar size
          color: context
              .colors
              .onSurfaceVariantLow, // Icon color for pending status
        );
      case CircularProgressBarStatus.uploading:
        return showProgressNumber
            ? _getProgressNumber(context)
            : const SizedBox(); // Show progress number if needed
      case CircularProgressBarStatus.error:
        return Icon(
          BetterIcons.alertCircleFilled, // Icon for error status
          size: size.iconSize,
          color: _getColor(context), // Icon color for error status
        );
      case CircularProgressBarStatus.success:
        return Icon(
          BetterIcons.checkmarkCircle02Filled, // Icon for success status
          size: size.iconSize,
          color: _getColor(context), // Icon color for success status
        );
    }
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double value; // The progress value between 0.0 and 1.0
  final CircularProgressBarStatus
  status; // The current status of the progress bar
  final Color foregroundColor; // The foreground color (progress color)
  final Color backgroundColor; // The background color of the progress circle

  _CircularProgressPainter({
    required this.value,
    required this.status,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintBackground = Paint()
      ..color =
          backgroundColor // Set background color
      ..strokeWidth =
          5 // Width of the circle stroke
      ..style = PaintingStyle.stroke;

    final Paint paintForeground = Paint()
      ..color =
          foregroundColor // Set foreground color
      ..strokeWidth =
          5 // Width of the progress stroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Rounded stroke end

    // Draw the background circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paintBackground,
    );

    double angle = 2 * pi * value; // Calculate the angle for the progress arc

    // Draw the foreground progress arc
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      -pi / 2,
      angle,
      false,
      paintForeground, // Apply the progress color
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // No need to repaint unless the value changes
  }
}
