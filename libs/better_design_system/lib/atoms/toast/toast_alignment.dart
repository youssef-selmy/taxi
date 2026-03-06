import 'package:flutter/widgets.dart';

enum ToastAlignment {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight;

  Alignment toAlignment() => switch (this) {
    ToastAlignment.topLeft => Alignment.topLeft,
    ToastAlignment.topCenter => Alignment.topCenter,
    ToastAlignment.topRight => Alignment.topRight,
    ToastAlignment.bottomLeft => Alignment.bottomLeft,
    ToastAlignment.bottomCenter => Alignment.bottomCenter,
    ToastAlignment.bottomRight => Alignment.bottomRight,
  };
}
