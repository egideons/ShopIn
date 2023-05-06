// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopin_app/model/usermodel.dart';
import 'package:shopin_app/screens/signup/components/firsthalf.dart';
import 'package:shopin_app/screens/signup/components/gobacktologinfield.dart';
import 'package:shopin_app/screens/signup/components/signupCustomTextField.dart';
import 'package:shopin_app/splash%20screens/signup_splashscreen.dart';
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
final TextEditingController emailController = TextEditingController();
final TextEditingController userNameController = TextEditingController();
final TextEditingController phoneNumberController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();
final TextEditingController addressController = TextEditingController();

bool isMale = true;
bool isLoading = false;

class _SignUpState extends State<SignUp> {
  //Error Message
  String? errorMessage;

  //Firebase Authentication
  final _auth = FirebaseAuth.instance;

  postUserDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sendiing these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(
        builder: (context) => const Signup_SplashScreen(),
      ),
      (route) => false,
    );
    // writing all the values
    userModel.userEmail = user!.email;
    userModel.userId = user.uid;
    userModel.userName = userNameController.text;
    userModel.userPhoneNumber = phoneNumberController.text;
    userModel.userPassword = passwordController.text;
    userModel.userAddress = addressController.text;
    userModel.userGender = isMale == true ? "Male" : "Female";

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    showSnackBar(
      context,
      "Your account has been successfully registered",
      kSecondaryColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            const SignupPageFirstHalf(),
            kHalfSizedBox,
            Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    kDefaultPadding * 3,
                  ),
                  topRight: Radius.circular(
                    kDefaultPadding * 3,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                  kDefaultPadding,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SignupCustomTextFormField(
                            controller: userNameController,
                            keyboadType: TextInputType.name,
                            hintText: "Enter your Username",
                            labelText: "Username",
                            obscureText: false,
                            onSaved: (value) {
                              userNameController.text = value!;
                            },
                            formValidator: (value) {
                              RegExp firstNamePattern = RegExp(
                                r'^.{3,}$',
                              );
                              if (value!.isEmpty) {
                                return "Please enter your first name";
                              } else if (!firstNamePattern.hasMatch(value)) {
                                return "Enter your first name(Min. of 3 characters)";
                              }
                              return null;
                            },
                            prefixIcon: const Icon(
                              Icons.account_circle,
                              color: kSecondaryColor,
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          kSizedBox,
                          SignupCustomTextFormField(
                            controller: emailController,
                            keyboadType: TextInputType.emailAddress,
                            hintText: "Enter your email address",
                            labelText: "Email Address",
                            obscureText: false,
                            onSaved: (value) {
                              emailController.text = value!;
                            },
                            formValidator: (value) {
                              RegExp emailPattern = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                              );
                              if (value!.isEmpty) {
                                return "Enter your email address";
                              } else if (!emailPattern.hasMatch(value)) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                            prefixIcon: const Icon(
                              Icons.email,
                              color: kSecondaryColor,
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          kSizedBox,
                          SignupCustomTextFormField(
                            controller: phoneNumberController,
                            keyboadType: TextInputType.phone,
                            hintText: "Enter your phone number",
                            labelText: "Phone Number",
                            obscureText: false,
                            onSaved: (value) {
                              phoneNumberController.text = value!;
                            },
                            formValidator: (value) {
                              RegExp mobilePattern = RegExp(
                                r'(^(?:[+0]9)?[0-9]{10,12}$)',
                              );

                              if (value!.isEmpty) {
                                return "Enter your phone number";
                              } else if (!mobilePattern.hasMatch(value)) {
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                            prefixIcon: const Icon(
                              Icons.phone_rounded,
                              color: kSecondaryColor,
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          kSizedBox,
                          SignupCustomTextFormField(
                            controller: addressController,
                            keyboadType: TextInputType.streetAddress,
                            labelText: "Address",
                            hintText: "Enter your address",
                            obscureText: false,
                            onSaved: (value) {
                              addressController.text = value!;
                            },
                            prefixIcon: const Icon(
                              Icons.house_sharp,
                              color: kSecondaryColor,
                            ),
                            textInputAction: TextInputAction.next,
                            formValidator: (value) {
                              RegExp addressPattern = RegExp(
                                r'^[#.0-9a-zA-Z\s,-]+$',
                              );

                              if (value!.isEmpty) {
                                return "Enter your address";
                              } else if (!addressPattern.hasMatch(value)) {
                                return "Enter a valid address";
                              }
                              return null;
                            },
                          ),
                          kSizedBox,
                          SignupCustomTextFormField(
                            controller: passwordController,
                            keyboadType: TextInputType.visiblePassword,
                            hintText: "Enter your password",
                            labelText: "Password",
                            obscureText: true,
                            onSaved: (value) {
                              passwordController.text = value!;
                            },
                            formValidator: (value) {
                              RegExp passwordPattern = RegExp(
                                r'^.{8,}$',
                              );
                              if (value!.isEmpty) {
                                return "Please enter your password";
                              } else if (!passwordPattern.hasMatch(value)) {
                                return "Password must be at least 8 characters";
                              }
                              return null;
                            },
                            prefixIcon: const Icon(
                              Icons.password_rounded,
                              color: kSecondaryColor,
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          kSizedBox,
                          SignupCustomTextFormField(
                            controller: confirmPasswordController,
                            keyboadType: TextInputType.visiblePassword,
                            hintText: "Confirm your password",
                            labelText: "Confirm password",
                            obscureText: true,
                            onSaved: (value) {
                              confirmPasswordController.text = value!;
                            },
                            formValidator: (value) {
                              if (value!.isEmpty) {
                                return "Please confirm your password";
                              } else if (confirmPasswordController.text !=
                                  passwordController.text) {
                                return "Password does not match";
                              }
                              return null;
                            },
                            prefixIcon: const Icon(
                              Icons.password_rounded,
                              color: kSecondaryColor,
                            ),
                            textInputAction: TextInputAction.done,
                          ),
                          kSizedBox,
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
                                border: Border.all(
                                  color: kSecondaryColor,
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Text(
                                      isMale == true ? "Male" : "Female",
                                      style: const TextStyle(
                                        color: kTextWhiteColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                    isMale == true
                                        ? const Icon(
                                            Icons.male,
                                            color: kSecondaryColor,
                                          )
                                        : const Icon(
                                            Icons.female,
                                            color: kSecondaryColor,
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          kSizedBox,
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await _auth
                                        .createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        )
                                        .then(
                                          (value) =>
                                              {postUserDetailsToFirestore()},
                                        )
                                        .catchError((e) {
                                      showSnackBar(
                                          context, e.message, kSecondaryColor);
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
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: kPrimaryColor,
                                backgroundColor: kSecondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Register",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    const GoBackToLoginField(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
