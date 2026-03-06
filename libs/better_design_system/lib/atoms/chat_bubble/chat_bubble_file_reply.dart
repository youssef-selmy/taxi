class ChatBubbleFileReply {
  final String title;
  final String size;
  final ChatBubbleFileReplyType type;

  ChatBubbleFileReply({
    required this.title,
    required this.size,
    required this.type,
  });
}

enum ChatBubbleFileReplyType {
  document, // pdf, doc, txt, etc.
  image, // jpg, png, gif, etc.
  audio, // mp3, wav, etc.
  video, // mp4, avi, etc.
  archive, // zip, rar, etc.
  executable, // apk, exe, etc.
  unknown, // fallback for unsupported types
}
