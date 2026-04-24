import 'package:chat_zxc/feature/users/cache/drift/profiles_dao.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_database.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
AppDatabase database(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
}

@Riverpod(keepAlive: true)
ProfilesDao profilesDao(Ref ref) {
  return ref.watch(databaseProvider).profilesDao;
}