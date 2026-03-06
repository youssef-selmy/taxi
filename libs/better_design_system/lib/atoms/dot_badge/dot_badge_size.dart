import 'package:flutter/material.dart';

/// Defines the size variations for [BetterDotBadge].
///
/// Each size includes properties for both dot mode (simple circle)
/// and counter mode (displaying numbers).
enum DotBadgeSize {
  /// Extra small size: 4px dot, 14px min counter width, 9px font
  xsmall(4, 14, 9),

  /// Small size: 8px dot, 16px min counter width, 10px font
  small(8, 16, 10),

  /// Medium size: 10px dot, 18px min counter width, 11px font
  medium(10, 18, 11),

  /// Large size: 12px dot, 20px min counter width, 12px font
  large(12, 20, 12);

  /// The diameter of the dot in dot mode.
  final double dotValue;

  /// The minimum width of the badge in counter mode.
  final double minCounterWidth;

  /// The font size for counter text.
  final double fontSize;

  const DotBadgeSize(this.dotValue, this.minCounterWidth, this.fontSize);

  /// Alias for [dotValue] for backward compatibility.
  double get value => dotValue;

  /// The padding applied in counter mode.
  EdgeInsets get counterPadding => switch (this) {
    DotBadgeSize.xsmall => const EdgeInsets.symmetric(
      horizontal: 3,
      vertical: 1,
    ),
    DotBadgeSize.small => const EdgeInsets.symmetric(
      horizontal: 4,
      vertical: 2,
    ),
    DotBadgeSize.medium => const EdgeInsets.symmetric(
      horizontal: 5,
      vertical: 2,
    ),
    DotBadgeSize.large => const EdgeInsets.symmetric(
      horizontal: 6,
      vertical: 3,
    ),
  };

  /// The height of the badge in counter mode.
  double get counterHeight => switch (this) {
    DotBadgeSize.xsmall => 14,
    DotBadgeSize.small => 16,
    DotBadgeSize.medium => 18,
    DotBadgeSize.large => 20,
  };
}
