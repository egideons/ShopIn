// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:shopin_app/screens/home/homepage.dart';

class Signup_SplashScreen extends StatelessWidget {
  static String routeName = 'Signup Splash Screen';
  const Signup_SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
      // Navigator.pushNamedAndRemoveUntil(
      //     context, HomeWrapper.routeName, (route) => false);
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Center(
              child: Container(
                width: 400,
                height: 500,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "animations/sign up/signup-successful-splash.gif",
                    ),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
