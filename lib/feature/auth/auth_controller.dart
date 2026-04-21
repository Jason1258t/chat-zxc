import 'package:chat_zxc/feature/profile/data/profile_repository.dart';
import 'package:chat_zxc/feature/profile/model/draft_profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'data/auth_repository.dart';

part 'auth_controller.g.dart';

enum AuthStep { pending, unauthenticated, needsProfile, authenticated }

class AuthControllerState {
  final AuthStep step;
  final Exception? error;
  final bool loading;

  const AuthControllerState(this.step, {this.error, this.loading = false});

  AuthControllerState copyWith({
    AuthStep? step,
    Exception? error,
    bool? loading,
  }) {
    return AuthControllerState(
      step ?? this.step,
      error: error ?? this.error,
      loading: loading ?? this.loading,
    );
  }

  @override
  String toString() {
    return 'AuthControllerState\n{\n\tstep: $step,\n\tloading: $loading,\n\terror: $error\n}';
  }
}

@riverpod
AuthRepository authRepository(Ref ref) => AuthRepository();

@riverpod
class AuthController extends _$AuthController {
  late final AuthRepository _authRepo;
  late final ProfileRepository _profileRepo;

  DraftProfile? _profileDraft;

  @override
  AuthControllerState build() {
    _authRepo = ref.watch(authRepositoryProvider);
    _profileRepo = ref.watch(profileRepositoryProvider);

    _authRepo.state.listen((firebaseState) {
      _handleFirebaseState(firebaseState);
    });

    return const AuthControllerState(AuthStep.pending);
  }

  DraftProfile get draftProfile => _profileDraft!;

  void clearError() {
    state = state.copyWith(error: null);
  }

  Future<void> _handleFirebaseState(AuthentificationState firebaseState) async {
    switch (firebaseState) {
      case AuthentificationState.auth:
        await _processAuthState();
        break;
      case AuthentificationState.unAuth:
        state = state.copyWith(step: AuthStep.unauthenticated);
        break;
      case AuthentificationState.loading:
        state = state.copyWith(loading: true);
        break;
      case AuthentificationState.pending:
        state = state.copyWith(step: AuthStep.pending);
        break;
    }
  }

  Future<void> _processAuthState() async {
    final user = _authRepo.currentUser;
    if (user != null) {
      state = state.copyWith(loading: true);
      _profileDraft = await _profileRepo.getDraftProfile(user.uid);
      final bool registrationCompleted =
          _profileDraft?.registrationCompleted ?? false;

      _profileDraft ??= await _profileRepo.createProfile(
        user.uid,
        user.phoneNumber!,
      );

      state = state.copyWith(
        step: registrationCompleted
            ? AuthStep.authenticated
            : AuthStep.needsProfile,
        loading: false,
      );
    }
  }

  Future<void> sendCode(String phone) async {
    state = state.copyWith(loading: true, error: null);
    try {
      await _authRepo.startPhoneVerification(phone);
      state = state.copyWith(loading: false);
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  Future<void> verifyCode(String code) async {
    state = state.copyWith(loading: true, error: null);
    try {
      await _authRepo.confirmCode(code);
      // После подтверждения поток репозитория вызовет auth -> processAuthState
      state = state.copyWith(loading: false);
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  Future<void> completeRegistration({
    required String username,
    required String displayName,
  }) async {
    final user = _authRepo.currentUser;
    if (user == null) return;

    state = state.copyWith(loading: true);
    await _profileRepo.completeRegistration(
      uid: user.uid,
      username: username,
      displayName: displayName,
    );
    state = state.copyWith(step: AuthStep.authenticated, loading: false);
  }
}
