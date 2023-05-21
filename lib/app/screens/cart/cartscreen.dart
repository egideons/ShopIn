import 'package:flutter/material.dart';
import 'package:shopin_app/app/screens/checkout/checkout.dart';
import 'package:shopin_app/app/screens/detail%20screen/detailscreen.dart';
import 'package:shopin_app/styles/colors.dart';

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
    fontWeight: FontWeight.bold,
  );

// ============== WIDGETS SECTION =============== //

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: kTransparentColor,
      centerTitle: true,
      elevation: 0.0,
      title: Icon(
        Icons.shopping_cart,
        color: kPrimaryColor,
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: kBlackColor,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => DetailScreen(
                name: widget.name,
                image: widget.image,
                price: widget.price,
              ),
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
    );
  }

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
                      image: NetworkImage(
                        widget.image,
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
                        Text(
                          "Shirts",
                          style: myFontStyle,
                        ),
                        Text(
                          widget.price.toString(),
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

  Widget _buildBottomNavigationBar(String name) {
    return Container(
      height: 60,
      width: 100,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => CheckOut(
                name: widget.name,
                image: widget.image,
                price: widget.price,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
        ),
        child: Text(
          name,
          style: myFontStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        bottomNavigationBar: _buildBottomNavigationBar(
          "Checkout",
        ),
        body: ListView(
          children: <Widget>[
            _buildCartSection(),
          ],
        ),
      ),
    );
  }
}
