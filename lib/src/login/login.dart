// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopin_app/src/login/modules/forgotpasswordfield.dart';
import 'package:shopin_app/src/login/modules/gotosignupfield.dart';
import 'package:shopin_app/src/styles/colors.dart';
import 'package:shopin_app/src/styles/constants.dart';
import 'package:shopin_app/src/utils/showSnackBar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool obscureText = true;

const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp emailRegExp = RegExp(
  emailPattern,
);

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

final FirebaseAuth _auth = FirebaseAuth.instance;

String email = "";
String password = "";
String errorMessage = "";

class _LoginState extends State<Login> {
  void validation() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
            .then((uid) => {
                  showSnackBar(
                    context,
                    "Login Successful",
                    kSuccessColor,
                  ),
                  setState(() {
                    const CircularProgressIndicator(
                      color: kSecondaryColor,
                    );
                  }),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Wrong email address was entered, try again.";

            break;
          case "wrong-password":
            errorMessage = "Wrong password was entered, try again.";
            break;
          case "user-not-found":
            errorMessage =
                "The account with this email and password does not exist.";
            break;
          case "user-disabled":
            errorMessage = "The user with this email has been banned.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "Something went wrong, try again later.";
        }

        showSnackBar(
          context,
          errorMessage,
          kErrorColor,
        ); // D
        return showSnackBar(
          context,
          error.code,
          kErrorColor,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      kHalfSizedBox,
                      TextFormField(
                        controller: emailController,
                        onChanged: (value) {
                          email = value;
                        },
                        onSaved: (newValue) {
                          emailController.text = newValue!;
                        },
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please fill in your Email";
                          } else if (!emailRegExp.hasMatch(value)) {
                            return "Email is invalid";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter your email",
                          labelText: "Email",
                          hintStyle: TextStyle(
                            color: kTextBlackColor,
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      TextFormField(
                        controller: passwordController,
                        onChanged: (value) {
                          password = value;
                        },
                        onSaved: (newValue) {
                          passwordController.text = newValue!;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.go,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please fill in your password";
                          } else if (value.length < 8) {
                            return "Password is too short";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Enter your password",
                          labelText: "Password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              obscureText = !obscureText;
                              FocusScope.of(context).unfocus();
                            },
                            child: obscureText
                                ? Icon(
                                    Icons.visibility,
                                    color: kPrimaryColor,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: kBlackColor,
                                  ),
                          ),
                          hintStyle: const TextStyle(
                            color: kTextBlackColor,
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      const ForgotPasswordField(),
                      kHalfSizedBox,
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            validation();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: kTextWhiteColor,
                            backgroundColor: kPrimaryColor,
                          ),
                          child: const Text(
                            "Login",
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      const GoToSignUpField(),
                      kSizedBox,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
