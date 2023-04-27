// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopin_app/model/categoryicon.dart';
import 'package:shopin_app/model/usermodel.dart';
import 'package:shopin_app/screens/about.dart';
import 'package:shopin_app/screens/checkout.dart';
import 'package:shopin_app/screens/contactus.dart';
import 'package:shopin_app/screens/detailscreen.dart';
import 'package:shopin_app/screens/listproduct.dart';
import 'package:shopin_app/screens/profilescreen.dart';
import 'package:shopin_app/widgets/singleproduct.dart';

import '../../provider/product_provider.dart';
import '../../provider/category_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/product.dart';
import '../../widgets/notification_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

Product? menData;
CategoryProvider? categoryProvider;
ProductProvider? productProvider;

Product? womanData;

Product? bulbData;

Product? smartPhoneData;

class _HomePageState extends State<HomePage> {
//Firebase User
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    if (user != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .get()
          .then((value) {
        loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
      });
    }
  }

  Widget _buildCategoryProduct({String image = "", int? color}) {
    return CircleAvatar(
      maxRadius: height! * 0.1 / 2.1,
      backgroundColor: Color(color!),
      child: SizedBox(
        height: 40,
        child: Image(
          color: Colors.white,
          image: NetworkImage(image),
        ),
      ),
    );
  }

  double? height, width;
  bool homeColor = true;

  bool checkoutColor = false;

  bool aboutColor = false;

  bool contactUsColor = false;
  bool profileColor = false;
  MediaQueryData? mediaQuery;
  Widget _buildUserAccountsDrawerHeader() {
    List<UserModel> userModel = productProvider!.userModelList;
    return Column(
        children: userModel.map((e) {
      return UserAccountsDrawerHeader(
        accountName: Text(
          "{${loggedInUser.userName}",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: e.userImage == null
              ? const AssetImage("images/userImage.png")
              : e.userImage as ImageProvider<Object>,
        ),
        decoration: const BoxDecoration(color: Color(0xfff2f2f2)),
        accountEmail: Text(
          "${loggedInUser.userName}",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      );
    }).toList());
  }

  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _buildUserAccountsDrawerHeader(),
          ListTile(
            selected: homeColor,
            onTap: () {
              setState(() {
                homeColor = true;
                contactUsColor = false;
                checkoutColor = false;
                aboutColor = false;
                profileColor = false;
              });
            },
            leading: const Icon(Icons.home),
            title: const Text("Home"),
          ),
          ListTile(
            selected: checkoutColor,
            onTap: () {
              setState(() {
                checkoutColor = true;
                contactUsColor = false;
                homeColor = false;
                profileColor = false;
                aboutColor = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const CheckOut()));
            },
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Checkout"),
          ),
          ListTile(
            selected: aboutColor,
            onTap: () {
              setState(() {
                aboutColor = true;
                contactUsColor = false;
                homeColor = false;
                profileColor = false;
                checkoutColor = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const About(),
                ),
              );
            },
            leading: const Icon(Icons.info),
            title: const Text("About"),
          ),
          ListTile(
            selected: profileColor,
            onTap: () {
              setState(() {
                aboutColor = false;
                contactUsColor = false;
                homeColor = false;
                profileColor = true;
                checkoutColor = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const ProfileScreen(),
                ),
              );
            },
            leading: const Icon(Icons.info),
            title: const Text("Profile"),
          ),
          ListTile(
            selected: contactUsColor,
            onTap: () {
              setState(() {
                contactUsColor = true;
                checkoutColor = false;
                profileColor = false;
                homeColor = false;
                aboutColor = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const ContactUs(),
                ),
              );
            },
            leading: const Icon(Icons.phone),
            title: const Text("Contant Us"),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlider() {
    return SizedBox(
      height: height! * 0.3,
      child: Carousel(
        autoplay: true,
        showIndicator: false,
        images: const [
          AssetImage(
            "images/man.jpg",
          ),
          AssetImage(
            "images/woman.jpg",
          ),
          AssetImage(
            "images/camera.jpg",
          ),
        ],
      ),
    );
  }

  Widget _buildDressIcon() {
    List<CategoryIcon> dressIcon = categoryProvider!.getDressIcon;
    List<Product> dress = categoryProvider!.getDressList;
    return Row(
        children: dressIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "Dress",
                snapShot: dress,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(image: e.image, color: 0xff33dcfd),
      );
    }).toList());
  }

  Widget _buildShirtIcon() {
    List<Product> shirts = categoryProvider!.getShirtList;
    List<CategoryIcon> shirtIcon = categoryProvider!.getShirtIconData;
    return Row(
        children: shirtIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "Shirt",
                snapShot: shirts,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(image: e.image, color: 0xfff38cdd),
      );
    }).toList());
  }

  Widget _buildShoeIcon() {
    List<CategoryIcon> shoeIcon = categoryProvider!.getShoeIcon;
    List<Product> shoes = categoryProvider!.getshoesList;
    return Row(
        children: shoeIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "Shoes",
                snapShot: shoes,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(
          image: e.image,
          color: 0xff4ff2af,
        ),
      );
    }).toList());
  }

  Widget _buildPantIcon() {
    List<CategoryIcon> pantIcon = categoryProvider!.getPantIcon;
    List<Product> pant = categoryProvider!.getPantList;
    return Row(
        children: pantIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "Pant",
                snapShot: pant,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(
          image: e.image,
          color: 0xff74acf7,
        ),
      );
    }).toList());
  }

  Widget _buildTieIcon() {
    List<CategoryIcon> tieIcon = categoryProvider!.getTieIcon;
    List<Product> tie = categoryProvider!.getTieList;
    return Row(
        children: tieIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "Tie",
                snapShot: tie,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(
          image: e.image,
          color: 0xfffc6c8d,
        ),
      );
    }).toList());
  }

  Widget _buildCategory() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: height! * 0.1 - 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                "Categorie",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 60,
          child: Row(
            children: <Widget>[
              _buildDressIcon(),
              _buildShirtIcon(),
              _buildShoeIcon(),
              _buildPantIcon(),
              _buildTieIcon(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeature() {
    List<Product> featureProduct;

    featureProduct = productProvider!.getFeatureList;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "Featured",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => ListProduct(
                      name: "Featured",
                      isCategory: false,
                      snapShot: featureProduct,
                    ),
                  ),
                );
              },
              child: const Text(
                "View more",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Row(
          children: productProvider!.getHomeFeatureList.map((e) {
            return Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                              image: e.image,
                              price: e.price,
                              name: e.name,
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                            image: e.image,
                            price: e.price,
                            name: e.name,
                          ),
                        ),
                      );
                    },
                    child: SingleProduct(
                      image: e.image,
                      price: e.price,
                      name: e.name,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNewAchives() {
    List<Product> newArchivesProduct = productProvider!.getNewArchivesList;
    return Column(
      children: <Widget>[
        SizedBox(
          height: height! * 0.1 - 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "New Achives",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => ListProduct(
                            name: "NewAchvies",
                            isCategory: false,
                            snapShot: newArchivesProduct,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "View more",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Row(
            children: productProvider!.getHomeArchiveList.map((e) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => DetailScreen(
                                      image: e.image,
                                      price: e.price,
                                      name: e.name,
                                    ),
                                  ),
                                );
                              },
                              child: SingleProduct(
                                  image: e.image, price: e.price, name: e.name),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) => DetailScreen(
                                    image: e.image,
                                    price: e.price,
                                    name: e.name,
                                  ),
                                ),
                              );
                            },
                            child: SingleProduct(
                                image: e.image, price: e.price, name: e.name),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }).toList()),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  void getCallAllFunction() {
    categoryProvider!.getShirtData();
    categoryProvider!.getDressData();
    categoryProvider!.getShoesData();
    categoryProvider!.getPantData();
    categoryProvider!.getTieData();
    categoryProvider!.getDressIconData();
    productProvider!.getNewArchiveData();
    productProvider!.getFeatureData();
    productProvider!.getHomeFeatureData();
    productProvider!.getHomeAchiveData();
    categoryProvider!.getShirtIcon();
    categoryProvider!.getshoesIconData();
    categoryProvider!.getPantIconData();
    categoryProvider!.getTieIconData();
    productProvider!.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context);
    productProvider = Provider.of<ProductProvider>(context);
    getCallAllFunction();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _key,
      drawer: _buildMyDrawer(),
      appBar: AppBar(
        title: const Text(
          "HomePage",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _key.currentState!.openDrawer();
            }),
        actions: const <Widget>[
          NotificationButton(),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildImageSlider(),
                  _buildCategory(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildFeature(),
                  _buildNewAchives()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
