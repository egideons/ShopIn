import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopin_app/provider/category_provider.dart';
import 'package:shopin_app/provider/product_provider.dart';
import 'package:shopin_app/splash%20screens/startup_splashscreen.dart';

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
          create: (context) => ProductProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color(
            0xff746bc9,
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const Startup_SplashScreen(),
      ),
    );
  }
}
