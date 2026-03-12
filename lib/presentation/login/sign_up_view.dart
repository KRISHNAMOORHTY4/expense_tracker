import 'package:expense_tracker/constant/responsive.dart';
import 'package:expense_tracker/presentation/login/sign_up_viewmodel.dart';
import 'package:expense_tracker/utils/custom_flutter_toast.dart';
import 'package:expense_tracker/widgets/base_scaffold.dart';
import 'package:expense_tracker/widgets/custom_buttons.dart';
import 'package:expense_tracker/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpView extends ConsumerWidget {
  SignUpView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget otherSign({
      required IconData IconData,
      required VoidCallback onPressed,
    }) {
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
          child: IconButton(onPressed: onPressed, icon: Icon(IconData)),
        ),
      );
    }

    double screenWidth = MediaQuery.of(context).size.width;
    //signup provider
    final signUpProviderUi = ref.watch(signUpProvider);
    final signUpProviderRead = ref.read(signUpProvider.notifier);

    //error data provider
    final errorDataUi = ref.watch(errorData);

    return BaseScaffold(
      body: Center(
        child: SizedBox(
          width:
              Responsive.isMopile(context)
                  ? screenWidth / 1.1
                  : screenWidth / 1.5,
          child: Form(
            key: globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create your Account",
                  style: TextStyle(
                    fontSize: Responsive.isMopile(context) ? 17 : 19,
                  ),
                ),
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
                if (errorDataUi != null)
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          errorDataUi,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: Responsive.isMopile(context) ? 12 : 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                CustomButtons(
                  title: "Sign up",
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      signUpProviderRead.loadSignUp(
                        email: emailController.text,
                        password: passWordController.text,
                      );
                    }
                  },
                  isLoading: signUpProviderUi.when(
                    data: (data) => false,
                    error: (e, r) => false,
                    loading: () => true,
                  ),
                ),
                SizedBox(height: 40),
                Center(child: Text("Or sign up with")),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: otherSign(
                        IconData: FontAwesomeIcons.facebook,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: otherSign(
                        IconData: FontAwesomeIcons.google,
                        onPressed: () async {
                          try {
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            GoogleSignInAccount? selectedAccount =
                                await GoogleSignIn().signIn();

                            if (selectedAccount == null) {
                              print("No account");
                              return;
                            }
                            final getAccountData =
                                await selectedAccount.authentication;

                            final goggleAuthProvider =
                                GoogleAuthProvider.credential(
                                  idToken: getAccountData.idToken,
                                  accessToken: getAccountData.accessToken,
                                );

                            await auth.signInWithCredential(goggleAuthProvider);
                            CustomFlutterToast.toast(
                              content: "Login successfully",
                            );
                          } catch (e) {
                            print("ERROR:$e");
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: otherSign(
                        IconData: FontAwesomeIcons.twitter,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
