// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopin_app/screens/login/modules/forgotpasswordfield.dart';
import 'package:shopin_app/screens/login/modules/gotosignupfield.dart';
import 'package:shopin_app/screens/signup/signup.dart';
import 'package:shopin_app/styles/colors.dart';
import 'package:shopin_app/styles/constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
  void submit(context) async {
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential result =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      print(result);
    } on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message!;
      }
      SnackBar(
        content: Text(message.toString()),
        duration: const Duration(
          milliseconds: 800,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      Text(error.toString());
      const Duration(
        milliseconds: 800,
      );
      Theme.of(context).primaryColor;
    }

    setState(() {
      isLoading = false;
    });
  }

  void validation() async {
    if (email.text.isEmpty && password.text.isEmpty) {
      const SnackBar(
        content: Text("Both Fields Are Empty"),
      );
    } else if (email.text.isEmpty) {
      const SnackBar(
        content: Text("Email Is Empty"),
      );
    } else if (!emailRegExp.hasMatch(email.text)) {
      const SnackBar(
        content: Text("Please Try Vaild Email"),
      );
    } else if (password.text.isEmpty) {
      const SnackBar(
        content: Text("Password Is Empty"),
      );
    } else if (password.text.length < 8) {
      const SnackBar(
        content: Text("Password  Is Too Short"),
      );
    } else {
      submit(context);
    }
  }

  String _password = "";

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
