import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/atoms/chat_bubble/chat_bubble.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_note.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.extensions.dart';

extension ShopNoteFragmentX on Fragment$shopNote {
  Widget toChatBubble(BuildContext context, String currentUserId) => ChatBubble(
    message: note.note,
    isMe: staff.id == currentUserId,
    time: note.createdAt,
    avatar: staff.media?.address,
    name: staff.fullName,
  );
}
