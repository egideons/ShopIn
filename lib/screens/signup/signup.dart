// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopin_app/screens/signup/modules/gobacktologinfield.dart';
import 'package:shopin_app/styles/colors.dart';
import 'package:shopin_app/styles/constants.dart';
import 'package:shopin_app/widgets/mybutton.dart';
import 'package:shopin_app/widgets/mytextformField.dart';
import 'package:shopin_app/widgets/passwordtextformfield.dart';

import '../home/homepage.dart';

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
  void submit() async {
    UserCredential? result;
    try {
      setState(() {
        isLoading = true;
      });
      result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      print(result);
    } on PlatformException catch (error) {
      String? message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message;
      }
      SnackBar(
        content: Text(message.toString()),
        duration: const Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      SnackBar(
        content: Text(error.toString()),
        duration: const Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      );

      print(error);
    }
    FirebaseFirestore.instance.collection("User").doc(result?.user!.uid).set({
      "UserName": userName.text,
      "UserId": result?.user!.uid,
      "UserEmail": email.text,
      "UserAddress": address.text,
      "UserGender": isMale == true ? "Male" : "Female",
      "UserNumber": phoneNumber.text,
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const HomePage(),
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  void validation() async {
    if (userName.text.isEmpty &&
        email.text.isEmpty &&
        password.text.isEmpty &&
        phoneNumber.text.isEmpty &&
        address.text.isEmpty) {
      const SnackBar(
        content: Text("All Fields Are Empty"),
      );
    } else if (userName.text.length < 6) {
      const SnackBar(
        content: Text("Username Must Be more than 6 characters"),
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
    } else if (phoneNumber.text.length < 10 || phoneNumber.text.length > 11) {
      const SnackBar(
        content: Text("Phone Number Must Be 11 "),
      );
    } else if (address.text.isEmpty) {
      const SnackBar(
        content: Text("Adress Is Empty "),
      );
    } else {
      submit();
    }
  }

  String? _password;

  Widget _buildAllTextFormField() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MyTextFormField(
            textInputAction: TextInputAction.next,
            labelText: "Enter your username",
            hintText: "Username",
            textInputType: TextInputType.name,
            controller: userName,
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextFormField(
            textInputAction: TextInputAction.next,
            labelText: "Enter your email",
            hintText: "Email",
            textInputType: TextInputType.emailAddress,
            controller: email,
          ),
          const SizedBox(
            height: 10,
          ),
          PasswordTextFormField(
            obscureText: obscureText,
            controller: password,
            labelText: "Enter your password",
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            hintText: "Password",
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
          ),
          const SizedBox(
            height: 10,
          ),
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
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      isMale == true ? "Male" : "Female",
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextFormField(
            textInputAction: TextInputAction.next,
            labelText: "Enter your phone number",
            hintText: "Phone Number",
            textInputType: TextInputType.phone,
            controller: phoneNumber,
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextFormField(
            textInputAction: TextInputAction.next,
            labelText: "Enter your address",
            hintText: "Address",
            textInputType: TextInputType.streetAddress,
            controller: address,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildAllTextFormField(),
          const SizedBox(
            height: 10,
          ),
          isLoading == false
              ? MyButton(
                  name: "SignUp",
                  onPressed: () {
                    validation();
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          const GoBackToLoginField(),
        ],
      ),
    );
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
                      height: 450,
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
                              } else if (value.length < 10 &&
                                  value.length > 11) {
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
                                          color: Colors.black87, fontSize: 18),
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
