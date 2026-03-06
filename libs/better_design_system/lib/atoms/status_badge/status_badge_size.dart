/// This enum specifies different size options for displaying a status badge.
///
/// - `extraSmall`: An extra small-sized status badge (4 pixels).
/// - `small`: A small-sized status badge (6 pixels).
/// - `regularSmall`: A regular small-sized status badge (8 pixels).
/// - `medium`: A medium-sized status badge (10 pixels).
/// - `large`: A large-sized status badge (12 pixels).
enum StatusBadgeSize {
  extraSmall(4),
  small(6),
  regularSmall(8),
  medium(10),
  large(12);

  final double value;
  const StatusBadgeSize(this.value);
}
