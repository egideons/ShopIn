// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shopin_app/src/login/modules/forgotpasswordfield.dart';
import 'package:shopin_app/src/login/modules/gotosignupfield.dart';
import 'package:shopin_app/src/styles/colors.dart';
import 'package:shopin_app/src/styles/constants.dart';

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

class _LoginState extends State<Login> {
  void validation() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print(
        "Validation successful",
      );
    } else {
      print(
        "Validation unsuccessful",
      );
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
                  height: 300,
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
                      TextFormField(
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
                      TextFormField(
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
                      const ForgotPasswordField(),
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
