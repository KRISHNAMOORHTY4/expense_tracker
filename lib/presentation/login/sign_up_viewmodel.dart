import 'dart:async';

import 'package:expense_tracker/presentation/login/sign_up_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final errorData = StateProvider<String?>((_) => null);

final signUpRepo = Provider((_) {
  return SignUpRepository();
});

class SignUpViewmodel extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> loadSignUp({
    required String email,
    required String password,
  }) async {
    try {
      ref.read(errorData.notifier).state = null;
      state = const AsyncLoading();
      final service = ref.read(signUpRepo);
      final res = await service.signUp(email: email, password: password);
      if (res) {
        state = AsyncData(res);
      }
    } on FirebaseAuthException catch (e) {
      state = AsyncData(false);
      final readData = ref.read(errorData.notifier);
      if (e.code == "invalid-email") {
        readData.state = "Enter a valid email";
      } else if (e.code == "email-already-in-use") {
        readData.state = "email-already-in-use";
      } else if (e.code == "weak-password") {
        readData.state = "Password should be at least 6 characters";
      }else{
        readData.state=e.code;
      }
    }
  }
}

final signUpProvider = AsyncNotifierProvider<SignUpViewmodel, bool>(
  SignUpViewmodel.new,
);
