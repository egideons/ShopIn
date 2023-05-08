import 'package:flutter/material.dart';
import 'package:shopin_app/screens/detail%20screen/detailscreen.dart';
import 'package:shopin_app/styles/colors.dart';
import 'package:shopin_app/styles/constants.dart';

class CartScreen extends StatefulWidget {
  final double price;
  final String name, image;

  const CartScreen({
    super.key,
    required this.price,
    required this.name,
    required this.image,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
// ============== VARIABLES SECTION =============== //
  int count = 1;
  TextStyle myFontStyle = const TextStyle(
    fontSize: 18,
  );

// ============== WIDGETS SECTION =============== //

  Widget _buildCartSection() {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Container(
                  height: 130,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "images/featured/${widget.image}",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 140,
                  width: 200,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.name,
                        ),
                        const Text(
                          "Shirts",
                        ),
                        Text(
                          "\$ ${widget.price.toString()}",
                          style: const TextStyle(
                            color: Color(
                              0xff9b96d6,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 35,
                          width: 120,
                          color: const Color(
                            0xfff2f2f2,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (count > 1) {
                                      count--;
                                    }
                                  });
                                },
                                child: const Icon(
                                  Icons.remove,
                                ),
                              ),
                              Text(
                                count.toString(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                                child: const Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(),
      appBar: AppBar(
        backgroundColor: kTransparentColor,
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          "Cart",
          style: TextStyle(
            color: kTextBlackColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kBlackColor,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const DetailScreen(),
              ),
            );
          },
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
      body: Column(
        children: <Widget>[
          _buildCartSection(),
          kHalfSizedBox,
          _buildCartSection(),
          kHalfSizedBox,
          _buildCartSection(),
        ],
      ),
    );
  }
}
