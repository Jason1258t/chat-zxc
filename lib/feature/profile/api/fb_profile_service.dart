import 'package:chat_zxc/feature/profile/model/dto/create_profile_dto.dart';
import 'package:chat_zxc/feature/profile/model/dto/complete_registration_dto.dart';
import 'package:chat_zxc/shared/data/firestore/user_mappers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_zxc/app/firebase/config.dart';
import 'package:chat_zxc/feature/profile/model/draft_profile.dart';

import 'firebase_mappers.dart';
import 'profile_service.dart';

Map<String, dynamic> _singleFieldUpdate(
    String field,
    dynamic value,
    ) {
  return {
    field: value,
    UserProfileFields.updatedAt:
    FieldValue.serverTimestamp(),
  };
}

class FirebaseProfileService implements ProfileService {
  final FirebaseFirestore _firestore;
  static const String _collection = FirebaseCollectionNames.profiles;

  FirebaseProfileService({required FirebaseFirestore firestore})
    : _firestore = firestore;

  @override
  Future<bool> profileExists(String uid) async {
    try {
      final doc = await _firestore.collection(_collection).doc(uid).get();
      return doc.exists;
    } catch (e) {
      throw Exception('Profile check error: $e');
    }
  }

  @override
  Future<DraftProfile?> getDraftProfile(String uid) async {
    try {
      final doc = await _firestore.collection(_collection).doc(uid).get();
      if (!doc.exists) return null;
      final data = doc.data()!;
      return DraftProfile(
        data[UserProfileFields.username] as String,
        data[UserProfileFields.displayName] as String,
        data[UserProfileFields.registrationCompleted] as bool? ?? false,
      );
    } catch (e) {
      throw Exception('Draft getting error: $e');
    }
  }

  @override
  Future<void> createProfile(CreateProfileDto dto) async {
    try {
      final profileData = dto.toFirestoreMap();
      await _firestore.collection(_collection).doc(dto.uid).set(profileData);
    } catch (e) {
      throw Exception('Profile creating error: $e');
    }
  }

  @override
  Future<void> completeRegistration(
    CompleteRegistrationDto dto,
    String uid,
  ) async {
    try {
      final updateData = dto.toFirestoreMap();
      await _firestore.collection(_collection).doc(uid).update(updateData);
    } catch (e) {
      throw Exception('Profile update error: $e');
    }
  }

  @override
  Future<bool> isUsernameTaken(String username, {String? excludeUid}) async {
    try {
      Query query = _firestore
          .collection(_collection)
          .where(UserProfileFields.username, isEqualTo: username);

      if (excludeUid != null) {
        query = query.where(UserProfileFields.id, isNotEqualTo: excludeUid);
      }

      final snapshot = await query.limit(1).get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error during username checking: $e');
    }
  }

  @override
  Future<void> refreshLastSeen(String uid) {
    // TODO: implement refreshLastSeen
    throw UnimplementedError();
  }

  @override
  Future<void> updateAvatarUrl(String uid, String? avatarUrl) {
    // TODO: implement updateAvatarUrl
    throw UnimplementedError();
  }

  @override
  Future<void> updateBio(String uid, String? bio) {
    // TODO: implement updateBio
    throw UnimplementedError();
  }

  @override
  Future<void> updateBirthday(String uid, DateTime? birthday) {
    // TODO: implement updateBirthday
    throw UnimplementedError();
  }

  @override
  Future<void> updateColor(String uid, String? color) {
    // TODO: implement updateColor
    throw UnimplementedError();
  }

  @override
  Future<void> updateDisplayName(String uid, String displayName) {
    // TODO: implement updateDisplayName
    throw UnimplementedError();
  }

  @override
  Future<void> updatePhone(String uid, String? phone) {
    // TODO: implement updatePhone
    throw UnimplementedError();
  }

  @override
  Future<void> updateUsername(String uid, String username) {
    // TODO: implement updateUsername
    throw UnimplementedError();
  }
}
