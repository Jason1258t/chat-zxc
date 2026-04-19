import 'package:chat_zxc/feature/profile/model/draft_profile.dart';
import 'package:chat_zxc/feature/profile/model/dto/create_profile_dto.dart';
import 'package:chat_zxc/feature/profile/model/dto/complete_registration_dto.dart';

abstract interface class ProfileService {
  Future<bool> profileExists(String uid);

  /// Возвращает черновик профиля, с пометкой о том, является ли он завершенным
  Future<DraftProfile?> getDraftProfile(String uid);

  Future<void> createProfile(CreateProfileDto dto);

  Future<bool> isUsernameTaken(String username, {String? excludeUid});

  Future<void> completeRegistration(CompleteRegistrationDto dto, String uid);

  Future<void> updateDisplayName(String uid, String displayName);

  Future<void> updateUsername(String uid, String username);

  Future<void> updateBio(String uid, String? bio);

  Future<void> updateAvatarUrl(String uid, String? avatarUrl);

  Future<void> updatePhone(String uid, String? phone);

  Future<void> updateColor(String uid, String? color);

  Future<void> updateBirthday(String uid, DateTime? birthday);

  /// Обновляет last seen на текущее время
  Future<void> refreshLastSeen(String uid);
}
