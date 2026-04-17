abstract interface class Chat {
  String get name;

  String? get imageUrl;
}

class DirectChat implements Chat {
  @override
  final String name;

  @override
  final String? imageUrl;

  DirectChat({required this.name, required this.imageUrl});
}

class ChatViewModel extends Chat {
  final String id;
  @override
  final String name;
  final String lastMessage;
  final String time;
  final bool isUnread;
  final bool isOnline;
  @override
  final String? imageUrl;

  ChatViewModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.isUnread = false,
    this.isOnline = false,
    required this.imageUrl,
  });
}
