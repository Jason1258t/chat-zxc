part of 'search_entity.dart';

class UserSearchEntity implements SearchEntity {
  @override
  String get subtitle => "Start messaging";

  @override
  final String title;

  @override
  final String? imageUrl;

  @override
  final String objectId;

  @override
  SearchObjectType get objectType => .user;

  @override
  SearchSource get source => .globalUsers;

  UserSearchEntity({
    required this.title,
    required this.imageUrl,
    required this.objectId,
  });
}
