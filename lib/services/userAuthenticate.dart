// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopin_app/screens/home/homepage.dart';
import 'package:shopin_app/screens/welcome/welcomescreen.dart';

class UserSnapshot extends StatelessWidget {
  static String routeName = "User Snapshot";
  const UserSnapshot({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const WelcomeScreen();
            }
          },
        ),
      );
}
