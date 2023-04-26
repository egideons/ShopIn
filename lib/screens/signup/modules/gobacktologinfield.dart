// ignore_for_file: file_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopin_app/screens/login/login.dart';
import 'package:shopin_app/styles/colors.dart';
import 'package:shopin_app/styles/constants.dart';

class GoBackToLoginField extends StatelessWidget {
  const GoBackToLoginField({
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
                text: "Already have an account? ",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextSpan(
                text: 'Login',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => const Login(),
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
