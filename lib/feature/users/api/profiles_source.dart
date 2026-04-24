import 'package:chat_zxc/entities/user/profile.dart';

abstract interface class ProfilesSource {
  Future<UserProfile?> loadUser(String uid);

  Future<List<UserProfile>> loadUsers(List<String> uids);

  Future<List<UserProfile>> findUsers(String query);
}
