import 'package:flutter/material.dart';
import 'package:shopin_app/screens/detail%20screen/detailscreen.dart';
import 'package:shopin_app/screens/home/homepage.dart';
import 'package:shopin_app/styles/colors.dart';
import 'package:shopin_app/styles/constants.dart';
import 'package:shopin_app/widgets/singleproduct.dart';

class ListProduct extends StatelessWidget {
  final String? name;

  const ListProduct({
    super.key,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kBlackColor,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: kBlackColor,
            ),
          ),
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
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            name!,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                kHalfSizedBox,
                SizedBox(
                  height: 700,
                  child: GridView.count(
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.6,
                    crossAxisCount: 2,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const DetailScreen(
                                name: "Man Shirt",
                                price: 30.0,
                                image: "man.png",
                              ),
                            ),
                          );
                        },
                        child: const SingleProduct(
                          name: "Man Shirt",
                          price: 30.0,
                          image: "man.png",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const DetailScreen(
                                name: "Black Smart watch",
                                price: 80.0,
                                image: "smart-watch.png",
                              ),
                            ),
                          );
                        },
                        child: const SingleProduct(
                          name: "Black Smart watch",
                          price: 80.0,
                          image: "smart-watch.png",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const DetailScreen(
                                name: "white t-shirt",
                                price: 10.0,
                                image: "product_0.png",
                              ),
                            ),
                          );
                        },
                        child: const SingleProduct(
                          name: "white t-shirt",
                          price: 10.0,
                          image: "product_0.png",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const DetailScreen(
                                name: "Blue t-shirt",
                                price: 15.0,
                                image: "product_1.png",
                              ),
                            ),
                          );
                        },
                        child: const SingleProduct(
                          name: "Blue t-shirt",
                          price: 15.0,
                          image: "product_1.png",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const DetailScreen(
                                name: "Designer t-shirt",
                                price: 25.0,
                                image: "product_2.png",
                              ),
                            ),
                          );
                        },
                        child: const SingleProduct(
                          name: "Designer t-shirt",
                          price: 25.0,
                          image: "product_2.png",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const DetailScreen(
                                name: "teal t-shirt",
                                price: 15.0,
                                image: "product_3.png",
                              ),
                            ),
                          );
                        },
                        child: const SingleProduct(
                          name: "teal t-shirt",
                          price: 15.0,
                          image: "product_3.png",
                        ),
                      ),
                      kHalfSizedBox,
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
