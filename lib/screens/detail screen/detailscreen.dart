import 'package:flutter/material.dart';
import 'package:shopin_app/styles/colors.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: kBlackColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: kBlackColor,
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: SizedBox(
                width: 350,
                child: Card(
                  child: Container(
                    height: 220,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                        "images/featured/man.png",
                      ),
                    )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
