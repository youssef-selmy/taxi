/// Defines predefined sizes for the circular progress bar.
///
/// - [size24px]: Represents a 24px size for the circular progress bar.
/// - [size32px]: Represents a 32px size for the circular progress bar.
/// - [size40px]: Represents a 40px size for the circular progress bar.
/// - [size48px]: Represents a 48px size for the circular progress bar.
/// - [size52px]: Represents a 52px size for the circular progress bar.
/// - [size64px]: Represents a 64px size for the circular progress bar.
/// - [size72px]: Represents a 72px size for the circular progress bar.
enum CircularProgressBarSize {
  size24px(24),

  /// Represents a 24px circular progress bar.
  size32px(32),

  /// Represents a 32px circular progress bar.
  size40px(40),

  /// Represents a 40px circular progress bar.
  size48px(48),

  /// Represents a 48px circular progress bar.
  size52px(52),

  /// Represents a 52px circular progress bar.
  size64px(64),

  /// Represents a 64px circular progress bar.
  size72px(72);

  /// Represents a 72px circular progress bar.

  /// Returns the icon size based on the circular progress bar size.
  /// This is used for determining the size of the icon inside the progress bar.
  double get iconSize {
    switch (this) {
      case size24px:
        return 10;

      /// Icon size for 24px progress bar.
      case size32px:
        return 12;

      /// Icon size for 32px progress bar.
      case size40px:
      case size48px:
      case size52px:
        return 16;

      /// Icon size for 40px, 48px, and 52px progress bars.
      case size64px:
      case size72px:
        return 20;

      /// Icon size for 64px and 72px progress bars.
    }
  }

  final double value;

  const CircularProgressBarSize(this.value);
}
