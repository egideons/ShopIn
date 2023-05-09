// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopin_app/app/screens/login/components/firsthalf.dart';
import 'package:shopin_app/app/screens/login/components/forgotpasswordfield.dart';
import 'package:shopin_app/app/screens/login/components/gotosignupfield.dart';
import 'package:shopin_app/app/screens/login/components/loginCustomTextField.dart';
import 'package:shopin_app/app/splash%20screens/login_splashscreen.dart';
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

final TextEditingController emailController = TextEditingController();
final TextEditingController userNameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

bool obscureText = true;

class _LoginState extends State<Login> {
  final String _password = "";

  //Error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            const LoginPageFirstHalf(),
            kHalfSizedBox,
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                    Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              LoginCustomTextFormField(
                                formValidator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your email address";
                                  } else if (!RegExp(
                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
                                  ).hasMatch(value)) {
                                    return "Please enter a valid email address";
                                  }
                                  return null;
                                },
                                controller: emailController,
                                onSaved: (value) {
                                  emailController.text = value!;
                                },
                                hintText: "Enter your email address",
                                labelText: "Email Address",
                                keyboadType: TextInputType.emailAddress,
                                obscureText: false,
                                prefixIcon: const Icon(
                                  Icons.email_rounded,
                                  color: kSecondaryColor,
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              LoginCustomTextFormField(
                                formValidator: (value) {
                                  RegExp passwordPattern = RegExp(
                                    r'^.{8,}$',
                                  );
                                  if (value!.isEmpty) {
                                    return "Enter your password";
                                  } else if (!passwordPattern.hasMatch(value)) {
                                    return "Password must be at least 8 characters";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  passwordController.text = value!;
                                },
                                controller: passwordController,
                                hintText: "Enter your password",
                                labelText: "Password",
                                keyboadType: TextInputType.visiblePassword,
                                obscureText: true,
                                prefixIcon: const Icon(
                                  Icons.password_rounded,
                                  color: kSecondaryColor,
                                ),
                                textInputAction: TextInputAction.done,
                              ),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              const ForgotPasswordField(),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: (() async {
                                    setState(() {
                                      const CircularProgressIndicator(
                                        color: kSecondaryColor,
                                      );
                                    });
                                    if (_formKey.currentState!.validate()) {
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
                                                    kPrimaryColor,
                                                  ),
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Login_SplashScreen(),
                                                    ),
                                                  ),
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
                                    foregroundColor: kPrimaryColor,
                                    backgroundColor: kSecondaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    "Login",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: kDefaultPadding / 2,
                              ),
                            ],
                          ),
                        ),
                        const GoToSignUpField(),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
