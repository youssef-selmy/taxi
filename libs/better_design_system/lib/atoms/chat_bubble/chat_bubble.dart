import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/chat_bubble/chat_bubble_file_reply.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
export 'chat_bubble_file_reply.dart';

enum SentAtPosition { left, right }

typedef BetterChatBubble = AppChatBubble;

class AppChatBubble extends StatelessWidget {
  final String? text;
  final String? title;
  final String? senderText;
  final String? avatar;
  final String? replyText;
  final ChatBubbleFileReply? replyFile;
  final DateTime sentAt;
  final SentAtPosition sentAtPosition;
  final bool isSender;
  final bool isSeen;
  final double width;
  final List<double>? voiceValues;

  const AppChatBubble({
    super.key,
    this.text,
    required this.sentAt,
    required this.isSender,
    this.width = 300,
    this.senderText,
    this.avatar,
    this.sentAtPosition = SentAtPosition.right,
    this.isSeen = false,
    this.title,
    this.replyText,
    this.replyFile,
    this.voiceValues = const [],
  }) : assert(
         replyText == null || replyFile == null,
         'Only one of replyText or replyFile can be non-null.',
       ),
       assert(
         (text != null) || voiceValues != null,
         'Either text or voiceValues must be non-empty.',
       );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isSender && avatar != null) ...[
          AppAvatar(imageUrl: avatar, size: AvatarSize.xxl24px),
          const SizedBox(width: 4),
        ],

        Expanded(
          child: Column(
            crossAxisAlignment: isSender
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              if (senderText != null)
                Text(
                  senderText!,
                  style: context.textTheme.labelMedium?.variant(context),
                ),
              Container(
                constraints: BoxConstraints(maxWidth: width),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: _backgroundColor(context),
                  borderRadius: isSender
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(4),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(4),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (replyFile != null) ...[
                      _getReplyFile(context),
                      const SizedBox(height: 8),
                    ],
                    if (replyText != null) ...[
                      _getReplyText(context),
                      const SizedBox(height: 8),
                    ],
                    if (voiceValues != null && voiceValues!.isNotEmpty) ...[
                      Row(
                        spacing: 8,
                        children: [
                          Icon(
                            Icons.play_circle,
                            size: 32,
                            color: isSender
                                ? context.colors.onPrimary
                                : context.colors.primary,
                          ),

                          _getVoiceMessage(context, values: voiceValues!),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (title != null) ...[
                      Text(
                        title!,
                        style: context.textTheme.titleSmall?.apply(
                          color: _textColor(context),
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],

                    if (text != null) ...[
                      Text(
                        text!,
                        style: context.textTheme.bodyLarge?.apply(
                          color: _textColor(context),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    Row(
                      mainAxisAlignment: sentAtPosition == SentAtPosition.left
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      spacing: 8,
                      children: [
                        if (isSender && sentAtPosition == SentAtPosition.left)
                          Icon(
                            isSeen
                                ? BetterIcons.tickDouble02Outline
                                : BetterIcons.tick02Outline,
                            size: 20,
                            color: context.colors.onPrimary,
                          ),
                        StreamBuilder<DateTime>(
                          stream: Stream.periodic(
                            const Duration(seconds: 30),
                            (_) => DateTime.now(),
                          ),
                          builder: (context, snapshot) {
                            return Text(
                              sentAt.toMoment().fromNow(),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: isSender
                                    ? context.colors.onPrimary
                                    : context.colors.onSurfaceVariantLow,
                              ),
                            );
                          },
                        ),
                        if (isSender && sentAtPosition == SentAtPosition.right)
                          Icon(
                            isSeen
                                ? BetterIcons.tickDouble02Outline
                                : BetterIcons.tick02Outline,
                            size: 20,
                            color: context.colors.onPrimary,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isSender && avatar != null) ...[
          const SizedBox(width: 4),
          AppAvatar(imageUrl: avatar, size: AvatarSize.xxl24px),
        ],
      ],
    );
  }

  Widget _getReplyFile(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSender
                ? context.colors.primaryBold
                : context.colors.surface,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              spacing: 8,
              children: <Widget>[
                Icon(
                  BetterIcons.file02Filled,
                  size: 24,
                  color: isSender
                      ? context.colors.onPrimary
                      : context.colors.onSurfaceVariant,
                ),
                Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      replyFile!.title,
                      style: context.textTheme.labelLarge?.copyWith(
                        color: _textColor(context),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      '${replyFile!.size} - ${replyFile!.type.name}',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: isSender
                            ? context.colors.onPrimary
                            : context.colors.onSurfaceVariantLow,
                      ),

                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getReplyText(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(2),
                topLeft: Radius.circular(2),
                bottomRight: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              color: isSender
                  ? context.colors.primaryBold
                  : context.colors.surface,
            ),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(2),
                    bottomLeft: Radius.circular(2),
                  ),
                  child: Container(
                    height: 40,
                    width: 2,
                    decoration: BoxDecoration(
                      color: isSender
                          ? context.colors.onPrimary
                          : context.colors.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  child: SizedBox(
                    // width - padding and border
                    width: width - 50,
                    child: Text(
                      replyText!,
                      style: context.textTheme.bodyMedium?.variant(context),

                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getVoiceMessage(
    BuildContext context, {
    required List<double> values,
  }) {
    const double minHeight = 4;
    const double maxHeight = 24;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: values.map((value) {
        final clamped = value.clamp(0.0, 1.0);
        final height = minHeight + (maxHeight - minHeight) * clamped;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(
            width: 1.5,
            height: height,
            decoration: BoxDecoration(
              color: isSender
                  ? context.colors.onPrimary
                  : context.colors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _backgroundColor(BuildContext context) =>
      isSender ? context.colors.primary : context.colors.surfaceVariant;

  Color _textColor(BuildContext context) =>
      isSender ? context.colors.onPrimary : context.colors.onSurface;
}
