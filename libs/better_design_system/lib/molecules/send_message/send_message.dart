import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

typedef BetterSendMessage = AppSendMessage;

class AppSendMessage extends StatefulWidget {
  final ApiResponse<void> sendState;
  final void Function(String)? onSend;
  final void Function(String)? onChanged;

  const AppSendMessage({
    super.key,
    this.sendState = const ApiResponse<void>.initial(),
    this.onSend,
    this.onChanged,
  });

  @override
  State<AppSendMessage> createState() => _AppSendMessageState();
}

class _AppSendMessageState extends State<AppSendMessage> {
  String _message = '';
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: _message);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppSendMessage oldWidget) {
    if (widget.sendState != oldWidget.sendState) {
      if (widget.sendState.isLoaded) {
        _controller.clear();
        _message = '';
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextField(
            density: TextFieldDensity.dense,
            hint: context.strings.typeAMessage,
            onChanged: (value) {
              _message = value;
              if (widget.onChanged != null) {
                widget.onChanged!(_message);
              }
            },
            controller: _controller,
          ),
        ),
        const SizedBox(width: 8),
        AppFilledButton(
          prefixIcon: BetterIcons.sentFilled,
          size: ButtonSize.large,
          isDisabled: widget.sendState.isLoading,
          isLoading: widget.sendState.isLoading,
          onPressed: () {
            if (widget.onSend != null) {
              widget.onSend!(_message);
            }
          },
        ),
      ],
    );
  }
}
