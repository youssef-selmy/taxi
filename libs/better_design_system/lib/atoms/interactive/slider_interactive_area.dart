import 'dart:math' as math;
import 'package:flutter/material.dart';

typedef BetterSliderInteractiveArea = AppSliderInteractiveArea;

class AppSliderInteractiveArea extends StatelessWidget {
  // Single knob
  final double? valuePercent;
  final Widget? knob;
  final double? knobWidth;

  // Range knobs
  final double? startValuePercent;
  final double? endValuePercent;
  final Widget? startKnob;
  final Widget? endKnob;
  final double? startKnobWidth;
  final double? endKnobWidth;

  // Track & behavior
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final double trackHeight;
  final bool isDisabled;

  /// If this was 0 before (because it used to be measured via LayoutBuilder),
  /// we now guard with a minHeight so the track can render.
  final double maxElementHeight;

  // Pointer callbacks (dx in local coords)
  final ValueChanged<double> onTapDown;
  final ValueChanged<double> onDragStart;
  final ValueChanged<double> onDragUpdate;
  final VoidCallback onDragEnd;

  final TextDirection textDirection;
  final bool isRange;

  const AppSliderInteractiveArea({
    super.key,
    // single
    this.valuePercent,
    this.knob,
    this.knobWidth,
    // range
    this.startValuePercent,
    this.endValuePercent,
    this.startKnob,
    this.endKnob,
    this.startKnobWidth,
    this.endKnobWidth,
    // track & behavior
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.trackHeight,
    required this.isDisabled,
    required this.maxElementHeight,
    required this.onTapDown,
    required this.onDragStart,
    required this.onDragUpdate,
    required this.onDragEnd,
    required this.textDirection,
    this.isRange = false,
  });

  double _alignX(double percent) {
    final isLTR = textDirection == TextDirection.ltr;
    final p = percent.clamp(0.0, 1.0);
    final logical = isLTR ? p : (1.0 - p);
    return logical * 2.0 - 1.0;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveMinHeight = math.max(
      trackHeight,
      (maxElementHeight > 0 ? maxElementHeight : 0.0),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: effectiveMinHeight),
      child: SizedBox(
        height: maxElementHeight <= 0 ? null : maxElementHeight,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) {
            if (!isDisabled) onTapDown(d.localPosition.dx);
          },
          onHorizontalDragStart: (d) {
            if (!isDisabled) onDragStart(d.localPosition.dx);
          },
          onHorizontalDragUpdate: (d) {
            if (!isDisabled) onDragUpdate(d.localPosition.dx);
          },
          onHorizontalDragEnd: (_) {
            if (!isDisabled) onDragEnd();
          },
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              // ==== TRACK fills the available width ====
              Positioned.fill(
                child: CustomPaint(
                  painter: isRange
                      ? _SliderRangeTrackPainter(
                          startValuePercent: (startValuePercent ?? 0).clamp(
                            0.0,
                            1.0,
                          ),
                          endValuePercent: (endValuePercent ?? 0).clamp(
                            0.0,
                            1.0,
                          ),
                          activeTrackColor: activeTrackColor,
                          inactiveTrackColor: inactiveTrackColor,
                          trackHeight: trackHeight,
                          textDirection: textDirection,
                        )
                      : _SliderTrackPainter(
                          valuePercent: (valuePercent ?? 0).clamp(0.0, 1.0),
                          activeTrackColor: activeTrackColor,
                          inactiveTrackColor: inactiveTrackColor,
                          trackHeight: trackHeight,
                          textDirection: textDirection,
                        ),
                ),
              ),

              // ==== KNOBS ====
              if (isRange) ...[
                Align(
                  alignment: Alignment(_alignX(startValuePercent ?? 0), 0),
                  child: SizedBox(
                    width: startKnobWidth,
                    child: startKnob ?? const SizedBox.shrink(),
                  ),
                ),
                Align(
                  alignment: Alignment(_alignX(endValuePercent ?? 0), 0),
                  child: SizedBox(
                    width: endKnobWidth,
                    child: endKnob ?? const SizedBox.shrink(),
                  ),
                ),
              ] else ...[
                Align(
                  alignment: Alignment(_alignX(valuePercent ?? 0), 0),
                  child: SizedBox(
                    width: knobWidth,
                    child: knob ?? const SizedBox.shrink(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SliderTrackPainter extends CustomPainter {
  final double valuePercent; // [0..1]
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final double trackHeight;
  final TextDirection textDirection;

  _SliderTrackPainter({
    required this.valuePercent,
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.trackHeight,
    required this.textDirection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final isLTR = textDirection == TextDirection.ltr;
    final r = Radius.circular(trackHeight / 2);
    final top = (size.height - trackHeight) / 2;

    // Full inactive track (spans full width)
    final full = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, top, size.width, trackHeight),
      topLeft: r,
      bottomLeft: r,
      topRight: r,
      bottomRight: r,
    );
    canvas.drawRRect(full, Paint()..color = inactiveTrackColor);

    // Active portion
    final w = (valuePercent.clamp(0.0, 1.0)) * size.width;
    if (w <= 0) return;

    if (isLTR) {
      final rr = RRect.fromRectAndCorners(
        Rect.fromLTWH(0, top, w, trackHeight),
        topLeft: r,
        bottomLeft: r,
        topRight: w >= size.width - 0.5 ? r : Radius.zero,
        bottomRight: w >= size.width - 0.5 ? r : Radius.zero,
      );
      canvas.drawRRect(rr, Paint()..color = activeTrackColor);
    } else {
      final left = size.width - w;
      final rr = RRect.fromRectAndCorners(
        Rect.fromLTWH(left, top, w, trackHeight),
        topRight: r,
        bottomRight: r,
        topLeft: w >= size.width - 0.5 ? r : Radius.zero,
        bottomLeft: w >= size.width - 0.5 ? r : Radius.zero,
      );
      canvas.drawRRect(rr, Paint()..color = activeTrackColor);
    }
  }

  @override
  bool shouldRepaint(_SliderTrackPainter old) =>
      old.valuePercent != valuePercent ||
      old.activeTrackColor != activeTrackColor ||
      old.inactiveTrackColor != inactiveTrackColor ||
      old.trackHeight != trackHeight ||
      old.textDirection != textDirection;
}

class _SliderRangeTrackPainter extends CustomPainter {
  final double startValuePercent; // [0..1]
  final double endValuePercent; // [0..1]
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final double trackHeight;
  final TextDirection textDirection;

  _SliderRangeTrackPainter({
    required this.startValuePercent,
    required this.endValuePercent,
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.trackHeight,
    required this.textDirection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final isLTR = textDirection == TextDirection.ltr;
    final r = Radius.circular(trackHeight / 2);
    final top = (size.height - trackHeight) / 2;

    // Full inactive track
    final full = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, top, size.width, trackHeight),
      topLeft: r,
      bottomLeft: r,
      topRight: r,
      bottomRight: r,
    );
    canvas.drawRRect(full, Paint()..color = inactiveTrackColor);

    // Active range
    final sPx = (startValuePercent.clamp(0.0, 1.0)) * size.width;
    final ePx = (endValuePercent.clamp(0.0, 1.0)) * size.width;

    double leftPx, rightPx;
    if (isLTR) {
      leftPx = math.min(sPx, ePx);
      rightPx = math.max(sPx, ePx);
    } else {
      // Mirror in RTL
      final ms = size.width - sPx;
      final me = size.width - ePx;
      leftPx = math.min(ms, me);
      rightPx = math.max(ms, me);
    }

    final w = (rightPx - leftPx).clamp(0.0, size.width);
    if (w <= 0) return;

    final rr = RRect.fromRectAndCorners(
      Rect.fromLTWH(leftPx, top, w, trackHeight),
      topLeft: leftPx <= 0.5 ? r : Radius.zero,
      bottomLeft: leftPx <= 0.5 ? r : Radius.zero,
      topRight: rightPx >= size.width - 0.5 ? r : Radius.zero,
      bottomRight: rightPx >= size.width - 0.5 ? r : Radius.zero,
    );
    canvas.drawRRect(rr, Paint()..color = activeTrackColor);
  }

  @override
  bool shouldRepaint(_SliderRangeTrackPainter old) =>
      old.startValuePercent != startValuePercent ||
      old.endValuePercent != endValuePercent ||
      old.activeTrackColor != activeTrackColor ||
      old.inactiveTrackColor != inactiveTrackColor ||
      old.trackHeight != trackHeight ||
      old.textDirection != textDirection;
}
