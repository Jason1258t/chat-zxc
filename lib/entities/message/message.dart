import 'views.dart';
import 'message_author.dart';
import 'reaction.dart';

class Message {
  final String id;
  final MessageAuthor author;
  final String? textContent;
  final DateTime sentAt;
  final ViewInfo view;
  final List<Reaction>? reactions;

  Message({
    required this.id,
    required this.author,
    this.textContent,
    required this.sentAt,
    this.view = const NoViewInfo(),
    required this.reactions,
  });
}

enum MessageStatus { pending, sent, read }
