import 'package:chat_zxc/entities/message/message.dart';

class ChatViewModel {
  final String id;
  final String title;
  final Message? lastMessage;
  final String? imageUrl;
  final bool isUnread;
  final bool isOnline;

  ChatViewModel({
    required this.id,
    required this.title,
    this.isUnread = false,
    this.isOnline = false,
    required this.imageUrl,
    required this.lastMessage,
  });

  DateTime get time => lastMessage?.sentAt ?? DateTime.now();
}
