// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopin_app/screens/login/modules/forgotpasswordfield.dart';
import 'package:shopin_app/screens/login/modules/gotosignupfield.dart';
import 'package:shopin_app/splash%20screens/login_splashscreen.dart';
import 'package:shopin_app/styles/colors.dart';
import 'package:shopin_app/styles/constants.dart';
import 'package:shopin_app/utils/showSnackBar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//Firebase Authentication
final FirebaseAuth _auth = FirebaseAuth.instance;

bool isLoading = false;

const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp emailRegExp = RegExp(
  emailPattern,
);

final TextEditingController email = TextEditingController();
final TextEditingController userName = TextEditingController();
final TextEditingController password = TextEditingController();

bool obscureText = true;

class _LoginState extends State<Login> {
  String _password = "";

  //Error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kSecondaryColor,
        ),
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
                  height: 400,
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
                        controller: email,
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
                        controller: password,
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
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Enter your password",
                          labelText: "Password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
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
                        child: isLoading == false
                            ? ElevatedButton(
                                onPressed: (() async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      await _auth
                                          .signInWithEmailAndPassword(
                                            email: email.text,
                                            password: password.text,
                                          )
                                          .then((uid) => {
                                                showSnackBar(
                                                  context,
                                                  "Login Successful",
                                                  kSuccessColor,
                                                ),
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Login_SplashScreen(),
                                                  ),
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
                                          errorMessage =
                                              "Wrong email address was entered, check email.";

                                          break;
                                        case "wrong-password":
                                          errorMessage =
                                              "Wrong password was entered, check password.";
                                          break;
                                        case "user-not-found":
                                          errorMessage =
                                              "The account with this email and password does not exist.";
                                          break;
                                        case "user-disabled":
                                          errorMessage =
                                              "The user with this email has been banned.";
                                          break;
                                        case "too-many-requests":
                                          errorMessage = "Too many requests";
                                          break;
                                        case "operation-not-allowed":
                                          errorMessage =
                                              "Signing in with Email and Password is not enabled.";
                                          break;
                                        default:
                                          errorMessage =
                                              "Check your internet connection.";
                                      }

                                      showSnackBar(
                                        context,
                                        errorMessage!,
                                        kErrorColor,
                                      ); // D
                                      (error.code);
                                    }
                                  }
                                }),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: kTextWhiteColor,
                                  backgroundColor: kPrimaryColor,
                                ),
                                child: const Text(
                                  "Login",
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(),
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
