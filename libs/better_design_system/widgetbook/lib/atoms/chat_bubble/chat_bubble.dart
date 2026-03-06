import 'package:better_design_system/atoms/chat_bubble/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:time/time.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppChatBubble)
Widget defaultChatBubble(BuildContext context) {
  return _getChatBubble(context);
}

Widget _getChatBubble(BuildContext context) {
  final bool showSenderText = context.knobs.boolean(
    label: 'Show Sender Text',
    initialValue: true,
    description: 'Displays the sender text when enabled.',
  );
  final bool showText = context.knobs.boolean(
    label: 'Show Content Text',
    initialValue: true,
    description: 'Displays the Content text when enabled.',
  );
  final bool showTitle = context.knobs.boolean(
    label: 'Show Title',
    initialValue: true,
    description: 'Displays the title when enabled.',
  );
  final bool showAvatar = context.knobs.boolean(
    label: 'Show Avatar',
    initialValue: true,
    description: 'Displays the avatar when enabled.',
  );

  final String replyType = context.knobs.object.dropdown(
    label: 'Reply Type',
    options: ['None', 'Text', 'File'],
    labelBuilder: (value) => value,
    description:
        'Switches between showing a text reply or a file reply based on the selected option.',
  );

  final bool showVoiceMessage = context.knobs.boolean(
    label: 'Show Voice Message',
    initialValue: true,
    description: 'Displays the voice message when enabled.',
  );

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 500,
        child: AppChatBubble(
          senderText: showSenderText ? 'John Doe' : null,
          width: 500,
          sentAt: 3.minutes.ago,
          text: showText ? 'Hello, World!' : null,
          title: showTitle ? 'Title' : null,
          avatar: showAvatar ? ImageFaker().food.burger : null,
          isSender: context.knobs.boolean(
            label: 'Is Sender',
            initialValue: false,
            description:
                'Determines whether the message was sent by you or someone else.',
          ),
          sentAtPosition: context.knobs.object.dropdown(
            label: 'Sent At Position',
            options: SentAtPosition.values,
            labelBuilder: (value) => value.name,
            description:
                'Sets the position of the sent time either left or right.',
          ),
          isSeen: context.knobs.boolean(
            label: 'Is Seen',
            initialValue: false,
            description:
                'Indicates whether the message has been seen (read) by the recipient.',
          ),
          replyFile:
              replyType == 'File'
                  ? ChatBubbleFileReply(
                    title: 'File name',
                    size: '12 MB',
                    type: ChatBubbleFileReplyType.document,
                  )
                  : null,
          replyText: replyType == 'Text' ? 'Reply text' : null,

          voiceValues:
              showVoiceMessage
                  ? [
                    0.49,
                    0.57,
                    0.77,
                    0.67,
                    0.43,
                    0.58,
                    0.58,
                    0.57,
                    0.42,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.86,
                    0.81,
                    0.86,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                  ]
                  : null,
        ),
      ),
    ],
  );
}
