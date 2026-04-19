part of 'search_entity.dart';

class ExistingDirectChatSearchEntity implements SearchEntity {
  @override
  final String subtitle;

  @override
  final String title;

  @override
  final String? imageUrl;

  @override
  final String objectId;

  final String peerId;

  @override
  SearchObjectType get objectType => .user;

  @override
  SearchSource get source => .existingChats;

  ExistingDirectChatSearchEntity({
    required this.subtitle,
    required this.title,
    required this.imageUrl,
    required this.objectId,
    required this.peerId,
  });
}
