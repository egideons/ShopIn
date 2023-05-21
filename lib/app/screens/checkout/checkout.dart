import 'package:flutter/material.dart';
import 'package:shopin_app/app/screens/cart/cartscreen.dart';
import 'package:shopin_app/styles/colors.dart';

class CheckOut extends StatefulWidget {
  final double price;
  final String name, image;

  const CheckOut({
    super.key,
    required this.price,
    required this.name,
    required this.image,
  });

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
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
        Icons.shopping_cart_checkout,
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
              builder: (ctx) => CartScreen(
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

  Widget _buildSingleCartSection() {
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
                          width: 100,
                          color: const Color(
                            0xfff2f2f2,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const <Widget>[
                              Text(
                                "Quantity",
                              ),
                              Text(
                                "1",
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

  Widget _buildBottomDetailSection({String? startName, String? endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName!,
          style: myFontStyle,
        ),
        Text(
          endName!,
          style: myFontStyle,
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar({String? name}) {
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
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
        ),
        child: Text(
          name!,
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
          name: "Buy",
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSingleCartSection(),
              SizedBox(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildBottomDetailSection(
                      startName: "Product Price: ",
                      endName: "\$ ${widget.price}",
                    ),
                    _buildBottomDetailSection(
                      startName: "Quantity: ",
                      endName: "1",
                    ),
                    _buildBottomDetailSection(
                      startName: "Discount: ",
                      endName: "3%",
                    ),
                    _buildBottomDetailSection(
                      startName: "Shipping: ",
                      endName: "\$ 12.00",
                    ),
                    _buildBottomDetailSection(
                      startName: "Total Price: ",
                      endName: "\$ 50.40",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
