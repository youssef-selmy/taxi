import 'package:flutter/material.dart';

class ScrollableContainer extends StatelessWidget {
  final Widget child;
  final double maxHeight;

  const ScrollableContainer({
    super.key,
    required this.child,
    this.maxHeight = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use the smaller value between parent's maxHeight and provided maxHeight.
        final containerHeight = constraints.maxHeight < maxHeight
            ? constraints.maxHeight
            : maxHeight;
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: containerHeight),
          child: SingleChildScrollView(child: child),
        );
      },
    );
  }
}
