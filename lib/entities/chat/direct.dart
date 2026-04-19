part of 'chat.dart';

class DirectChat implements Chat {
  @override
  final String id;
  @override
  final String title;
  @override
  final Message lastMessage;

  @override
  final String? imageUrl;

  DirectChat({
    required this.title,
    required this.imageUrl,
    required this.lastMessage,
    required this.id,
  });
}