import 'package:drift/drift.dart';
import 'package:chat_zxc/app/database/app_database.dart';
import 'package:chat_zxc/entities/user/profile.dart';

import 'cached_profile.dart';

part 'profiles_dao.g.dart';

@DriftAccessor(tables: [CachedProfiles])
class ProfilesDao extends DatabaseAccessor<AppDatabase> with _$ProfilesDaoMixin {
  ProfilesDao(super.db);

  Future<void> upsertProfile(CachedProfilesCompanion companion) async {
    await into(cachedProfiles).insertOnConflictUpdate(companion);
  }

  Future<void> upsertProfiles(List<CachedProfilesCompanion> companions) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(cachedProfiles, companions);
    });
  }

  Future<CachedProfile?> findByUid(String uid) {
    return (select(cachedProfiles)..where((tbl) => tbl.uid.equals(uid))).getSingleOrNull();
  }

  Future<List<CachedProfile>> findByUids(List<String> uids) {
    return (select(cachedProfiles)..where((tbl) => tbl.uid.isIn(uids))).get();
  }

  Future<List<CachedProfile>> search(String query) {
    final normalized = query.toLowerCase();
    return (select(cachedProfiles)
      ..where(
            (tbl) =>
        tbl.displayName.lower().like('%$normalized%') |
        tbl.username.lower().like('%$normalized%'),
      ))
        .get();
  }
}

