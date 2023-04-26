// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopin_app/provider/category_provider.dart';
import 'package:shopin_app/provider/product_provider.dart';
import 'package:shopin_app/src/app/home/homepage.dart';
import 'package:shopin_app/src/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) {
            var newArchivesData2;
            return ProductProvider(
                checkOutModelList: [],
                feature: [],
                homeArchive: [],
                homeFeature: [],
                newArchives: [],
                newArchivesData: newArchivesData2,
                notificationList: [],
                searchList: [],
                userModelList: []);
          },
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color(0xff746bc9),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
