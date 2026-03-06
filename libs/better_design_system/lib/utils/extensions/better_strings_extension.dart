import 'package:flutter/widgets.dart';
import '../../config/better_strings.dart';
import '../../config/better_strings_widget.dart';

/// Extension on [BuildContext] to provide easy access to [BetterStringsData].
///
/// This extension adds a `strings` getter that retrieves strings from the
/// nearest [BetterStrings] ancestor widget, or falls back to default English
/// strings if no ancestor is found.
///
/// Example:
/// ```dart
/// Text(context.strings.profile)
/// Text(context.strings.durationInMinutes(5))
/// ```
extension BetterStringsContext on BuildContext {
  /// Returns the [BetterStringsData] from the widget tree, or default English
  /// strings if no [BetterStrings] widget is found.
  BetterStringsData get strings =>
      BetterStrings.of(this)?.data ?? const BetterStringsData();
}
