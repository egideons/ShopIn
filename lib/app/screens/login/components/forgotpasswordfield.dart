import 'package:flutter/material.dart';
import 'package:shopin_app/styles/colors.dart';

class ForgotPasswordField extends StatelessWidget {
  const ForgotPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: (() {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const ForgotPassword(),
          //   ),
          // );
        }),
        child: const Text(
          "Forgot Password?",
          style: TextStyle(
            color: kTextWhiteColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
