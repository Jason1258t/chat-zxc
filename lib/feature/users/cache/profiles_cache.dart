import 'package:chat_zxc/entities/user/profile.dart';
import 'package:chat_zxc/feature/users/cache/drift/profiles_dao.dart';

import 'drift/profiles_cache_impl.dart';

abstract interface class ProfilesCache {
  factory ProfilesCache(ProfilesDao dao) => ProfilesCacheImpl(dao);

  Future<void> saveProfile(UserProfile profile);

  Future<void> saveProfiles(List<UserProfile> profiles);

  Future<UserProfile?> getProfile(String uid);

  /// Returns cached profiles for the given [uids].
  /// Only profiles that are already cached will be included.
  Future<List<UserProfile>> getProfilesList(List<String> uids);

  /// Allows searching profiles in cache to show instant
  /// results instead of waiting for the server.
  Future<List<UserProfile>> searchProfiles(String query);
}
