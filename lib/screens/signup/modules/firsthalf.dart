// ignore_for_file: sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:shopin_app/styles/colors.dart';
import 'package:shopin_app/styles/constants.dart';

class SignupPageFirstHalf extends StatelessWidget {
  const SignupPageFirstHalf({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      color: kPrimaryColor,
      child: Column(
        children: [
          Image.asset(
            "images/signup/frame-2.png",
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          const Text(
            "Helllooo",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w600,
              color: kTextWhiteColor,
            ),
          ),
          const SizedBox(
            height: kDefaultPadding / 6,
          ),
          const Text(
            "Create an account to get started",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: kTextWhiteColor,
            ),
          )
        ],
      ),
    );
  }
}