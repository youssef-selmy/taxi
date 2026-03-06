part of 'extensions.dart';

extension WidgetListX on List<Widget> {
  List<Widget> separated({required Widget separator}) {
    final widgets = <Widget>[];
    for (var i = 0; i < length; i++) {
      widgets.add(this[i]);
      if (i != length - 1) {
        widgets.add(separator);
      }
    }
    return widgets;
  }

  Wrap wrapWithCommas() =>
      Wrap(children: separated(separator: const Text(', ')));
}
