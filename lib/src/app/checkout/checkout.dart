// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin_app/provider/product_provider.dart';
import 'package:shopin_app/src/app/home/homepage.dart';
import 'package:shopin_app/src/widgets/checkout_singleproduct.dart';
import 'package:shopin_app/src/widgets/mybutton.dart';
import 'package:shopin_app/src/widgets/notification_button.dart';

import '../../../model/cartmodel.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextStyle myStyle = const TextStyle(
    fontSize: 18,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ProductProvider? productProvider;

  Widget _buildBottomSingleDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: myStyle,
        ),
        Text(
          endName,
          style: myStyle,
        ),
      ],
    );
  }

  User? user;
  double? total;
  List<CartModel>? myList;

  Widget _buildButton() {
    return Column(
        children: productProvider!.userModelList.map((e) {
      return SizedBox(
        height: 50,
        child: MyButton(
          name: "Buy",
          onPressed: () {
            if (productProvider!.getCheckOutModelList.isNotEmpty) {
              FirebaseFirestore.instance.collection("Order").add({
                "Product": productProvider!.getCheckOutModelList
                    .map((c) => {
                          "ProductName": c.name,
                          "ProductPrice": c.price,
                          "ProductQuetity": c.quantity,
                          "ProductImage": c.image,
                          "Product Color": c.color,
                          "Product Size": c.size,
                        })
                    .toList(),
                "TotalPrice": total?.toStringAsFixed(2),
                "UserName": e.userName,
                "UserEmail": e.userEmail,
                "UserNumber": e.userPhoneNumber,
                "UserAddress": e.userAddress,
                "UserId": user?.uid,
              });
              setState(() {
                myList?.clear();
              });

              productProvider?.addNotification("Notification");
            } else {
              const SnackBar(
                content: Text(
                  "No Item Yet",
                ),
              );
            }
          },
        ),
      );
    }).toList());
  }

  @override
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    myList = productProvider!.checkOutModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
    double subTotal = 0;
    double discount = 3;
    double discountRupees;
    double shipping = 60;

    productProvider = Provider.of<ProductProvider>(context);
    for (var element in productProvider!.getCheckOutModelList) {
      subTotal += element.price * element.quantity;
    }

    discountRupees = discount / 100 * subTotal;
    total = subTotal + shipping - discountRupees;
    if (productProvider!.checkOutModelList.isEmpty) {
      total = 0.0;
      discount = 0.0;
      shipping = 0.0;
    }

    Future<bool> _onWillPop() async {
      // Perform any necessary operations before navigating to the HomePage
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const HomePage()));

      // Always return true to allow the back button press
      return true;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("CheckOut Page",
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const HomePage(),
                ),
              );
            },
          ),
          actions: <Widget>[
            NotificationButton(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 70,
          width: 100,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.only(bottom: 15),
          child: _buildButton(),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemCount: myList?.length,
                  itemBuilder: (ctx, myIndex) {
                    return CheckOutSingleProduct(
                      index: myIndex,
                      color: myList![myIndex].color,
                      size: myList![myIndex].size,
                      image: myList![myIndex].image,
                      name: myList![myIndex].name,
                      price: myList![myIndex].price,
                      quantity: myList?[myIndex].quantity,
                    );
                  },
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildBottomSingleDetail(
                        startName: "Subtotal",
                        endName: "\$ ${subTotal.toStringAsFixed(2)}",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Discount",
                        endName: "${discount.toStringAsFixed(2)}%",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Shipping",
                        endName: "\$ ${shipping.toStringAsFixed(2)}",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Total",
                        endName: "\$ ${total?.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
