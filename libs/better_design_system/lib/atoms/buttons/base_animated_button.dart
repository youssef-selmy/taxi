import 'package:flutter/cupertino.dart';

/// Configuration for button animation behavior
class ButtonAnimationConfig {
  /// Duration of the color transition animation
  final Duration duration;

  /// Curve for the animation
  final Curve curve;

  const ButtonAnimationConfig({
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
  });

  const ButtonAnimationConfig.fast()
    : duration = const Duration(milliseconds: 150),
      curve = Curves.easeInOut;
}

/// Represents the current interaction state of a button
class ButtonState {
  final bool isHovered;
  final bool isPressed;
  final bool isFocused;
  final bool isDisabled;

  const ButtonState({
    required this.isHovered,
    required this.isPressed,
    required this.isFocused,
    required this.isDisabled,
  });

  const ButtonState.initial()
    : isHovered = false,
      isPressed = false,
      isFocused = false,
      isDisabled = false;
}

/// A base button widget that provides animated state tracking and interaction handling.
///
/// This widget abstracts the common logic for handling button states (hover, press, focus)
/// and provides smooth animations when transitioning between states. It uses a builder
/// pattern to allow customization of the button appearance based on the current state.
///
/// Example:
/// ```dart
/// BaseAnimatedButton(
///   isDisabled: false,
///   onPressed: () => print('Pressed'),
///   builder: (context, state) {
///     return Container(
///       padding: EdgeInsets.all(16),
///       decoration: BoxDecoration(
///         color: state.isPressed ? Colors.blue : Colors.grey,
///       ),
///       child: Text('Button'),
///     );
///   },
/// )
/// ```
class BaseAnimatedButton extends StatefulWidget {
  /// Whether the button is disabled
  final bool isDisabled;

  /// Callback when the button is pressed
  final VoidCallback? onPressed;

  /// Builder function that provides the current button state
  final Widget Function(BuildContext context, ButtonState state) builder;

  /// Animation configuration
  final ButtonAnimationConfig animationConfig;

  const BaseAnimatedButton({
    super.key,
    required this.isDisabled,
    required this.onPressed,
    required this.builder,
    this.animationConfig = const ButtonAnimationConfig(),
  });

  @override
  State<BaseAnimatedButton> createState() => _BaseAnimatedButtonState();
}

class _BaseAnimatedButtonState extends State<BaseAnimatedButton> {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isFocused = false;

  bool get _isDisabled => widget.isDisabled || widget.onPressed == null;

  ButtonState get _buttonState => ButtonState(
    isHovered: _isHovered,
    isPressed: _isPressed,
    isFocused: _isFocused,
    isDisabled: _isDisabled,
  );

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: _isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onEnter: (_) {
        if (!_isDisabled) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (_) {
        if (!_isDisabled) {
          setState(() => _isHovered = false);
        }
      },
      child: Focus(
        onFocusChange: (isFocused) {
          if (!_isDisabled) {
            setState(() => _isFocused = isFocused);
          }
        },
        child: GestureDetector(
          onTapDown: (_) {
            if (!_isDisabled) {
              setState(() => _isPressed = true);
            }
          },
          onTapUp: (_) {
            if (!_isDisabled) {
              setState(() => _isPressed = false);
              widget.onPressed?.call();
            }
          },
          onTapCancel: () {
            if (!_isDisabled) {
              setState(() => _isPressed = false);
            }
          },
          child: AnimatedContainer(
            duration: widget.animationConfig.duration,
            curve: widget.animationConfig.curve,
            child: widget.builder(context, _buttonState),
          ),
        ),
      ),
    );
  }
}
