import 'dart:developer';

import 'package:chat_zxc/entities/user/profile.dart';
import 'package:chat_zxc/feature/auth/auth_controller.dart';
import 'package:chat_zxc/feature/profile/api/firebase/fb_profile_service.dart';
import 'package:chat_zxc/feature/profile/api/profile_service.dart';
import 'package:chat_zxc/feature/profile/model/draft_profile.dart';
import 'package:chat_zxc/feature/profile/model/dto/create_profile_dto.dart';
import 'package:chat_zxc/feature/profile/model/dto/complete_registration_dto.dart';
import 'package:chat_zxc/shared/utils/name_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nanoid/nanoid.dart';

part 'profile_repository.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) {
  final uid = ref.watch(authRepositoryProvider).currentUser?.uid;
  final fs = FirebaseFirestore.instance;

  return ProfileRepository(
    profileService: FirebaseProfileService(firestore: fs),
    uid: uid,
  );
}

class ProfileCache {
  UserProfile? _data;
  DateTime _lastUpdate;

  UserProfile get data {
    if (_data == null) throw Exception('Profile cache data is empty');
    return _data!;
  }

  ProfileCache() : _lastUpdate = DateTime.now();

  void refresh(UserProfile data) {
    _data = data;
    _lastUpdate = DateTime.now();
  }

  static const _cacheLifetime = Duration(minutes: 2);

  bool get isExpired => DateTime.now().difference(_lastUpdate) > _cacheLifetime;

  bool get hasData => _data != null;

  bool get hasAvailableData => hasData && !isExpired;
}

class ProfileRepository {
  final ProfileService _profileService;
  final String? _uid;

  final ProfileCache _cache;

  ProfileRepository({
    required ProfileService profileService,
    required String? uid,
  }) : _profileService = profileService,
       _uid = uid,
       _cache = ProfileCache();

  Future<bool> profileExists(String uid) => _profileService.profileExists(uid);

  Future<DraftProfile?> getDraftProfile(String uid) async {
    final draft = await _profileService.getDraftProfile(uid);
    return draft;
  }

  String _generateUniqueUsername() {
    const prefix = 'user';
    final shortId = nanoid(UserProfile.maxUsernameLength - prefix.length);
    return prefix + shortId;
  }

  Future<DraftProfile> createProfile(
    String uid,
    String phoneNumber, {
    String? username,
    String? name,
  }) async {
    String finalUsername = username ?? _generateUniqueUsername();
    if (await _profileService.isUsernameTaken(finalUsername)) {
      throw Exception('Username "$finalUsername" has already taken');
    }

    final displayName = name ?? generateAbsurdNickend();

    await _profileService.createProfile(
      CreateProfileDto(
        uid: uid,
        phoneNumber: phoneNumber,
        username: finalUsername,
        displayName: displayName,
      ),
    );

    final profile = await _profileService.getDraftProfile(uid);
    return profile!;
  }

  Future<void> completeRegistration({
    required String uid,
    required String username,
    required String displayName,
  }) async {
    try {
      if (await _profileService.isUsernameTaken(username, excludeUid: uid)) {
        throw Exception('Username "$username" already taken');
      }

      await _profileService.completeRegistration(
        CompleteRegistrationDto(username: username, displayName: displayName),
        uid,
      );
    } catch (e) {
      throw Exception('Complete registration error: $e');
    }
  }

  Future<UserProfile> getProfile({bool refresh = false}) async {
    if (_uid == null) throw Exception("Client not authenticated");
    if (!_cache.hasAvailableData || refresh) {
      final profile = await _profileService.getFullProfile(_uid);
      _cache.refresh(profile);
    }
    return _cache.data;
  }
}
