import 'package:flutter/widgets.dart';
import 'better_strings.dart';

/// An InheritedWidget that provides [BetterStringsData] to the widget tree.
///
/// This widget should be placed near the root of your application to make
/// strings available throughout the widget tree via `context.strings`.
///
/// Example:
/// ```dart
/// MaterialApp(
///   home: BetterStrings(
///     child: MyApp(),
///   ),
/// );
///
/// // Or with custom strings
/// MaterialApp(
///   home: BetterStrings(
///     data: CustomStrings(),
///     child: MyApp(),
///   ),
/// );
/// ```
class BetterStrings extends InheritedWidget {
  /// Creates a [BetterStrings] widget.
  ///
  /// The [data] parameter provides the string translations. If not specified,
  /// default English strings will be used.
  const BetterStrings({
    super.key,
    this.data = const BetterStringsData(),
    required super.child,
  });

  /// The string data provided by this widget.
  final BetterStringsData data;

  /// Retrieves the [BetterStrings] from the closest ancestor in the widget tree.
  ///
  /// Returns null if no [BetterStrings] ancestor is found.
  ///
  /// Example:
  /// ```dart
  /// final strings = BetterStrings.of(context);
  /// if (strings != null) {
  ///   print(strings.data.profile);
  /// }
  /// ```
  static BetterStrings? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BetterStrings>();
  }

  @override
  bool updateShouldNotify(BetterStrings oldWidget) {
    return data != oldWidget.data;
  }
}
