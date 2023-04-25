// ignore_for_file: file_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopin_app/src/signup/signup.dart';
import 'package:shopin_app/src/styles/colors.dart';
import 'package:shopin_app/src/styles/constants.dart';

class GoToSignUpField extends StatelessWidget {
  const GoToSignUpField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        kHalfWidthSizedBox,
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextSpan(
                text: 'Register',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => const SignUp(),
                      ),
                    );
                  },
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kAccentColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
