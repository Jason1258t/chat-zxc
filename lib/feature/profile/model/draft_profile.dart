class DraftProfile {
  final String username;
  final String displayName;
  final bool registrationCompleted;

  DraftProfile(this.username, this.displayName, this.registrationCompleted);

  factory DraftProfile.fromMap(Map<String, dynamic> map) {
    return DraftProfile(
      map['username'] as String,
      map['displayName'] as String,
      map['registrationCompleted'] as bool
    );
  }
}