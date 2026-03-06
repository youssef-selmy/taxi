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

typedef BetterRangeSlider = AppRangeSlider;

class AppRangeSlider extends StatefulWidget {
  final String label;
  final String? sublabel;
  final RangeValues values;
  final double minValue;
  final double maxValue;
  final double? stepSize;
  final ValueChanged<RangeValues> onChanged;
  final ValueChanged<RangeValues>? onChangeStart;
  final ValueChanged<RangeValues>? onChangeEnd;
  final bool isDisabled;
  final Color? activeTrackColorOverride;
  final String Function(double value)? valueTextFormatter;
  final SliderKnobType knobType;
  final bool showValueTooltip;
  final TooltipAlignment valueTooltipAlignment;
  final SemanticColor semanticColor;
  final int? intermediateStepsCount;
  final double minAllowedRangeGap;

  const AppRangeSlider({
    super.key,
    required this.label,
    this.sublabel,
    required this.values,
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
    this.minAllowedRangeGap = 0.0,
  }) : assert(minValue <= maxValue),
       assert(stepSize == null || stepSize > 0),
       assert(minAllowedRangeGap >= 0);

  @override
  State<AppRangeSlider> createState() => _AppRangeSliderState();
}

enum _ActiveThumb { start, end, none }

class _AppRangeSliderState extends State<AppRangeSlider> {
  late RangeValues _currentValues;
  final GlobalKey _areaKey = GlobalKey();
  _ActiveThumb _activeThumb = _ActiveThumb.none;

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
    super.initState();
    _currentValues = RangeValues(
      _snapToStep(widget.values.start.clamp(widget.minValue, widget.maxValue)),
      _snapToStep(widget.values.end.clamp(widget.minValue, widget.maxValue)),
    );
    if (_currentValues.start > _currentValues.end) {
      _currentValues = RangeValues(_currentValues.end, _currentValues.start);
    }
  }

  @override
  void didUpdateWidget(covariant AppRangeSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.values != oldWidget.values ||
        widget.minValue != oldWidget.minValue ||
        widget.maxValue != oldWidget.maxValue ||
        widget.stepSize != oldWidget.stepSize) {
      RangeValues newValues = RangeValues(
        _snapToStep(
          widget.values.start.clamp(widget.minValue, widget.maxValue),
        ),
        _snapToStep(widget.values.end.clamp(widget.minValue, widget.maxValue)),
      );
      if (newValues.start > newValues.end) {
        newValues = RangeValues(newValues.end, newValues.start);
      }
      if (newValues.end < newValues.start + widget.minAllowedRangeGap) {
        if (_activeThumb == _ActiveThumb.start) {
          newValues = RangeValues(
            newValues.start,
            newValues.start + widget.minAllowedRangeGap,
          );
        } else {
          newValues = RangeValues(
            newValues.end - widget.minAllowedRangeGap,
            newValues.end,
          );
        }
      }
      _currentValues = RangeValues(
        newValues.start.clamp(widget.minValue, widget.maxValue),
        newValues.end.clamp(widget.minValue, widget.maxValue),
      );
      if (_currentValues.start > _currentValues.end) {
        _currentValues = RangeValues(_currentValues.end, _currentValues.start);
      }
    } else {
      RangeValues newValues = RangeValues(
        _snapToStep(
          _currentValues.start.clamp(widget.minValue, widget.maxValue),
        ),
        _snapToStep(_currentValues.end.clamp(widget.minValue, widget.maxValue)),
      );
      if (newValues.start > newValues.end) {
        newValues = RangeValues(newValues.end, newValues.start);
      }
      if (newValues.end < newValues.start + widget.minAllowedRangeGap) {
        if (_activeThumb == _ActiveThumb.start &&
            _currentValues.start == newValues.start) {
          newValues = RangeValues(
            newValues.start,
            (newValues.start + widget.minAllowedRangeGap).clamp(
              widget.minValue,
              widget.maxValue,
            ),
          );
        } else if (_activeThumb == _ActiveThumb.end &&
            _currentValues.end == newValues.end) {
          newValues = RangeValues(
            (newValues.end - widget.minAllowedRangeGap).clamp(
              widget.minValue,
              widget.maxValue,
            ),
            newValues.end,
          );
        } else {
          newValues = RangeValues(
            newValues.start,
            (newValues.start + widget.minAllowedRangeGap).clamp(
              widget.minValue,
              widget.maxValue,
            ),
          );
          if (newValues.end > widget.maxValue) {
            newValues = RangeValues(
              (widget.maxValue - widget.minAllowedRangeGap).clamp(
                widget.minValue,
                widget.maxValue,
              ),
              widget.maxValue,
            );
          }
        }
      }
      _currentValues = RangeValues(
        newValues.start.clamp(widget.minValue, widget.maxValue),
        newValues.end.clamp(widget.minValue, widget.maxValue),
      );
      if (_currentValues.start > _currentValues.end) {
        _currentValues = RangeValues(_currentValues.end, _currentValues.start);
      }
    }
  }

  String _formatValue(double value, {bool forMinMaxLabels = false}) {
    if (widget.valueTextFormatter != null) {
      return widget.valueTextFormatter!(value);
    }
    return forMinMaxLabels
        ? value.toStringAsFixed(0)
        : value.round().toString();
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

  void _updateValueFromPosition(double horizontalPosition, _ActiveThumb thumb) {
    final width = _areaKey.currentContext?.size?.width ?? 1.0;
    if (widget.isDisabled || width <= 0) return;

    final double percent = (horizontalPosition / width).clamp(0.0, 1.0);
    double newValue =
        widget.minValue + percent * (widget.maxValue - widget.minValue);
    newValue = _snapToStep(newValue);

    RangeValues newValues;
    if (thumb == _ActiveThumb.start) {
      final double endLimit = _currentValues.end - widget.minAllowedRangeGap;
      newValue = newValue.clamp(widget.minValue, endLimit);
      newValues = RangeValues(newValue, _currentValues.end);
    } else {
      final double startLimit =
          _currentValues.start + widget.minAllowedRangeGap;
      newValue = newValue.clamp(startLimit, widget.maxValue);
      newValues = RangeValues(_currentValues.start, newValue);
    }

    newValues = RangeValues(
      newValues.start.clamp(widget.minValue, widget.maxValue),
      newValues.end.clamp(widget.minValue, widget.maxValue),
    );

    if (newValues.start > newValues.end) {
      if (thumb == _ActiveThumb.start) {
        newValues = RangeValues(newValues.start, newValues.start);
      } else {
        newValues = RangeValues(newValues.end, newValues.end);
      }
    }

    if (_currentValues != newValues) {
      setState(() {
        _currentValues = newValues;
      });
      widget.onChanged(newValues);
    }
  }

  void _determineActiveThumb(double horizontalPosition) {
    final width = _areaKey.currentContext?.size?.width ?? 1.0;
    final double startKnobPos =
        ((_currentValues.start - widget.minValue) /
            (widget.maxValue - widget.minValue)) *
        width;
    final double endKnobPos =
        ((_currentValues.end - widget.minValue) /
            (widget.maxValue - widget.minValue)) *
        width;

    final double distToStart = (horizontalPosition - startKnobPos).abs();
    final double distToEnd = (horizontalPosition - endKnobPos).abs();

    final double tolerance = _currentKnobWidth / 2;
    if (distToStart <= tolerance && distToStart < distToEnd) {
      _activeThumb = _ActiveThumb.start;
    } else if (distToEnd <= tolerance && distToEnd <= distToStart) {
      _activeThumb = _ActiveThumb.end;
    } else if (distToStart < distToEnd) {
      _activeThumb = _ActiveThumb.start;
    } else {
      _activeThumb = _ActiveThumb.end;
    }
  }

  Widget _buildKnob(double value, _ActiveThumb thumbIdentifier) {
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
        trigger: TooltipTrigger.hover,
        title: _formatValue(value),
        alignment: widget.valueTooltipAlignment,
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
    final Color actualActiveTrackColor =
        widget.activeTrackColorOverride ?? widget.semanticColor.main(context);
    final Color activeColorForTrack = widget.isDisabled
        ? context.colors.outline
        : actualActiveTrackColor;
    final Color inactiveTrackColor = widget.isDisabled
        ? context.colors.outline
        : context.colors.surfaceVariant;
    const double trackHeight = 4.0;
    final double maxElementHeight = math.max(_currentKnobHeight, trackHeight);

    final double startPercent = (widget.maxValue == widget.minValue)
        ? 0.0
        : ((_currentValues.start - widget.minValue) /
                  (widget.maxValue - widget.minValue))
              .clamp(0.0, 1.0);
    final double endPercent = (widget.maxValue == widget.minValue)
        ? 0.0
        : ((_currentValues.end - widget.minValue) /
                  (widget.maxValue - widget.minValue))
              .clamp(0.0, 1.0);

    return Column(
      key: _areaKey,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppInputLabel(
          label: widget.label,
          sublabel: widget.sublabel,
          isDisabled: widget.isDisabled,
        ),
        const SizedBox(height: 8),
        AppSliderInteractiveArea(
          isRange: true,
          startValuePercent: startPercent,
          endValuePercent: endPercent,
          startKnob: _buildKnob(_currentValues.start, _ActiveThumb.start),
          endKnob: _buildKnob(_currentValues.end, _ActiveThumb.end),
          startKnobWidth: _currentKnobWidth,
          endKnobWidth: _currentKnobWidth,
          activeTrackColor: activeColorForTrack,
          inactiveTrackColor: inactiveTrackColor,
          trackHeight: trackHeight,
          isDisabled: widget.isDisabled,
          maxElementHeight: maxElementHeight,
          textDirection: Directionality.of(context),
          onTapDown: (localPositionDx) {
            if (widget.isDisabled) return;
            _determineActiveThumb(localPositionDx);
            widget.onChangeStart?.call(_currentValues);
            _updateValueFromPosition(localPositionDx, _activeThumb);
          },
          onDragStart: (localPositionDx) {
            if (widget.isDisabled) return;
            _determineActiveThumb(localPositionDx);
            widget.onChangeStart?.call(_currentValues);
            _updateValueFromPosition(localPositionDx, _activeThumb);
          },
          onDragUpdate: (localPositionDx) {
            if (widget.isDisabled) return;
            if (_activeThumb == _ActiveThumb.none) {
              _determineActiveThumb(localPositionDx);
            }
            _updateValueFromPosition(localPositionDx, _activeThumb);
          },
          onDragEnd: () {
            if (widget.isDisabled) return;
            widget.onChangeEnd?.call(_currentValues);
            _activeThumb = _ActiveThumb.none;
          },
        ),
        const SizedBox(height: 8),
        AppMinMax(
          minValue: widget.minValue,
          maxValue: widget.maxValue,
          textStyle: minMaxTextStyle,
          valueFormatter: (val, {bool forMinMax = false}) =>
              _formatValue(val, forMinMaxLabels: true),
          intermediateStepsCount: widget.intermediateStepsCount,
        ),
      ],
    );
  }
}
