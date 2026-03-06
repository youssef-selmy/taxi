/// Enum representing the predefined sizes for the linear progress bar.
///
/// - [small]: Represents the small size of the progress bar with a value of 6.
/// - [medium]: Represents the medium size of the progress bar with a value of 8.
enum LinearProgressBarSize {
  small(6), // Small size with a value of 6
  medium(8); // Medium size with a value of 8

  final double value;
  const LinearProgressBarSize(this.value);
}
