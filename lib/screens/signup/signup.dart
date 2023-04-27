// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopin_app/screens/signup/modules/gobacktologinfield.dart';
import 'package:shopin_app/styles/colors.dart';
import 'package:shopin_app/styles/constants.dart';
import 'package:shopin_app/utils/showSnackBar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp emailRegExp = RegExp(
  emailPattern,
);

const String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

RegExp phoneRegExp = RegExp(
  mobilePattern,
);

bool obscureText = true;
final TextEditingController email = TextEditingController();
final TextEditingController userName = TextEditingController();
final TextEditingController phoneNumber = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController address = TextEditingController();

bool isMale = true;
bool isLoading = false;

class _SignUpState extends State<SignUp> {
  //Error Message
  String? errorMessage;

  //Firebase Authentication
  final _auth = FirebaseAuth.instance;

  postUserDetailsToFirestore() async {
    // calling our firestore
    UserCredential? result;

    FirebaseFirestore.instance.collection("User").doc(result!.user?.uid).set({
      "UserName": userName.text,
      "UserId": result.user?.uid,
      "userEmail": email.text,
      "userAddress": address.text,
      "userGender": isMale == true ? "Male" : "Female",
      "UserNumber": phoneNumber.text,
    });
    showSnackBar(
      context,
      "Your account has been successfully registered",
      kSuccessColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kSecondaryColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
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
                  Container(
                    height: 540,
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
                            } else if (value.length < 10 && value.length > 11) {
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
                          controller: password,
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
                              color: kBlackColor,
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        kHalfSizedBox,
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isMale = !isMale;
                            });
                          },
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.only(left: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    isMale == true ? "Male" : "Female",
                                    style: const TextStyle(
                                      color: kTextGreyColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                  isMale == true
                                      ? const Icon(
                                          Icons.male,
                                          color: kGreyColor1,
                                        )
                                      : const Icon(
                                          Icons.female,
                                          color: kGreyColor1,
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        kHalfSizedBox,
                        SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: isLoading == false
                              ? ElevatedButton(
                                  onPressed: () {
                                    (() async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          await _auth
                                              .createUserWithEmailAndPassword(
                                                email: email.text,
                                                password: password.text,
                                              )
                                              .then(
                                                (value) => {
                                                  setState(() {
                                                    const CircularProgressIndicator(
                                                      color: kSecondaryColor,
                                                    );
                                                  }),
                                                  postUserDetailsToFirestore()
                                                },
                                              )
                                              .catchError((e) {
                                            showSnackBar(context, e.message,
                                                kPrimaryColor);
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
                                              errorMessage =
                                                  "Too many requests";
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
                                          return (error.code);
                                        }
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: kTextWhiteColor,
                                    backgroundColor: kPrimaryColor,
                                  ),
                                  child: const Text(
                                    "Register",
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
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
    );
  }
}
