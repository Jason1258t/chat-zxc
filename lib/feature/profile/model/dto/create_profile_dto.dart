import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_profile_dto.freezed.dart';

part 'create_profile_dto.g.dart';

@freezed
abstract class CreateProfileDto with _$CreateProfileDto {
  const factory CreateProfileDto({
    required String uid,
    required String phoneNumber,
    required String username,
    required String displayName,
  }) = _CreateProfileDto;

  factory CreateProfileDto.fromJson(Map<String, dynamic> json) =>
      _$CreateProfileDtoFromJson(json);
}
