part of 'auth_controller.dart';

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

  AuthControllerState clearError() =>
      AuthControllerState(step, loading: loading, error: null);

  @override
  String toString() {
    return 'AuthControllerState\n{\n\tstep: $step,\n\tloading: $loading,\n\terror: $error\n}';
  }
}
