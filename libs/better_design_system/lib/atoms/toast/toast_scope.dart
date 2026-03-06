// toast_scope.dart
import 'dart:async';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'toast.dart';
import 'toast_alignment.dart';
import 'toast_models.dart';

/// Wrap your app with ToastScope to enable overlay toasts.
///
/// Toasts will stack in collapsed mode by default, and expand when hovered.
///
/// Example:
/// ```dart
/// ToastScope(child: MyApp());
/// ```
class ToastScope extends StatefulWidget {
  const ToastScope({
    super.key,
    required this.child,
    this.visibleToastsAmount = 3,
    this.alignment = ToastAlignment.bottomRight,
    this.padding = const EdgeInsets.all(16),
    this.maxWidth = 420,
    this.maxHeight = 100,
    this.expandedGap = 8.0,
    this.collapsedGap = 16.0,
    this.scaleFactor = 0.05,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = const Cubic(0.215, 0.61, 0.355, 1),
    this.isExpanded = false,
  });

  final Widget child;

  /// Maximum visible toasts at once.
  final int visibleToastsAmount;

  /// Where the toast stack will be aligned.
  final ToastAlignment alignment;

  /// Padding around the overlay area.
  final EdgeInsetsGeometry padding;

  /// Max width for toasts.
  final double maxWidth;

  /// Max Height for toasts.
  final double maxHeight;

  final bool isExpanded;

  /// Gap between toasts in expanded state.
  final double expandedGap;

  /// Gap between toasts in collapsed state.
  final double collapsedGap;

  /// Scale factor for stacking effect.
  /// Newer toasts are scale 1.0, older toasts are progressively smaller.
  final double scaleFactor;

  /// Animation duration for expand/collapse and toast enter/exit.
  final Duration animationDuration;

  /// Animation curve for expand/collapse and toast enter/exit.
  final Curve animationCurve;

  static ToastScopeState of(BuildContext context) {
    final state = context.findAncestorStateOfType<ToastScopeState>();
    if (state == null) {
      throw FlutterError(
        'ToastScope not found in widget tree. Wrap your app with ToastScope.',
      );
    }
    return state;
  }

  @override
  State<ToastScope> createState() => ToastScopeState();
}

class ToastScopeState extends State<ToastScope> with TickerProviderStateMixin {
  final _toasts = <ToastInfo>[];
  final _temporarelyHidden = <ToastInfo>[];
  final ValueNotifier<bool> hovered = ValueNotifier(false);

  late final AnimationController _expandController;
  late final Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: widget.animationCurve,
    );
    hovered.addListener(_onHoverChanged);
  }

  @override
  void dispose() {
    for (final t in _toasts) {
      t.timer?.cancel();
      t.controller.dispose();
    }
    for (final t in _temporarelyHidden) {
      t.timer?.cancel();
      t.controller.dispose();
    }
    _expandController.dispose();
    hovered.removeListener(_onHoverChanged);
    hovered.dispose();
    super.dispose();
  }

  void _onHoverChanged() {
    final isHovered = hovered.value;
    if (isHovered) {
      _expandController.forward();
      // Pause timers
      for (final t in _toasts) {
        t.timer?.cancel();
        t.timer = null;
      }
    } else {
      _expandController.reverse();
      // Resume timers
      for (final t in _toasts) {
        final dur = t.options.duration ?? const Duration(seconds: 4);
        t.timer = Timer(dur, () => hide(t.id));
      }
    }
  }

  /// Show a toast. Returns the id used.
  Object show(AppToast toast, {ToastOptions? options, bool append = true}) {
    final opts = options ?? const ToastOptions();
    final id = toast.key ?? UniqueKey();
    final controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    final toastInfo = ToastInfo(
      id: id,
      toast: toast,
      controller: controller,
      options: opts,
      visible: true,
    );

    // Hide excess toasts synchronously before adding new one
    while (_toasts.length >= widget.visibleToastsAmount) {
      final first = _toasts.first;
      first.timer?.cancel();
      first.timer = null;
      first.controller.stop();
      first.temporarelyHide = true;
      _toasts.removeAt(0);
      _temporarelyHidden.add(first);
    }

    setState(() {
      if (append) {
        _toasts.add(toastInfo);
      } else {
        _toasts.insert(0, toastInfo);
      }
    });

    controller.forward();

    // Only start timer if not currently hovered
    if (!hovered.value) {
      final effectiveDuration = opts.duration ?? const Duration(seconds: 4);
      toastInfo.timer = Timer(effectiveDuration, () => hide(id));
    }

    return id;
  }

  Future<void> hide(Object? id) async {
    final info = _toasts.firstWhereOrNull((t) => t.id == id);
    if (info == null) return;
    setState(() => info.visible = false);
    info.timer?.cancel();
    info.timer = null;
    await info.controller.reverse();
    info.controller.dispose();
    _toasts.remove(info);

    // Restore hidden toasts if we have room
    while (_temporarelyHidden.isNotEmpty &&
        _toasts.length < widget.visibleToastsAmount) {
      final hidden = _temporarelyHidden.removeLast();
      hidden.controller.dispose();
      _restoreToast(hidden);
    }
    setState(() {});
  }

  void _restoreToast(ToastInfo hidden) {
    final controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    final restoredInfo = ToastInfo(
      id: hidden.id,
      toast: hidden.toast,
      controller: controller,
      options: hidden.options,
      visible: true,
    );

    _toasts.insert(0, restoredInfo);
    controller.forward();

    // Only start timer if not currently hovered
    if (!hovered.value) {
      final effectiveDuration =
          hidden.options.duration ?? const Duration(seconds: 4);
      restoredInfo.timer = Timer(effectiveDuration, () => hide(hidden.id));
    }
  }

  Future<void> hideTemporarely(Object? id) async {
    final info = _toasts.firstWhereOrNull((t) => t.id == id);
    if (info == null) return;
    info.timer?.cancel();
    info.timer = null;
    await info.controller.reverse();
    setState(() {
      _toasts.remove(info);
      info.temporarelyHide = true;
      _temporarelyHidden.add(info);
    });
  }

  void onEnter(PointerEnterEvent e) {
    if (hovered.value) return;
    hovered.value = true;
  }

  void onExit(PointerExitEvent e) {
    if (!hovered.value) return;
    hovered.value = false;
  }

  double _calculateMaxHeight() {
    final count = math.max(1, _toasts.length);
    final toastsHeight = widget.maxHeight * count;
    final gapsHeight = widget.expandedGap * (count - 1);
    return toastsHeight + gapsHeight;
  }

  @override
  Widget build(BuildContext context) {
    final alignment = widget.alignment.toAlignment();
    return _ToastScopeInherited(
      state: this,
      child: Stack(
        alignment: alignment,
        children: [
          widget.child,
          Padding(
            padding: widget.padding,
            child: Align(
              alignment: alignment,
              child: MouseRegion(
                onEnter: onEnter,
                onExit: onExit,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: widget.isExpanded
                        ? double.infinity
                        : widget.maxWidth,
                    maxHeight: _calculateMaxHeight(),
                  ),
                  child: AnimatedBuilder(
                    animation: _expandAnimation,
                    builder: (context, _) {
                      return _ToastStackLayout(
                        animation: _expandAnimation.value,
                        collapsedGap: widget.collapsedGap,
                        expandedGap: widget.expandedGap,
                        alignment: alignment,
                        children: _toasts.mapIndexed((index, toastInfo) {
                          final scaleDelta =
                              widget.scaleFactor * (_toasts.length - 1 - index);
                          final scaleX = 1.0 - scaleDelta;

                          return _AnimatedToastWrapper(
                            key: ValueKey(toastInfo.id),
                            expandAnimation: _expandAnimation,
                            toastController: toastInfo.controller,
                            scaleX: scaleX,
                            alignment: Alignment.bottomCenter,
                            child: toastInfo.toast,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToastScopeInherited extends InheritedWidget {
  const _ToastScopeInherited({required super.child, required this.state});

  final ToastScopeState state;

  @override
  bool updateShouldNotify(covariant _ToastScopeInherited oldWidget) =>
      state != oldWidget.state;
}

/// Animated wrapper for each toast that handles scale and fade animations.
class _AnimatedToastWrapper extends StatefulWidget {
  const _AnimatedToastWrapper({
    super.key,
    required this.expandAnimation,
    required this.toastController,
    required this.scaleX,
    required this.alignment,
    required this.child,
  });

  final Animation<double> expandAnimation;
  final AnimationController toastController;
  final double scaleX;
  final AlignmentGeometry alignment;
  final Widget child;

  @override
  State<_AnimatedToastWrapper> createState() => _AnimatedToastWrapperState();
}

class _AnimatedToastWrapperState extends State<_AnimatedToastWrapper> {
  bool _hasCompletedEntrance = false;

  @override
  void initState() {
    super.initState();
    widget.toastController.addStatusListener(_onAnimationStatusChanged);
  }

  @override
  void dispose() {
    widget.toastController.removeStatusListener(_onAnimationStatusChanged);
    super.dispose();
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() => _hasCompletedEntrance = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        widget.expandAnimation,
        widget.toastController,
      ]),
      builder: (context, child) {
        final expandValue = widget.expandAnimation.value;
        final toastValue = widget.toastController.value;

        // Animate scale from collapsed (scaleX) to expanded (1.0)
        final currentScale =
            widget.scaleX + (1.0 - widget.scaleX) * expandValue;

        // Slide animation for enter/exit
        final slideOffset = _getSlideOffset(widget.alignment);
        final slideX = slideOffset.dx * (1.0 - toastValue);
        final slideY = slideOffset.dy * (1.0 - toastValue);

        // In dark mode: no fade on entrance, fade on exit
        // In light mode: fade on both entrance and exit
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final opacity = isDark
            ? (_hasCompletedEntrance ? toastValue.clamp(0.0, 1.0) : 1.0)
            : toastValue.clamp(0.0, 1.0);

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(slideX * 100, slideY * 100),
            child: Transform.scale(
              scale: currentScale,
              alignment: _getScaleAlignment(widget.alignment),
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }

  Offset _getSlideOffset(AlignmentGeometry alignment) => switch (alignment) {
    Alignment.bottomRight ||
    Alignment.centerRight ||
    Alignment.topRight => const Offset(1.0, 0.0),
    Alignment.bottomLeft ||
    Alignment.centerLeft ||
    Alignment.topLeft => const Offset(-1.0, 0.0),
    Alignment.bottomCenter => const Offset(0.0, 1.0),
    Alignment.topCenter => const Offset(0.0, -1.0),
    _ => const Offset(0.0, 1.0),
  };

  Alignment _getScaleAlignment(AlignmentGeometry alignment) =>
      switch (alignment) {
        Alignment.bottomRight ||
        Alignment.centerRight ||
        Alignment.topRight => Alignment.centerRight,
        Alignment.bottomLeft ||
        Alignment.centerLeft ||
        Alignment.topLeft => Alignment.centerLeft,
        _ => Alignment.center,
      };
}

/// Custom layout widget that stacks toasts when collapsed
/// and arranges them in a column when expanded (on hover).
class _ToastStackLayout extends MultiChildRenderObjectWidget {
  const _ToastStackLayout({
    required this.animation,
    required this.collapsedGap,
    required this.expandedGap,
    required this.alignment,
    required super.children,
  });

  final double animation;
  final double collapsedGap;
  final double expandedGap;
  final AlignmentGeometry alignment;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderToastStack(
      animation: animation,
      collapsedGap: collapsedGap,
      expandedGap: expandedGap,
      alignment: alignment,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderToastStack renderObject,
  ) {
    renderObject
      ..animation = animation
      ..collapsedGap = collapsedGap
      ..expandedGap = expandedGap
      ..alignment = alignment;
  }
}

class _ToastStackParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderToastStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ToastStackParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ToastStackParentData> {
  _RenderToastStack({
    required double animation,
    required double collapsedGap,
    required double expandedGap,
    required AlignmentGeometry alignment,
  }) : _animation = animation,
       _collapsedGap = collapsedGap,
       _expandedGap = expandedGap,
       _alignment = alignment;

  double _animation;
  double get animation => _animation;
  set animation(double value) {
    if (_animation == value) return;
    _animation = value;
    markNeedsLayout();
  }

  double _collapsedGap;
  double get collapsedGap => _collapsedGap;
  set collapsedGap(double value) {
    if (_collapsedGap == value) return;
    _collapsedGap = value;
    markNeedsLayout();
  }

  double _expandedGap;
  double get expandedGap => _expandedGap;
  set expandedGap(double value) {
    if (_expandedGap == value) return;
    _expandedGap = value;
    markNeedsLayout();
  }

  AlignmentGeometry _alignment;
  AlignmentGeometry get alignment => _alignment;
  set alignment(AlignmentGeometry value) {
    if (_alignment == value) return;
    _alignment = value;
    markNeedsLayout();
  }

  bool get _isTopAligned =>
      alignment == Alignment.topLeft ||
      alignment == Alignment.topCenter ||
      alignment == Alignment.topRight;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _ToastStackParentData) {
      child.parentData = _ToastStackParentData();
    }
  }

  @override
  void performLayout() {
    if (childCount == 0) {
      size = constraints.smallest;
      return;
    }

    // Step 1: Measure all children
    final heights = <double>[];
    double maxWidth = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      child.layout(constraints.loosen(), parentUsesSize: true);
      heights.add(child.size.height);
      maxWidth = math.max(maxWidth, child.size.width);
      child = childAfter(child);
    }

    final numChildren = heights.length;

    // Step 2: Calculate total heights for both states
    final totalHeightExpanded =
        heights.fold<double>(0, (a, b) => a + b) +
        expandedGap * (numChildren - 1);

    final totalHeightCollapsed =
        heights.last + (numChildren - 1) * collapsedGap;

    // Interpolate between collapsed and expanded height
    final currentHeight =
        totalHeightCollapsed +
        (totalHeightExpanded - totalHeightCollapsed) * animation;

    // Step 3: Position children
    // For bottom-aligned: newest toast (last in list) stays at bottom of container
    // Older toasts stack ABOVE it. When expanded, they spread upward.
    // Key: position relative to container bottom, not top
    child = firstChild;
    int i = 0;
    while (child != null) {
      final parentData = child.parentData! as _ToastStackParentData;
      double targetY;

      if (_isTopAligned) {
        // Top-aligned: newest toast (last) at top (y=0)
        // Older toasts stack below with collapsedGap offset
        final collapsedY = (numChildren - 1 - i) * collapsedGap;
        final expandedY =
            heights
                .sublist(i + 1, numChildren)
                .fold<double>(0, (a, b) => a + b) +
            expandedGap * (numChildren - 1 - i);
        targetY = collapsedY + (expandedY - collapsedY) * animation;
      } else {
        // Bottom-aligned: newest toast (last in list) at bottom of container
        // Container is sized to currentHeight, bottom is at y = currentHeight
        // Newest toast: bottom edge at y = currentHeight, so top at y = currentHeight - height
        // Older toasts: stack above (smaller y values)

        final reverseIndex =
            numChildren - 1 - i; // 0 for newest (last), increases for older

        // Collapsed: newest at bottom, older ones peek above with collapsedGap
        // All positioned relative to the container's bottom
        final collapsedY =
            currentHeight - heights[i] - reverseIndex * collapsedGap;

        // Expanded: spread upward from bottom
        // Newest (reverseIndex=0) at bottom: y = currentHeight - heights[last]
        // Older ones above with expandedGap between them
        // Calculate: sum heights of toasts below (indices > i) plus gaps
        final heightsBelow = heights
            .sublist(i + 1)
            .fold<double>(0, (a, b) => a + b);
        final gapsBelow = (numChildren - 1 - i > 0)
            ? expandedGap * reverseIndex
            : 0.0;
        final expandedY = currentHeight - heights[i] - heightsBelow - gapsBelow;

        targetY = collapsedY + (expandedY - collapsedY) * animation;
      }

      targetY = math.max(0, targetY);
      parentData.offset = Offset(0, targetY);

      child = childAfter(child);
      i++;
    }

    size = constraints.constrain(Size(maxWidth, currentHeight));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
