// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopin_app/screens/home/homepage.dart';
import 'package:shopin_app/screens/welcome/welcomescreen.dart';
import 'package:shopin_app/styles/colors.dart';

class Startup_SplashScreen extends StatelessWidget {
  static String routeName = "Startup Splash Screen";
  const Startup_SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const WelcomeScreen();
          }
        },
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
                "ShopIn",
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
                    Image(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height / 35,
                      image: const AssetImage(
                        "assets/images/logo/edura logo/powered by edura.png",
                      ),
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
