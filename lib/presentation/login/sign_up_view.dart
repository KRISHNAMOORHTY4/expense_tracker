import 'package:expense_tracker/constant/responsive.dart';
import 'package:expense_tracker/widgets/base_scaffold.dart';
import 'package:expense_tracker/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    try {
      if (emailController.text == '' || passWordController.text == '') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Fill the all data")));
        return;
      }

      UserCredential getData = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: passWordController.text,
          );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Succesfully SignUp")));

      final String? token = await getData.user?.getIdToken();

      print("$token");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.code)));
      print("ERROR : ${e.code}");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget otherSign({required IconData IconData}) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.05),
            ),
          ],
        ),

        height: 60,

        child: Center(
          child: IconButton(onPressed: () {}, icon: Icon(IconData)),
        ),
      );
    }

    double screenWidth = MediaQuery.of(context).size.width;
    return BaseScaffold(
      body: Center(
        child: SizedBox(
          width:
              Responsive.isMopile(context)
                  ? screenWidth / 1.1
                  : screenWidth / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Create your Account", style: TextStyle(fontSize: 17)),
              SizedBox(height: 20),
              CustomTextField(
                title: "email",
                keyBoardType: TextInputType.text,
                controller: emailController,
              ),
              SizedBox(height: 20),

              CustomTextField(
                title: "Password",
                keyBoardType: TextInputType.text,
                controller: passWordController,
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth / 1.1,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [Color(0xFF2B2B2B), Color(0xFF000000)],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    // final getdata = FirebaseAuth.instance.currentUser;
                    // ScaffoldMessenger.of(
                    //   context,
                    // ).showSnackBar(SnackBar(content: Text(" $getdata")));
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: Responsive.isMopile(context) ? 16 : 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(child: Text("Or sign up with")),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: otherSign(IconData: FontAwesomeIcons.facebook),
                  ),
                  SizedBox(width: 20),
                  Expanded(child: otherSign(IconData: FontAwesomeIcons.google)),
                  SizedBox(width: 20),
                  Expanded(
                    child: otherSign(IconData: FontAwesomeIcons.twitter),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
