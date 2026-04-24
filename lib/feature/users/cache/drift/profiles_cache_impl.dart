import 'package:chat_zxc/entities/user/profile.dart';
import 'package:drift/drift.dart';
import 'package:chat_zxc/app/database/app_database.dart';

import '../profiles_cache.dart';
import 'profiles_dao.dart';

class ProfilesCacheImpl implements ProfilesCache {
  final ProfilesDao _dao;

  ProfilesCacheImpl(this._dao);

  @override
  Future<void> saveProfile(UserProfile profile) async {
    await _dao.upsertProfile(_toCompanion(profile));
  }

  @override
  Future<void> saveProfiles(List<UserProfile> profiles) async {
    if (profiles.isEmpty) return;
    final companions = profiles.map(_toCompanion).toList();
    await _dao.upsertProfiles(companions);
  }

  @override
  Future<UserProfile?> getProfile(String uid) async {
    final row = await _dao.findByUid(uid);
    return row?.toDomain();
  }

  @override
  Future<List<UserProfile>> getProfilesList(List<String> uids) async {
    if (uids.isEmpty) return [];
    final rows = await _dao.findByUids(uids);
    return rows.map((row) => row.toDomain()).toList();
  }

  @override
  Future<List<UserProfile>> searchProfiles(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final rows = await _dao.search(trimmed);
    return rows.map((row) => row.toDomain()).toList();
  }

  CachedProfilesCompanion _toCompanion(UserProfile p) {
    return CachedProfilesCompanion.insert(
      uid: p.id,
      username: p.username,
      displayName: p.displayName,
      avatarUrl: Value(p.avatarUrl),
      color: Value(p.color),
      lastSeen: Value(p.lastSeen),
      updatedAt: DateTime.now(),
    );
  }
}

extension on CachedProfile {
  UserProfile toDomain() {
    return UserProfile(
      id: uid,
      username: username,
      displayName: displayName,
      avatarUrl: avatarUrl,
      color: color,
      lastSeen: lastSeen,
    );
  }
}