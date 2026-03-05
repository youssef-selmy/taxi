import 'package:flutter/material.dart';

import 'package:admin_frontend/core/components/atoms/chat_bubble/chat_bubble.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_note.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.extensions.dart';

extension ParkingNoteFragmentX on Fragment$parkingNote {
  Widget toChatBubble(BuildContext context, String currentUserId) => ChatBubble(
    message: note,
    isMe: staff.id == currentUserId,
    time: createdAt,
    avatar: staff.media?.address,
    name: staff.fullName,
  );
}
