import 'dart:math';

import 'package:better_design_system/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

typedef BetterSlideToAction = AppSlideToAction;

class AppSlideToAction extends StatefulWidget {
  final double height = 45;
  final animationDuration = const Duration(milliseconds: 300);
  final String? text;
  final Function() onSlided;
  final bool isDisabled;
  final SemanticColor color;
  final SliderButtonController? controller;

  const AppSlideToAction({
    required this.onSlided,
    this.text,
    this.controller,
    this.isDisabled = false,
    this.color = SemanticColor.primary,
    super.key,
  });

  @override
  State<AppSlideToAction> createState() => _AppSlideToActionState();
}

class _AppSlideToActionState extends State<AppSlideToAction>
    with SingleTickerProviderStateMixin {
  double _sliderRelativePosition = 0.0; // values 0 -> 1
  double _startedDraggingAtX = 0.0;
  late final AnimationController _animationController;
  late final Animation _sliderAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      widget.controller!.addListener(reset);
    }
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _sliderAnimation = CurveTween(
      curve: Curves.easeInQuad,
    ).animate(_animationController);

    _animationController.addListener(() {
      setState(() {
        _sliderRelativePosition = _sliderAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void reset() {
    _animationController.reverse(from: _sliderRelativePosition);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: !widget.isDisabled
            ? widget.color.main(context)
            : widget.color.disabled(context),
      ),
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          final sliderRadius = widget.height / 2;
          final sliderMaxX = constraints.maxWidth - 2 * sliderRadius;
          final sliderPosX = sliderMaxX * _sliderRelativePosition;
          return Stack(
            children: [
              _buildBackground(
                width: constraints.maxWidth,
                backgroundSplitX: sliderPosX + sliderRadius,
              ),
              _buildText(),
              _buildSlider(sliderMaxX: sliderMaxX, sliderPositionX: sliderPosX),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBackground({
    required double width,
    required double backgroundSplitX,
  }) {
    return Row(
      children: [
        SizedBox(height: widget.height, width: backgroundSplitX),
        SizedBox(height: widget.height, width: width - backgroundSplitX),
      ],
    );
  }

  Widget _buildText() {
    if (widget.text == null) {
      return const SizedBox();
    }
    return AnimatedOpacity(
      duration: widget.animationDuration,
      opacity: 1 - _sliderRelativePosition,
      child: SizedBox(
        height: widget.height,
        child: Center(
          child: Text(
            widget.text!,
            style: context.textTheme.bodyLarge?.copyWith(
              color: widget.color.onColor(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider({
    required double sliderMaxX,
    required double sliderPositionX,
  }) {
    return Positioned(
      left: sliderPositionX,
      child: GestureDetector(
        onHorizontalDragStart: (start) {
          if (widget.isDisabled) {
            return;
          }
          _startedDraggingAtX = sliderPositionX;
          _animationController.stop();
        },
        onHorizontalDragUpdate: (update) {
          if (widget.isDisabled) {
            return;
          }
          final newSliderPositionX =
              _startedDraggingAtX + update.localPosition.dx;
          final newSliderRelativePosition = newSliderPositionX / sliderMaxX;
          setState(() {
            _sliderRelativePosition = max(0, min(1, newSliderRelativePosition));
          });
        },
        onHorizontalDragEnd: (end) {
          if (widget.isDisabled) {
            return;
          }
          if (_sliderRelativePosition == 1.0) {
            widget.onSlided();
            reset();
          } else {
            reset();
          }
        },
        child: Opacity(
          opacity: widget.isDisabled ? 0.8 : 1,
          child: Container(
            height: widget.height,
            width: widget.height,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colors.outline, width: 1),
            ),
            child: Transform.rotate(
              angle:
                  _sliderRelativePosition * pi, // Rotate from 0 to 180 degrees
              child: Icon(
                BetterIcons.arrowRight02Outline,
                size: 20,
                color: widget.isDisabled
                    ? widget.color.disabled(context)
                    : widget.color.main(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SliderButtonController extends ChangeNotifier {
  void reset() {
    notifyListeners();
  }
}
