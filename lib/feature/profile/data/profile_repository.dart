import 'package:chat_zxc/shared/utils/name_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nanoid/nanoid.dart';

part 'profile_repository.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(firestore: FirebaseFirestore.instance);
}

class ProfileRepository {
  final FirebaseFirestore _firestore;

  ProfileRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  // Коллекция для профилей пользователей
  static const String _collection = 'profiles';

  /// Проверяет, существует ли профиль с заданным uid
  Future<bool> profileExists(String uid) async {
    try {
      final doc = await _firestore.collection(_collection).doc(uid).get();
      return doc.exists;
    } catch (e) {
      throw Exception('Ошибка проверки существования профиля: $e');
    }
  }

  /// Генерирует уникальный username (на основе nanoid)
  String _generateUniqueUsername() {
    final shortId = nanoid(20 - 4); // 16 символов + префикс "user"
    return "user$shortId";
  }

  /// Проверяет, занят ли username в коллекции (исключая текущий uid)
  Future<bool> _isUsernameTaken(String username, {String? excludeUid}) async {
    if (excludeUid == username) return false;
    try {
      Query query = _firestore
          .collection(_collection)
          .where('username', isEqualTo: username);
      final snapshot = await query.limit(1).get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Ошибка проверки уникальности username: $e');
    }
  }

  /// Создаёт профиль пользователя в Firestore
  Future<void> createProfile(
    String uid,
    String phoneNumber, {
    String? username,
    String? name,
  }) async {
    try {
      // 1. Уникальный username (если не передан)
      String finalUsername = username ?? _generateUniqueUsername();
      if (await _isUsernameTaken(finalUsername)) {
        throw Exception('Username "$finalUsername" уже занят');
      }

      final displayName = name ?? generateAbsurdNickend();

      final profileData = {
        'id': uid,
        'username': finalUsername,
        'displayName': displayName,
        'bio': '',
        'phone': phoneNumber,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await _firestore.collection(_collection).doc(uid).set(profileData);
    } catch (e) {
      throw Exception('Ошибка создания профиля: $e');
    }
  }

  /// Обновляет существующий профиль
  Future<void> updateProfile({
    required String uid,
    required String username,
    required String displayName,
  }) async {
    try {
      final exists = await profileExists(uid);
      if (!exists) {
        throw Exception('Profile with uid $uid not found');
      }

      if (await _isUsernameTaken(username, excludeUid: uid)) {
        throw Exception('Username "$username" already taken');
      }

      final updateData = {
        'username': username,
        'displayName': displayName,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await _firestore.collection(_collection).doc(uid).update(updateData);
    } catch (e) {
      throw Exception('Profile update error: $e');
    }
  }
}
