import 'profile.dart';

abstract interface class MessageAuthor {
  String get name;

  String get id;

  String? get avatarUrl;
}

class AuthorPreview implements MessageAuthor {
  @override
  final String name;

  @override
  final String? avatarUrl;

  @override
  final String id;

  AuthorPreview.fromJson(Map json)
    : name = json['name'],
      avatarUrl = json['imageUrl'],
      id = json['id'];
}

class DetailedAuthorInfo extends UserProfile implements MessageAuthor {
  DetailedAuthorInfo({
    required super.id,
    required super.name,
    required super.username,
    required super.color,
    super.bio,
    super.phone,
    super.lastSeen,
    super.birthday,
    super.avatarUrl,
  });

  // fromJson constructor
  factory DetailedAuthorInfo.fromJson(Map<String, dynamic> json) {
    return DetailedAuthorInfo(
      name: json['name'],
      username: json['username'],
      color: json['color'],
      bio: json['bio'],
      phone: json['phone'],
      lastSeen: json['lastSeen'] != null
          ? DateTime.parse(json['lastSeen'])
          : null,
      birthday: json['birthday'] != null
          ? DateTime.parse(json['birthday'])
          : null,
      avatarUrl: json['avatarUrl'],
      id: json['id'],
    );
  }
}
