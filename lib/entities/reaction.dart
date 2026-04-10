
import 'message_author.dart';

class Reaction {
  final String reaction;
  final MessageAuthor author;
  final DateTime createdAt;

  Reaction({
    required this.author,
    required this.reaction,
    required this.createdAt,
  });
}