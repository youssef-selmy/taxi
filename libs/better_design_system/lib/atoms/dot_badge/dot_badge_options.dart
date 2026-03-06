import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/dot_badge/dot_badge_mode.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge_size.dart';
import 'package:better_design_system/colors/semantic_color.dart';

/// Configuration options for [BetterDotBadge] when used within other components.
///
/// This allows components like [AppOutlinedButton], [AppIconButton], etc.
/// to internally render a badge overlay without exposing the full badge API.
///
/// Example:
/// ```dart
/// AppOutlinedButton(
///   text: 'Notifications',
///   onPressed: () {},
///   dotBadge: const DotBadgeOptions(
///     count: 5,
///     color: SemanticColor.error,
///   ),
/// )
/// ```
class DotBadgeOptions {
  /// Whether the badge is visible.
  /// Defaults to true.
  final bool isVisible;

  /// The count to display. When null or 0, displays as dot mode.
  /// When > 0, displays as counter mode.
  final int? count;

  /// Maximum count to display before showing "[maxCount]+".
  /// Defaults to 99.
  final int maxCount;

  /// The semantic color for the badge.
  /// Defaults to [SemanticColor.error].
  final SemanticColor color;

  /// The size of the badge.
  /// Defaults to [DotBadgeSize.small].
  final DotBadgeSize size;

  /// Whether to animate with a pulsing effect.
  /// Defaults to false.
  final bool isAnimating;

  /// The position offset for the badge relative to the parent.
  /// Defaults to top-right positioning: Offset(6, -6).
  final Offset offset;

  /// The alignment of the badge on the parent widget.
  /// Defaults to [Alignment.topRight].
  final Alignment alignment;

  /// Creates a [DotBadgeOptions] with the given configuration.
  ///
  /// By default, creates a visible badge with error color at small size.
  const DotBadgeOptions({
    this.isVisible = true,
    this.count,
    this.maxCount = 99,
    this.color = SemanticColor.error,
    this.size = DotBadgeSize.small,
    this.isAnimating = false,
    this.offset = const Offset(6, -6),
    this.alignment = Alignment.topRight,
  });

  /// Creates options for a simple dot badge without a counter.
  const DotBadgeOptions.dot({
    this.isVisible = true,
    this.color = SemanticColor.error,
    this.size = DotBadgeSize.small,
    this.isAnimating = false,
    this.offset = const Offset(4, -4),
    this.alignment = Alignment.topRight,
  }) : count = null,
       maxCount = 99;

  /// Creates options for a counter badge with a number.
  const DotBadgeOptions.counter({
    required int this.count,
    this.maxCount = 99,
    this.isVisible = true,
    this.color = SemanticColor.error,
    this.size = DotBadgeSize.small,
    this.isAnimating = false,
    this.offset = const Offset(6, -6),
    this.alignment = Alignment.topRight,
  });

  /// Determines the display mode based on [count] value.
  DotBadgeMode get mode =>
      (count != null && count! > 0) ? DotBadgeMode.counter : DotBadgeMode.dot;

  /// Returns the formatted count string (e.g., "5" or "99+").
  String get displayCount => switch (count) {
    null => '',
    <= 0 => '',
    _ when count! > maxCount => '$maxCount+',
    _ => count.toString(),
  };

  /// Creates a copy of this options with the given fields replaced.
  DotBadgeOptions copyWith({
    bool? isVisible,
    int? count,
    int? maxCount,
    SemanticColor? color,
    DotBadgeSize? size,
    bool? isAnimating,
    Offset? offset,
    Alignment? alignment,
  }) => DotBadgeOptions(
    isVisible: isVisible ?? this.isVisible,
    count: count ?? this.count,
    maxCount: maxCount ?? this.maxCount,
    color: color ?? this.color,
    size: size ?? this.size,
    isAnimating: isAnimating ?? this.isAnimating,
    offset: offset ?? this.offset,
    alignment: alignment ?? this.alignment,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DotBadgeOptions &&
          runtimeType == other.runtimeType &&
          isVisible == other.isVisible &&
          count == other.count &&
          maxCount == other.maxCount &&
          color == other.color &&
          size == other.size &&
          isAnimating == other.isAnimating &&
          offset == other.offset &&
          alignment == other.alignment;

  @override
  int get hashCode =>
      isVisible.hashCode ^
      count.hashCode ^
      maxCount.hashCode ^
      color.hashCode ^
      size.hashCode ^
      isAnimating.hashCode ^
      offset.hashCode ^
      alignment.hashCode;
}
