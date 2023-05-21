import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopin_app/app/screens/home/homepage.dart';
import 'package:shopin_app/provider/category%20provider.dart';
import 'package:shopin_app/provider/product%20provider.dart';
import 'package:shopin_app/styles/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(
          0xff746bc9,
        ),
        iconTheme: IconThemeData(
          color: kPrimaryColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          Provider<ProductProvider>(
            create: (ctx) => ProductProvider(),
          ),
          Provider<CategoryProvider>(
            create: (ctx) => CategoryProvider(),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
