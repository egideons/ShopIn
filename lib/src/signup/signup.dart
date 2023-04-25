// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:shopin_app/src/signup/modules/gobacktologinfield.dart';
import 'package:shopin_app/src/styles/colors.dart';
import 'package:shopin_app/src/styles/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool obscureText = true;

const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

const String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

RegExp emailRegExp = RegExp(
  emailPattern,
);

RegExp phoneRegExp = RegExp(
  mobilePattern,
);

class _SignUpState extends State<SignUp> {
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
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    kHalfSizedBox,
                    Container(
                      height: 400,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please fill in your Username";
                              } //Min. of 3 characters
                              else if (value.length < 4) {
                                return "Username is too short";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter your username',
                              labelText: "Username",
                              hintStyle: TextStyle(
                                color: kBlackColor,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          kHalfSizedBox,
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
                              hintText: "Enter your email",
                              labelText: "Email",
                              hintStyle: TextStyle(
                                color: kBlackColor,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          kHalfSizedBox,
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please fill in your phone number";
                              } else if (!phoneRegExp.hasMatch(
                                value,
                              )) {
                                return "Phone number is invalid";
                              } else if (value.length < 10 ||
                                  value.length < 11) {
                                return "Phone number is too short";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter your phone number',
                              labelText: "Phone Number",
                              hintStyle: TextStyle(
                                color: kBlackColor,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          kHalfSizedBox,
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscureText: obscureText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please fill in your password";
                              } else if (value.length < 8) {
                                return "Password is too short";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
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
                                color: kBlackColor,
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
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
                                "Register",
                              ),
                            ),
                          ),
                          kHalfSizedBox,
                          const GoBackToLoginField(),
                          kHalfSizedBox,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
