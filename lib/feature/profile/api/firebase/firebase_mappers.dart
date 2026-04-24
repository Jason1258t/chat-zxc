import 'package:chat_zxc/feature/profile/model/dto/create_profile_dto.dart';
import 'package:chat_zxc/feature/profile/model/dto/complete_registration_dto.dart';
import 'package:chat_zxc/shared/data/firestore/user_mappers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension CompleteRegistrationDtoToMap on CompleteRegistrationDto {
  Map<String, dynamic> toFirestoreMap() {
    return {
      UserProfileFields.username: username,
      UserProfileFields.displayName: displayName,
      UserProfileFields.updatedAt: FieldValue.serverTimestamp(),
      UserProfileFields.registrationCompleted: true,
    };
  }
}

extension CreateProfileDtoToMap on CreateProfileDto {
  Map<String, dynamic> toFirestoreMap() {
    return {
      UserProfileFields.id: uid,
      UserProfileFields.phone: phoneNumber,
      UserProfileFields.username: username,
      UserProfileFields.displayName: displayName,
      UserProfileFields.updatedAt: FieldValue.serverTimestamp(),
      UserProfileFields.createdAt: FieldValue.serverTimestamp(),
      UserProfileFields.registrationCompleted: false,
    };
  }
}
