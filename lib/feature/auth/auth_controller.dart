import 'package:chat_zxc/feature/profile/data/profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'data/auth_repository.dart';

part 'auth_controller.g.dart';

enum AuthStep {
  initial, // Запуск приложения
  unauthenticated, // Нужно ввести телефон
  needsProfile, // СМС подтвержден, но профиля нет
  authenticated, // Полный доступ к мессенджеру
  loading, // Процесс запросов
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository();
}

@riverpod
class AuthController extends _$AuthController {
  late final AuthRepository _authRepo;
  late final ProfileRepository _profileRepo;

  @override
  AuthStep build() {
    _authRepo = ref.watch(authRepositoryProvider);
    _profileRepo = ref.watch(profileRepositoryProvider);

    _authRepo.state.listen((firebaseState) {
      _handleFirebaseState(firebaseState);
    });

    return AuthStep.initial;
  }

  DraftProfile get draftProfile => _profileRepo.draftProfile!;

  Future<void> _handleFirebaseState(AuthentificationState firebaseState) async {
    switch (firebaseState) {
      case AuthentificationState.auth:
        final user = _authRepo.currentUser;
        if (user != null) {
          state = AuthStep.loading;
          final bool registrationCompleted;
          if (!await _profileRepo.profileExists(user.uid)) {
            registrationCompleted = false;
            await _profileRepo.createProfile(
              user.uid,
              _authRepo.currentUser!.phoneNumber!,
            );
          } else {
            registrationCompleted = await _profileRepo.registrationCompleted(
              user.uid,
            );
          }

          state = registrationCompleted
              ? AuthStep.authenticated
              : AuthStep.needsProfile;
        }
        break;
      case AuthentificationState.unAuth:
        state = AuthStep.unauthenticated;
        break;
      case AuthentificationState.loading:
        state = AuthStep.loading;
        break;
      case AuthentificationState.pending:
        state = AuthStep.initial;
        break;
    }
  }

  Future<void> sendCode(String phone) =>
      _authRepo.startPhoneVerification(phone);

  Future<void> verifyCode(String code) => _authRepo.confirmCode(code);

  Future<void> completeRegistration({
    required String username,
    required String displayName,
  }) async {
    final user = _authRepo.currentUser;
    if (user == null) return;

    state = AuthStep.loading;
    await _profileRepo.updateProfile(
      uid: user.uid,
      username: username,
      displayName: displayName,
    );
    state = AuthStep.authenticated;
  }
}
