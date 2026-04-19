import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_registration_dto.freezed.dart';
part 'complete_registration_dto.g.dart';

@freezed
abstract class CompleteRegistrationDto with _$CompleteRegistrationDto {
  const factory CompleteRegistrationDto({
    required String username,
    required String displayName,
  }) = _CompleteRegistrationDto;

  factory CompleteRegistrationDto.fromJson(
      Map<String, dynamic> json,
      ) => _$CompleteRegistrationDtoFromJson(json);
}

