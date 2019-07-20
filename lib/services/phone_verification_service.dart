import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef void VerificationFailCallback(String verificationId);
typedef void VerificationSuccessCallback(String phoneNumber);
typedef void VerificationTimeoutCallback(String verificationId);

class PhoneVerificationService {
  PhoneVerificationService._();
  static final instance = PhoneVerificationService._();

  String verificationId;

  Future<void> attemptAutoVerify({
    @required phoneNumber,
    Duration timeout = const Duration(minutes: 2),
    @required VerificationFailCallback onFail,
    @required VerificationSuccessCallback onSuccess,
    @required VerificationTimeoutCallback onTimeout,
  }) async {
    assert(onFail != null);
    assert(onSuccess != null);
    assert(onTimeout != null);

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: timeout,
        phoneNumber: phoneNumber,
        codeSent: (String id, [int forceCodeResend]) {
          verificationId = id;
        },
        verificationFailed: (AuthException exception) {
          onFail(exception.message);
        },
        verificationCompleted: (FirebaseUser user) {
          onSuccess(user.phoneNumber);
        },
        codeAutoRetrievalTimeout: (String id) {
          verificationId = id;
          onTimeout(id);
        },
      );
    } on Exception catch (e) {
      onFail('Error occured: $e');
    }
  }

  Future<void> manualVerify({
    @required String smsCode,
    @required VerificationFailCallback onFail,
    @required VerificationSuccessCallback onSuccess,
  }) async {
    try {
      AuthCredential credential = PhoneAuthProvider.getCredential(
        smsCode: smsCode,
        verificationId: verificationId,
      );
      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      onSuccess(user.phoneNumber);
    } on Exception catch (e) {
      onFail('Error occured: $e');
    }
  }
}
