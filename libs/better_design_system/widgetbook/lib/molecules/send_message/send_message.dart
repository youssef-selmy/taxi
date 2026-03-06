import 'package:better_design_system/molecules/send_message/send_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppSendMessage)
Widget appSendMessage(BuildContext context) {
  return SizedBox(
    width: 400,
    child: AppSendMessage(onSend: (message) {}, onChanged: (p0) {}),
  );
}
