import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

enum AuthentificationState { pending, auth, unAuth, loading }

class AuthRepository {
  final _fb = FirebaseAuth.instance;
  late final StreamSubscription _authStateSubscription;

  BehaviorSubject<AuthentificationState> state = BehaviorSubject.seeded(
    .pending,
  );

  AuthRepository() {
    _authStateSubscription = _fb.authStateChanges().listen(_onStateChanged);
  }

  void dispose() {
    _authStateSubscription.cancel();
  }

  void _onStateChanged(User? u) {
    if (u != null) state.add(.auth);
    if (u == null) state.add(.unAuth);
  }


  Future<void> signInWithEmail(String email, String password) async {
    state.add(.loading);
    await _fb.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state.add(.loading);
    await _fb.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    throw UnimplementedError();
  }

  Future<void> signOut() async {
    await _fb.signOut();
  }
}
