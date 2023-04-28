// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopin_app/services/userSnapshot.dart';

import 'package:shopin_app/styles/colors.dart';

class Startup_SplashScreen extends StatelessWidget {
  static String routeName = "Startup Splash Screen";
  const Startup_SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const UserSnapshot(),
        ),
      );
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Center(
              child: Container(
                width: 400,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "dev_assets/logo.png",
                    ),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Text(
                "Enjoy a great shopping experience",
                style: TextStyle(
                  fontSize: 18,
                  color: kPrimaryColor,
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 100,
                    ),
                    SpinKitChasingDots(
                      color: kPrimaryColor,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
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
