import 'package:flutter/material.dart';
import 'package:shopin_app/styles/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  Widget _buildFeaturedProducts(
    String name,
    double price,
    String image,
  ) {
    return Card(
      child: SizedBox(
        height: 250,
        width: 160,
        child: Column(
          children: <Widget>[
            Container(
              height: 190,
              width: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/featured/$image",
                  ),
                ),
              ),
            ),
            Text(
              "\$ $price",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: kPrimaryColor,
              ),
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryProduct(String image, int color) {
    return CircleAvatar(
      maxRadius: 35,
      backgroundColor: Color(
        color,
      ),
      child: Image(
        color: kSecondaryColor,
        image: AssetImage(
          "images/category/$image",
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(
            color: kTextBlackColor,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey.shade100,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: kBlackColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.send,
              color: kBlackColor,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            _key.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: kBlackColor,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const Icon(
                        Icons.search,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              "Featured",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "See all",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        _buildFeaturedProducts(
                          "Man Shirt",
                          30.0,
                          "man.png",
                        ),
                        _buildFeaturedProducts(
                          "Smart watch",
                          80.0,
                          "watch.png",
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Category",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "See more ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  _buildCategoryProduct(
                    "dress.png",
                    0xff33dcfd,
                  ),
                  _buildCategoryProduct(
                    "watch.png",
                    0xff33dcfd,
                  ),
                  _buildCategoryProduct(
                    "dress.png",
                    0xff33dcfd,
                  ),
                  _buildCategoryProduct(
                    "dress.png",
                    0xff33dcfd,
                  ),
                  _buildCategoryProduct(
                    "dress.png",
                    0xff33dcfd,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
