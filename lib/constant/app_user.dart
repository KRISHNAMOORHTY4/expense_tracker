import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  User? currentUser = FirebaseAuth.instance.currentUser;
  String get auth => currentUser?.email ?? 'krishna';
}
