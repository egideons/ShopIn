// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:shopin_app/screens/home/homepage.dart';
import 'package:shopin_app/styles/colors.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      return (await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomePage(),
        ),
      ));
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(0xfff8f8f8),
          title: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
              size: 35,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => HomePage(),
                ),
              );
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About",
                style: TextStyle(
                  fontSize: 40,
                  color: kPrimaryColor,
                ),
              ),
              const Image(
                image: AssetImage(
                  "images/about.png",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 280,
                width: 360,
                child: Wrap(
                  children: const [
                    Text(
                      "ShopIn is an ecommerce mobile application",
                      style: TextStyle(fontSize: 22, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
