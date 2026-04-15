import 'package:chat_zxc/shared/utils/timeAgo.dart';

class UserProfile {
  // Personal Channel
  // Profile photos

  final String id;
  final String name;
  final String? avatarUrl;
  final String? bio;
  final String username;
  final String? phone;
  final String? color;
  final DateTime? lastSeen;
  final DateTime? birthday;

  UserProfile({
    required this.id,
    required this.username,
    required this.name,
    this.color,
    this.bio,
    this.phone,
    this.lastSeen,
    this.birthday,
    this.avatarUrl,
  });
}

enum LastSeenDataType { shown, hidden }

class LastSeenData {
  final LastSeenDataType type;
  final String _rawData;

  LastSeenData({required this.type, required String data}) : _rawData = data;

  String get value {
    if (type == .shown) {
      return timeAgo(DateTime.parse(_rawData));
    }

    return _rawData;
  }
}
