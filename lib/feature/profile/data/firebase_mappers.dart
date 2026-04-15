import 'package:chat_zxc/entities/profile.dart';

abstract class ProfileFirebaseMappers {
  static UserProfile profileFromMap(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      username: json['username'],
      name: json['displayName'],
      bio: json['bio'],
      phone: json['phone']
    );
  }
}
