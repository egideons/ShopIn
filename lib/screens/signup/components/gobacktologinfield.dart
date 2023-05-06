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
                  color: kTextWhiteColor,
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: kTextWhiteColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
