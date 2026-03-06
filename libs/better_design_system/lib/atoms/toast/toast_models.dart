// toast_models.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'toast.dart';

/// Small options container to customize per-show call.
class ToastOptions {
  final Duration? duration;
  final AlignmentGeometry? alignment;
  final List<Widget>? actions;

  const ToastOptions({this.duration, this.alignment, this.actions});
}

/// Internal representation of a shown toast.
class ToastInfo {
  ToastInfo({
    required this.id,
    required this.toast,
    required this.controller,
    this.visible = true,
    this.temporarelyHide = false,
    this.options = const ToastOptions(),
  });

  final Object id;
  final AppToast toast;
  final AnimationController controller;
  bool visible;
  bool temporarelyHide;
  Timer? timer;
  ToastOptions options;
}
