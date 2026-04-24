import 'package:chat_zxc/entities/user/profile.dart';
import 'package:drift/drift.dart';

class CachedProfiles extends Table {
  TextColumn get uid => text().withLength(min: 1, max: 32)();

  TextColumn get username =>
      text().withLength(min: 1, max: UserProfile.maxUsernameLength)();

  TextColumn get displayName => text()();

  TextColumn get avatarUrl => text().nullable()();

  TextColumn get color => text().nullable()();

  DateTimeColumn get lastSeen => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {uid};
}
