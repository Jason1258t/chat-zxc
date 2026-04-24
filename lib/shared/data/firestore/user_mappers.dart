import 'package:chat_zxc/entities/user/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract final class UserProfileFields {
  static const id = 'id';
  static const username = 'username';
  static const displayName = 'displayName';
  static const avatarUrl = 'avatarUrl';
  static const bio = 'bio';
  static const phone = 'phone';
  static const color = 'color';
  static const lastSeen = 'lastSeen';
  static const birthday = 'birthday';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
  static const registrationCompleted = 'registrationCompleted';
}

extension UserProfileMapper on DocumentSnapshot<Map<String, dynamic>> {
  UserProfile toUserProfile() {
    final notNullData = data()!;

    return UserProfile(
      id: id,
      username: notNullData[UserProfileFields.username] as String,
      displayName: notNullData[UserProfileFields.displayName] as String,
      avatarUrl: notNullData[UserProfileFields.avatarUrl] as String?,
      bio: notNullData[UserProfileFields.bio] as String?,
      phone: notNullData[UserProfileFields.phone] as String?,
      color: notNullData[UserProfileFields.color] as String?,
      birthday: _parseBirthday(notNullData[UserProfileFields.birthday]),
      lastSeen: _parseTimestamp(notNullData[UserProfileFields.lastSeen]),
    );
  }
}

DateTime? _parseBirthday(dynamic value) {
  if (value == null) return null;
  if (value is String) {
    try {
      return DateTime.parse(value);
    } catch (e) {
      throw Exception(
        "Bad birthday value format, expected YYYY-MM-DD, got: $value",
      );
    }
  }
  return null;
}

DateTime? _parseTimestamp(dynamic value) {
  if (value == null) return null;

  if (value is Timestamp) {
    return value.toDate();
  }

  return null;
}
