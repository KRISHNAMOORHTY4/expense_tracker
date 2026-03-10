import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/presentation/home/home_view.dart';
import 'package:expense_tracker/presentation/login/sign_up_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Poppins", textTheme: TextTheme()),
        home: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), builder:(context,snapShot){

          if(snapShot.connectionState==ConnectionState.waiting){
            return Scaffold(
              body:CircularProgressIndicator() ,
            );
          }else if(snapShot.hasData){
             print(snapShot.data);
            return HomeView();
          }else{
          return SignUpView();
          }
        })
      ),
    );
  }
}
