import 'package:chat_zxc/feature/users/cache/drift/cached_profile.dart';
import 'package:chat_zxc/feature/users/cache/drift/profiles_dao.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';


part 'app_database.g.dart';

@DriftDatabase(
  tables: [CachedProfiles],     // добавляй сюда все таблицы
  daos: [ProfilesDao],          // добавляй все DAO
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;   // увеличивай при миграциях

  // Опционально: миграции
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) => m.createAll(),
    onUpgrade: (Migrator m, int from, int to) async {
      // здесь логика миграций
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'chat_zxc_database', // имя файла .db
      native: DriftNativeOptions(
        // для Web можно добавить drift_web
      ),
    );
  }

  // Метод для закрытия БД (важно!)
  Future<void> close() async {
    await executor.close();
  }
}