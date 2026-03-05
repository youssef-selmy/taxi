import 'package:better_design_system/atoms/chat_bubble/chat_bubble.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class ChatBubble extends StatelessWidget {
  final String? message;
  final bool isMe;
  final DateTime time;
  final String? name;
  final String? avatar;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.time,
    this.name,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return AppChatBubble(
      text: message ?? '',
      sentAt: time,
      isSender: isMe,
      avatar: avatar,
      senderText: context.tr.commentMessage(isMe ? "You" : name ?? "-"),
      width: double.infinity,
    );
  }
}
