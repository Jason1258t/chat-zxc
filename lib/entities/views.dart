import 'message_author.dart';

abstract interface class ViewInfo {
  bool get isViewed;
}

class NoViewInfo implements ViewInfo {
  @override
  bool get isViewed => false;

  const NoViewInfo();
}

class DirectMessageView implements ViewInfo {
  final DateTime? viewedAt;

  DirectMessageView(this.viewedAt);

  @override
  bool get isViewed => viewedAt != null;
}

class GroupMessageViews implements ViewInfo {
  final List<MessageView> recentViews;
  final int viewsCount;

  GroupMessageViews({required this.recentViews, required this.viewsCount});

  @override
  bool get isViewed => recentViews.isNotEmpty;
}

class MessageView {
  final MessageAuthor author;
  final DateTime readAt;

  MessageView({required this.author, required this.readAt});
}
