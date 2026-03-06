import 'package:api_response/api_response.dart';
import 'package:better_design_system/templates/chat_screen_template/chat_screen_template.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppChatScreenTemplate)
Widget defaultChatScreenTemplate(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(30),
    child: AppChatScreenTemplate(
      sendState: context.knobs.object.dropdown(
        label: 'Send State',
        initialOption: ApiResponse<void>.initial(),
        options: const [
          ApiResponse<void>.initial(),
          ApiResponse<void>.loading(),
          ApiResponse<void>.loaded(null),
          ApiResponse<void>.error('Error'),
        ],
      ),
      avatarUrl: ImageFaker().person.random(),
      userName: context.knobs.string(
        label: 'User Name',
        initialValue: 'John Doe',
      ),
      mobileNumber: context.knobs.string(
        label: 'Mobile Number',
        initialValue: '+1 234 567 8900',
      ),
      onSendMessage: (_) {},
      onBackPressed: () {},
      suggestions: [
        'Hello',
        'How are you?',
        'What are you doing?',
        'What is your name?',
        'Where are you from?',
        'What is your favorite color?',
        'What is your favorite food?',
        'What is your favorite movie?',
        'What is your favorite book?',
        'What is your favorite sport?',
      ],
      onCallPressed: (_) {
        // Handle call action
      },
      chatBubbles: [
        AppChatBubble(
          sentAt: DateTime.now(),
          text: "Hello, how are you?",
          isSender: false,
        ),
        AppChatBubble(
          sentAt: DateTime.now(),
          text: "I'm doing well, thank you!",
          isSender: true,
        ),
        AppChatBubble(
          sentAt: DateTime.now(),
          text: "What about you?",
          isSender: context.knobs.boolean(
            label: 'Is Sender',
            initialValue: false,
          ),
        ),
        AppChatBubble(
          sentAt: DateTime.now(),
          text: "I'm great, thanks for asking!",
          isSender: true,
        ),
        AppChatBubble(
          sentAt: DateTime.now(),
          text: "What are your plans for today?",
          isSender: false,
        ),
        AppChatBubble(
          sentAt: DateTime.now(),
          text: "I'm looking forward to a relaxing day!",
          isSender: true,
        ),
        AppChatBubble(
          sentAt: DateTime.now(),
          text: "What about you?",
          isSender: context.knobs.boolean(
            label: 'Is Sender',
            initialValue: false,
          ),
        ),
        AppChatBubble(
          sentAt: DateTime.now(),
          text: "What are your plans for the weekend?",
          isSender: context.knobs.boolean(
            label: 'Is Sender',
            initialValue: false,
          ),
        ),
        AppChatBubble(
          sentAt: DateTime.now(),
          text: "I'm planning to go hiking!",
          isSender: true,
        ),
        AppChatBubble(
          sentAt: DateTime.now(),
          text: "That sounds fun! Where are you going?",
          isSender: context.knobs.boolean(
            label: 'Is Sender',
            initialValue: false,
          ),
        ),
        AppChatBubble(
          sentAt: DateTime.now(),
          text: "I'm thinking of going to the mountains.",
          isSender: true,
        ),
        AppChatBubble(
          sentAt: DateTime.now(),
          text: "That sounds amazing! I love hiking in the mountains.",
          isSender: context.knobs.boolean(
            label: 'Is Sender',
            initialValue: false,
          ),
        ),
      ],
    ),
  );
}
