import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snackbar.dart';

class Login extends StatefulWidget {
  Login({super.key});
  static String id = 'LoginPage';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Image.asset("assets/images/scholar.png"),
                  const Text(
                    "Scholar Chat",
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico'),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Row(
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: "Email",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    obscureText: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: "Password",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser(FirebaseAuth.instance);
                          Navigator.pushReplacementNamed(context, ChatPage.id,
                              arguments: email);
                          //showSnackBar(context, 'success');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'wrong-password') {
                            showSnackBar(context, 'wrong password');
                          } else if (e.code == 'user-not-found') {
                            showSnackBar(context, 'The Account does not exist');
                            Navigator.pushNamed(context, "RegisterPage");
                          }
                        }
                      }
                    },
                    text: "LOGIN",
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?  ",
                        style: TextStyle(color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "RegisterPage");
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Color(0xffc7ede6)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser(FirebaseAuth auth) async {
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
