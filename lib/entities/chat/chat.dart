import 'package:chat_zxc/entities/message/message.dart';

part 'direct.dart';

abstract interface class Chat {
  String get id;

  String get title;

  Message? get lastMessage;

  String? get imageUrl;
}

