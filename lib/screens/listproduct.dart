// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin_app/model/product.dart';
import 'package:shopin_app/provider/category_provider.dart';
import 'package:shopin_app/provider/product_provider.dart';
import 'package:shopin_app/screens/detailscreen.dart';
import 'package:shopin_app/screens/home/homepage.dart';
import 'package:shopin_app/screens/search_category.dart';
import 'package:shopin_app/screens/search_product.dart';
import 'package:shopin_app/widgets/notification_button.dart';
import 'package:shopin_app/widgets/singleproduct.dart';

class ListProduct extends StatelessWidget {
  final String? name;
  bool? isCategory = true;
  final List<Product>? snapShot;
  ListProduct({
    Key? key,
    this.name,
    this.isCategory,
    this.snapShot,
  }) : super(key: key);

  Widget _buildTopName() {
    return Column(
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
        )
      ],
    );
  }

  Widget _buildMyGridView(context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return SizedBox(
      height: 700,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        childAspectRatio: orientation == Orientation.portrait ? 0.8 : 0.9,
        scrollDirection: Axis.vertical,
        children: snapShot!
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => DetailScreen(
                            image: e.image,
                            name: e.name,
                            price: e.price,
                          )));
                },
                child: SingleProduct(
                  price: e.price,
                  image: e.image,
                  name: e.name,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  CategoryProvider? categoryProvider;
  ProductProvider? productProvider;
  Widget _buildSearchBar(context) {
    return isCategory == true
        ? IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              categoryProvider!.getSearchList(list: snapShot);
              showSearch(context: context, delegate: SearchCategory());
            },
          )
        : IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              productProvider!.getSearchList(list: snapShot);
              showSearch(context: context, delegate: SearchProduct());
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context);
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
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
            }),
        actions: <Widget>[
          _buildSearchBar(context),
          NotificationButton(),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            _buildTopName(),
            const SizedBox(
              height: 10,
            ),
            _buildMyGridView(context),
          ],
        ),
      ),
    );
  }
}
