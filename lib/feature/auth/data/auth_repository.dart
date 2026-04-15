import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

enum AuthentificationState { pending, auth, unAuth, loading }

class PhoneVerificationData {
  String? verificationId;
  int? resendToken;
  DateTime? lastPhoneVerificationAttemptAt;
  String? lastPhoneVerificationAttemptPhone;

  void onCodeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    this.resendToken = resendToken;
  }

  void registerVerificationAttempt(String phone) {
    lastPhoneVerificationAttemptAt = DateTime.now();
    lastPhoneVerificationAttemptPhone = phone;
  }
}

class AuthRepository {
  final _fb = FirebaseAuth.instance;
  late final StreamSubscription _authStateSubscription;

  PhoneVerificationData? _phoneVerificationData;

  BehaviorSubject<AuthentificationState> state = BehaviorSubject.seeded(
    .pending,
  );

  User? get currentUser => _fb.currentUser;

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

  Future<void> startPhoneVerification(String phone) async {
    await _fb.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: _signInWithCredentials,
      forceResendingToken: _phoneVerificationData?.resendToken,
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          log('The provided phone number is not valid.');
          return;
        }

        log(e.toString());
      },
      codeSent: _onCodeSent,
      codeAutoRetrievalTimeout: (String verificationId) =>
          _onCodeSent(verificationId, null),
    );
  }

  Future<void> confirmCode(String code) async {
    if (_phoneVerificationData?.verificationId == null) {
      throw Exception("Empty verification data");
    }

    final cred = PhoneAuthProvider.credential(
      verificationId: _phoneVerificationData!.verificationId!,
      smsCode: code,
    );

    await _signInWithCredentials(cred);
  }

  void _onCodeSent(String verificationId, int? resendToken) async {
    _phoneVerificationData ??= PhoneVerificationData();
    _phoneVerificationData!.onCodeSent(verificationId, resendToken);
  }

  Future<void> _signInWithCredentials(AuthCredential credential) async {
    state.add(.loading);
    await _fb.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _fb.signOut();
  }
}
