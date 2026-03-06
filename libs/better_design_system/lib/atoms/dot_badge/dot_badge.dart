import 'package:better_design_system/atoms/dot_badge/dot_badge_mode.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge_options.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge_size.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

export 'dot_badge_mode.dart';
export 'dot_badge_options.dart';
export 'dot_badge_size.dart';

/// A customizable dot badge that can display as a simple dot or a counter.
///
/// The [BetterDotBadge] supports two modes:
/// - **Dot mode**: A simple colored circle (default behavior)
/// - **Counter mode**: Displays a number inside the badge
///
/// It also supports a pulsing animation for attention-grabbing notifications.
///
/// Example - Simple dot:
/// ```dart
/// const BetterDotBadge(color: SemanticColor.error)
/// ```
///
/// Example - Counter:
/// ```dart
/// BetterDotBadge.counter(count: 5, color: SemanticColor.error)
/// ```
///
/// Example - Animated:
/// ```dart
/// BetterDotBadge(isAnimating: true, color: SemanticColor.success)
/// ```
class BetterDotBadge extends StatefulWidget {
  /// Creates a dot badge.
  ///
  /// By default, displays as a simple colored circle without animation.
  const BetterDotBadge({
    super.key,
    this.color = SemanticColor.info,
    this.dotBadgeSize = DotBadgeSize.medium,
    this.isAnimating = false,
  }) : count = null,
       maxCount = 99;

  /// Creates a counter badge with a number.
  ///
  /// The [count] is required and will be displayed inside the badge.
  /// If [count] exceeds [maxCount], it displays as "[maxCount]+".
  const BetterDotBadge.counter({
    super.key,
    required this.count,
    this.maxCount = 99,
    this.color = SemanticColor.error,
    this.dotBadgeSize = DotBadgeSize.medium,
    this.isAnimating = false,
  });

  /// Creates a badge from [DotBadgeOptions].
  ///
  /// This factory is useful when integrating with components that
  /// accept [DotBadgeOptions] as a parameter.
  factory BetterDotBadge.fromOptions(DotBadgeOptions options) =>
      BetterDotBadge._internal(
        count: options.count,
        maxCount: options.maxCount,
        color: options.color,
        dotBadgeSize: options.size,
        isAnimating: options.isAnimating,
      );

  const BetterDotBadge._internal({
    this.count,
    this.maxCount = 99,
    this.color = SemanticColor.info,
    this.dotBadgeSize = DotBadgeSize.medium,
    this.isAnimating = false,
  }) : super(key: null);

  /// The semantic color of the badge.
  final SemanticColor color;

  /// The size of the badge.
  final DotBadgeSize dotBadgeSize;

  /// The count to display. When null or 0, displays as dot mode.
  final int? count;

  /// Maximum count before showing "[maxCount]+".
  final int maxCount;

  /// Whether to show pulsing animation.
  final bool isAnimating;

  /// Returns the display mode based on [count].
  DotBadgeMode get mode =>
      (count != null && count! > 0) ? DotBadgeMode.counter : DotBadgeMode.dot;

  /// Returns the formatted display string.
  String get displayCount => switch (count) {
    null => '',
    <= 0 => '',
    _ when count! > maxCount => '$maxCount+',
    _ => count.toString(),
  };

  @override
  State<BetterDotBadge> createState() => _BetterDotBadgeState();
}

class _BetterDotBadgeState extends State<BetterDotBadge>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _ringScaleAnimation;
  Animation<double>? _ringOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  @override
  void didUpdateWidget(covariant BetterDotBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isAnimating != widget.isAnimating) {
      _setupAnimation();
    }
  }

  void _setupAnimation() {
    if (widget.isAnimating) {
      _animationController?.dispose();
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1400),
      )..repeat();

      // Ring expands from 1.0 to 2.5x the badge size
      _ringScaleAnimation = Tween<double>(begin: 1.0, end: 2.5).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.easeOut),
      );

      // Ring fades out as it expands
      _ringOpacityAnimation = Tween<double>(begin: 0.6, end: 0.0).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.easeOut),
      );
    } else {
      _animationController?.dispose();
      _animationController = null;
      _ringScaleAnimation = null;
      _ringOpacityAnimation = null;
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final badge = switch (widget.mode) {
      DotBadgeMode.dot => _buildDot(context),
      DotBadgeMode.counter => _buildCounter(context),
    };

    if (!widget.isAnimating || _animationController == null) {
      return badge;
    }

    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        final badgeColor = widget.color.main(context);
        final ringSize = switch (widget.mode) {
          DotBadgeMode.dot => widget.dotBadgeSize.dotValue,
          DotBadgeMode.counter => widget.dotBadgeSize.counterHeight,
        };

        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Expanding glow ring
            Transform.scale(
              scale: _ringScaleAnimation!.value,
              child: Container(
                width: ringSize,
                height: ringSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: badgeColor.withValues(
                    alpha: _ringOpacityAnimation!.value,
                  ),
                ),
              ),
            ),
            // The actual badge on top
            child!,
          ],
        );
      },
      child: badge,
    );
  }

  Widget _buildDot(BuildContext context) => Container(
    width: widget.dotBadgeSize.dotValue,
    height: widget.dotBadgeSize.dotValue,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: widget.color.main(context),
    ),
  );

  Widget _buildCounter(BuildContext context) => Container(
    constraints: BoxConstraints(
      minWidth: widget.dotBadgeSize.minCounterWidth,
      minHeight: widget.dotBadgeSize.counterHeight,
    ),
    padding: widget.dotBadgeSize.counterPadding,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: widget.color.main(context),
    ),
    child: Center(
      child: Text(
        widget.displayCount,
        style: TextStyle(
          fontSize: widget.dotBadgeSize.fontSize,
          fontWeight: FontWeight.w600,
          height: 1.0,
          color: widget.color.onColor(context),
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

/// Wraps any widget with a [BetterDotBadge] overlay.
///
/// This widget handles the Stack+Positioned pattern for badge positioning,
/// making it easy to add a badge to any widget without manual positioning.
///
/// Example:
/// ```dart
/// BetterDotBadgeWrapper(
///   options: DotBadgeOptions.counter(count: 5),
///   child: Icon(Icons.notifications),
/// )
/// ```
///
/// The badge position can be customized via [DotBadgeOptions.alignment]
/// and [DotBadgeOptions.offset].
class BetterDotBadgeWrapper extends StatelessWidget {
  /// The child widget to wrap with a badge.
  final Widget child;

  /// The badge configuration options.
  final DotBadgeOptions options;

  /// Creates a [BetterDotBadgeWrapper].
  const BetterDotBadgeWrapper({
    super.key,
    required this.child,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    if (!options.isVisible) return child;

    // Hide badge if count is 0 or negative in counter mode
    if (options.mode == DotBadgeMode.counter &&
        (options.count == null || options.count! <= 0)) {
      return child;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: _isTopAligned ? options.offset.dy : null,
          bottom: _isBottomAligned ? -options.offset.dy : null,
          right: _isRightAligned ? -options.offset.dx : null,
          left: _isLeftAligned ? options.offset.dx : null,
          child: BetterDotBadge.fromOptions(options),
        ),
      ],
    );
  }

  bool get _isTopAligned => switch (options.alignment) {
    Alignment.topRight || Alignment.topLeft || Alignment.topCenter => true,
    _ => false,
  };

  bool get _isBottomAligned => switch (options.alignment) {
    Alignment.bottomRight ||
    Alignment.bottomLeft ||
    Alignment.bottomCenter => true,
    _ => false,
  };

  bool get _isRightAligned => switch (options.alignment) {
    Alignment.topRight ||
    Alignment.bottomRight ||
    Alignment.centerRight => true,
    _ => false,
  };

  bool get _isLeftAligned => switch (options.alignment) {
    Alignment.topLeft || Alignment.bottomLeft || Alignment.centerLeft => true,
    _ => false,
  };
}
