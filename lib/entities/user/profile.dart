import 'package:chat_zxc/shared/utils/timeAgo.dart';

part 'last_seen.dart';

class UserProfile {
  // Personal Channel
  // Profile photos

  static const maxUsernameLength = 20;

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
