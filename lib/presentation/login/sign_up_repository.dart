import 'package:firebase_auth/firebase_auth.dart';

class SignUpRepository {
  Future<bool> signUp({required String email, required String password}) async {
    try {
      UserCredential getData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}
  