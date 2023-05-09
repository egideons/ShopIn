// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:shopin_app/styles/colors.dart';
import 'package:shopin_app/styles/constants.dart';

class LoginPageFirstHalf extends StatelessWidget {
  const LoginPageFirstHalf({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.3,
      child: Column(
        children: [
          Image.asset(
            "images/login/frame-2.png",
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome ",
                style: TextStyle(
                  fontSize: 26,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "Back,",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              )
            ],
          ),
          const SizedBox(
            height: kDefaultPadding / 6,
          ),
          Text(
            "Login to continue",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: kPrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}
