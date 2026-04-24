part of 'profile_controller.dart';

class ProfileControllerState {
  final UserProfile profile;
  final bool isEditing;

  ProfileControllerState({required this.profile, this.isEditing = false});

  ProfileControllerState copyWith({UserProfile? profile, bool? isEditing}) {
    return ProfileControllerState(
      profile: profile ?? this.profile,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}
