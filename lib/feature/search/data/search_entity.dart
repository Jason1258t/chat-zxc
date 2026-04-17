abstract class SearchEntity {
  String get name;

  String? get chatId;

  String? get imageUrl;

  String get objectId;

  SearchObjectType get objectType;
}

enum SearchObjectType { user, bot, group, channel }
