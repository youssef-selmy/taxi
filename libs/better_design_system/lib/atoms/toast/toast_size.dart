import 'package:flutter/cupertino.dart';

/// Enum that defines different sizes for the toast widget.
///
/// The size of the toast affects its padding, border radius, icon size, and icon padding.
///
/// - [small]: Represents a small toast with compact layout and smaller icon size.
/// - [medium]: Represents a medium toast with a balanced layout and moderate icon size.
/// - [large]: Represents a large toast with spacious layout and larger icon size.
enum ToastSize {
  small, // Small size toast with minimal layout, smaller icon size, and tighter padding.
  medium, // Medium size toast with a balanced layout, moderate icon size, and standard padding.
  large; // Large size toast with spacious layout, larger icon size, and extra padding.

  /// Returns the padding for the toast based on its size.
  /// - Small and medium: 8 pixels of padding.
  /// - Large: 12 pixels of padding.
  EdgeInsetsGeometry get padding {
    switch (this) {
      case ToastSize.small:
      case ToastSize.medium:
        return const EdgeInsets.all(8);
      case ToastSize.large:
        return const EdgeInsets.all(12);
    }
  }

  /// Returns the border radius for the toast based on its size.
  /// - Small and medium: 8 pixels of border radius.
  /// - Large: 12 pixels of border radius.
  BorderRadiusGeometry get borderRadius {
    switch (this) {
      case ToastSize.small:
      case ToastSize.medium:
        return BorderRadius.circular(8);
      case ToastSize.large:
        return BorderRadius.circular(12);
    }
  }

  /// Returns the icon size for the toast based on its size.
  /// - Small and medium: 16 pixels for the icon.
  /// - Large: 20 pixels for the icon.
  double get iconSize {
    switch (this) {
      case ToastSize.small:
      case ToastSize.medium:
        return 16;
      case ToastSize.large:
        return 20;
    }
  }

  /// Returns the border radius for the icon inside the toast based on its size.
  /// - Small and medium: 4 pixels of border radius for the icon.
  /// - Large: 6 pixels of border radius for the icon.
  BorderRadiusGeometry get iconBorderRadius {
    switch (this) {
      case ToastSize.small:
      case ToastSize.medium:
        return BorderRadius.circular(4);
      case ToastSize.large:
        return BorderRadius.circular(6);
    }
  }

  /// Returns the padding for the icon inside the toast based on its size.
  /// - Small: 2 pixels of padding for the icon.
  /// - Medium and large: 4 pixels of padding for the icon.
  EdgeInsetsGeometry get iconPadding {
    switch (this) {
      case ToastSize.small:
        return const EdgeInsets.all(2);
      case ToastSize.medium:
      case ToastSize.large:
        return const EdgeInsets.all(4);
    }
  }
}
