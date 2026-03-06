import 'package:api_response/api_response.dart';
import 'package:better_design_system/molecules/send_message/send_message.dart';
import 'package:flutter/material.dart';

import 'package:better_icons/better_icon.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/chat_bubble/chat_bubble.dart';

import 'package:better_design_system/organisms/mobile_top_bar/mobile_top_bar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

export 'package:better_design_system/atoms/chat_bubble/chat_bubble.dart';

typedef BetterChatScreenTemplate = AppChatScreenTemplate;

class AppChatScreenTemplate extends StatefulWidget {
  final String? avatarUrl;
  final String userName;
  final String? mobileNumber;
  final List<AppChatBubble> chatBubbles;
  final List<String> suggestions;
  final Function(String) onSendMessage;
  final Function(String) onCallPressed;
  final Function() onBackPressed;
  final ApiResponse<void> sendState;

  const AppChatScreenTemplate({
    super.key,
    this.avatarUrl,
    required this.userName,
    this.mobileNumber,
    required this.chatBubbles,
    this.suggestions = const [],
    required this.onSendMessage,
    required this.onCallPressed,
    required this.onBackPressed,
    required this.sendState,
  });

  @override
  State<AppChatScreenTemplate> createState() => _AppChatScreenTemplateState();
}

class _AppChatScreenTemplateState extends State<AppChatScreenTemplate> {
  final ScrollController _scrollController = ScrollController();
  String text = '';

  @override
  void initState() {
    super.initState();
    // Scroll to bottom when chat is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AppChatScreenTemplate oldWidget) {
    if (widget.chatBubbles != oldWidget.chatBubbles) {
      // scroll to the bottom when a new message is sent
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
    if (widget.sendState != oldWidget.sendState && widget.sendState.isLoaded) {
      text = '';
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppMobileTopBar(
              onBackPressed: widget.onBackPressed,
              padding: const EdgeInsets.all(16),
              title: widget.userName,
              subtitle: widget.mobileNumber,
              childAlignment: MobileTopBarChildAlignment.start,
              suffixActions: [
                AppIconButton(
                  icon: BetterIcons.call02Filled,
                  size: ButtonSize.large,
                  color: SemanticColor.primary,
                  iconColor: context.colors.primary,
                  onPressed: () {
                    widget.onCallPressed(widget.mobileNumber ?? '');
                  },
                ),
              ],
              prefixActions: [
                AppAvatar(
                  imageUrl: widget.avatarUrl,
                  size: AvatarSize.size32px,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget.chatBubbles
                      .map(
                        (bubble) => Align(
                          alignment: bubble.isSender
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: bubble,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            if (widget.suggestions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (var suggestion in widget.suggestions)
                      AppFilledButton(
                        text: suggestion,
                        size: ButtonSize.medium,
                        onPressed: () {
                          widget.onSendMessage(suggestion);
                        },
                      ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: AppSendMessage(
                sendState: widget.sendState,
                onChanged: (p0) => setState(() {
                  text = p0;
                }),
                onSend: (message) {
                  widget.onSendMessage(message);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
