import 'dart:math' as math;
import 'package:better_design_system/atoms/input_fields/base_components/input_label.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/atoms/display/app_min_max.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system/atoms/interactive/ring_knob.dart';
import 'package:better_design_system/atoms/interactive/circle_knob.dart';
import 'package:better_design_system/atoms/interactive/rectangle_knob.dart';
import 'package:better_design_system/molecules/slider/slider_knob_type.dart';
import 'package:better_design_system/molecules/tooltip/tooltip.dart';
import 'package:better_design_system/atoms/interactive/slider_interactive_area.dart';

export 'package:better_design_system/molecules/slider/slider_knob_type.dart';
export 'package:better_design_system/molecules/tooltip/tooltip.dart';

typedef BetterSlider = AppSlider;

class AppSlider extends StatefulWidget {
  final String? label;
  final String? sublabel;
  final double value;
  final double minValue;
  final double maxValue;
  final double? stepSize;
  final ValueChanged<double> onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final bool isDisabled;
  final Color? activeTrackColorOverride;
  final String Function(double value)? valueTextFormatter;
  final SliderKnobType knobType;
  final bool showValueTooltip;
  final TooltipAlignment valueTooltipAlignment;
  final SemanticColor semanticColor;
  final int? intermediateStepsCount;

  const AppSlider({
    super.key,
    this.label,
    this.sublabel,
    required this.value,
    this.minValue = 0.0,
    this.maxValue = 100.0,
    this.stepSize,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.isDisabled = false,
    this.activeTrackColorOverride,
    this.valueTextFormatter,
    this.knobType = SliderKnobType.circle,
    this.showValueTooltip = true,
    this.valueTooltipAlignment = TooltipAlignment.top,
    this.semanticColor = SemanticColor.primary,
    this.intermediateStepsCount,
  }) : assert(minValue <= maxValue),
       assert(value >= minValue && value <= maxValue),
       assert(stepSize == null || stepSize > 0);

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  late double _currentValue;
  final GlobalKey _areaKey = GlobalKey();

  static const double _circleKnobDiameter = 20.0;
  static const double _ringKnobEffectiveDiameter = 20.0;
  static const double _rectangleKnobWidth = 4.0;
  static const double _rectangleKnobHeight = 22.0;

  double get _currentKnobWidth {
    switch (widget.knobType) {
      case SliderKnobType.circle:
        return _circleKnobDiameter;
      case SliderKnobType.rectangle:
        return _rectangleKnobWidth;
      case SliderKnobType.ring:
        return _ringKnobEffectiveDiameter;
    }
  }

  double get _currentKnobHeight {
    switch (widget.knobType) {
      case SliderKnobType.circle:
        return _circleKnobDiameter;
      case SliderKnobType.rectangle:
        return _rectangleKnobHeight;
      case SliderKnobType.ring:
        return _ringKnobEffectiveDiameter;
    }
  }

  @override
  void initState() {
    _currentValue = _snapToStep(
      widget.value.clamp(widget.minValue, widget.maxValue),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value ||
        widget.minValue != oldWidget.minValue ||
        widget.maxValue != oldWidget.maxValue ||
        widget.stepSize != oldWidget.stepSize) {
      if (widget.value != _currentValue) {
        _currentValue = _snapToStep(
          widget.value.clamp(widget.minValue, widget.maxValue),
        );
      } else {
        _currentValue = _snapToStep(
          _currentValue.clamp(widget.minValue, widget.maxValue),
        );
      }
    } else {
      _currentValue = _snapToStep(
        _currentValue.clamp(widget.minValue, widget.maxValue),
      );
    }
  }

  String _formatValue(double value, {bool forMinMax = false}) {
    if (widget.valueTextFormatter != null) {
      return widget.valueTextFormatter!(value);
    }
    return forMinMax ? value.toStringAsFixed(0) : value.round().toString();
  }

  double _snapToStep(double value) {
    if (widget.isDisabled || widget.stepSize == null || widget.stepSize! <= 0) {
      return value.clamp(widget.minValue, widget.maxValue);
    }
    final double relativeValue = value - widget.minValue;
    final double steps = (relativeValue / widget.stepSize!).round().toDouble();
    final double snappedValue = widget.minValue + (steps * widget.stepSize!);
    return snappedValue.clamp(widget.minValue, widget.maxValue);
  }

  void _updateValueFromPosition(double dx) {
    if (widget.isDisabled) return;
    final width = _areaKey.currentContext?.size?.width ?? 1.0;
    final percent = (dx / width).clamp(0.0, 1.0);
    var newValue =
        widget.minValue + percent * (widget.maxValue - widget.minValue);
    newValue = _snapToStep(newValue);

    if (_currentValue != newValue) {
      setState(() => _currentValue = newValue);
      widget.onChanged(newValue);
    }
  }

  Widget _buildKnob() {
    final knobState = widget.isDisabled ? KnobState.inactive : KnobState.active;
    Widget knobWidget;

    switch (widget.knobType) {
      case SliderKnobType.circle:
        knobWidget = AppCircleKnob(
          state: knobState,
          semanticColor: widget.semanticColor,
        );
        break;
      case SliderKnobType.rectangle:
        knobWidget = AppRectangleKnob(
          state: knobState,
          semanticColor: widget.semanticColor,
        );
        break;
      case SliderKnobType.ring:
        knobWidget = AppRingKnob(
          state: knobState,
          semanticColor: widget.semanticColor,
        );
        break;
    }

    if (widget.showValueTooltip && !widget.isDisabled) {
      return AppTooltip(
        title: _formatValue(_currentValue),
        alignment: widget.valueTooltipAlignment,
        size: TooltipSize.small,
        trigger: TooltipTrigger.hover,
        child: knobWidget,
      );
    }
    return knobWidget;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final minMaxTextStyle = theme.textTheme.bodyMedium!.copyWith(
      color: context.colors.onSurfaceVariantLow,
    );

    final activeTrackColor = widget.isDisabled
        ? context.colors.outline
        : widget.activeTrackColorOverride ?? widget.semanticColor.main(context);
    final inactiveTrackColor = widget.isDisabled
        ? context.colors.outline
        : context.colors.surfaceVariant;

    const trackHeight = 4.0;
    final maxElementHeight = math.max(_currentKnobHeight, trackHeight);
    final valuePercent = (widget.maxValue == widget.minValue)
        ? 0.0
        : ((_currentValue - widget.minValue) /
                  (widget.maxValue - widget.minValue))
              .clamp(0.0, 1.0);
    return Column(
      key: _areaKey,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.label != null) ...[
          AppInputLabel(
            label: widget.label!,
            sublabel: widget.sublabel,
            isDisabled: widget.isDisabled,
          ),
          const SizedBox(height: 8),
        ],

        SizedBox(
          height: maxElementHeight,
          child: AppSliderInteractiveArea(
            valuePercent: valuePercent,
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor,
            trackHeight: trackHeight,
            isDisabled: widget.isDisabled,
            knob: _buildKnob(),
            knobWidth: _currentKnobWidth,
            maxElementHeight: maxElementHeight,
            textDirection: Directionality.of(context),
            onTapDown: (dx) {
              widget.onChangeStart?.call(_currentValue);
              _updateValueFromPosition(dx);
            },
            onDragStart: (dx) {
              widget.onChangeStart?.call(_currentValue);
              _updateValueFromPosition(dx);
            },
            onDragUpdate: _updateValueFromPosition,
            onDragEnd: () => widget.onChangeEnd?.call(_currentValue),
          ),
        ),

        if (widget.intermediateStepsCount != null) ...[
          const SizedBox(height: 8),

          AppMinMax(
            minValue: widget.minValue,
            maxValue: widget.maxValue,
            textStyle: minMaxTextStyle,
            valueFormatter: _formatValue,
            intermediateStepsCount: widget.intermediateStepsCount,
          ),
        ],
      ],
    );
  }
}
