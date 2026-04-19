part 'direct_chat.dart';
part 'user.dart';

abstract class SearchEntity {
  String get title;

  String get subtitle;

  String? get imageUrl;

  String get objectId;

  SearchObjectType get objectType;

  SearchSource get source;
}

enum SearchObjectType { user, bot, group, channel }

enum SearchSource { existingChats, globalUsers, publicChannels, bots }
