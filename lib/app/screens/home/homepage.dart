import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopin_app/app/screens/detail%20screen/detailscreen.dart';
import 'package:shopin_app/app/screens/list%20products/listproduct.dart';
import 'package:shopin_app/app/screens/login/login.dart';
import 'package:shopin_app/models/product.dart';
import 'package:shopin_app/styles/colors.dart';
import 'package:shopin_app/styles/constants.dart';
import 'package:shopin_app/utils/showSnackBar.dart';
import 'package:shopin_app/widgets/singleproduct.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Product? mobileData, menData, shoeData, smartWatchData, womenData, cameraData;

Product menData = Product();
Product womenData = Product();

class _HomePageState extends State<HomePage> {
//====================== VARIABLES SECTION ========================//
  bool homeColor = true;
  bool cartColor = false;
  bool aboutColor = false;
  bool contactUsColor = false;
  Color drawerSelectedColor = kPrimaryColor;
  String? errorMessage;

  //Firebase Authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Firebase Firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //Global Key
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  int _currentImage = 0;

//===================== CAROUSEL SECTION =======================//
//Carousel Images
  final List<String> carouselImages = [
    "images/featured/product_0.png",
    "images/featured/product_1.png",
    "images/featured/product_2.png",
    "images/featured/product_3.png",
    "images/featured/smart-watch.png",
  ];

//Carousel slider - generate Images
  List<Widget> generateImagesTiles() {
    return carouselImages
        .map((element) => ClipRRect(
              borderRadius: BorderRadius.circular(
                10,
              ),
              child: Image.asset(
                element,
                fit: BoxFit.fill,
              ),
            ))
        .toList();
  }

//================== WIDGET SECTION ======================//

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Icon(
        Icons.home,
        color: kPrimaryColor,
        size: 30,
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.grey.shade100,
      leading: IconButton(
        onPressed: () {
          _key.currentState?.openDrawer();
        },
        icon: const Icon(
          Icons.menu,
          color: kBlackColor,
        ),
      ),
      actions: [
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
    );
  }

  Widget _buildCategoryProduct({String? image, int? color}) {
    return CircleAvatar(
      maxRadius: 35,
      backgroundColor: Color(
        color!,
      ),
      child: SizedBox(
        height: 40,
        child: Image(
          color: kSecondaryColor,
          image: AssetImage(
            "images/category/$image",
          ),
        ),
      ),
    );
  }

  Widget _buildMyDrawer() {
    return Drawer(
      elevation: 10.0,
      shadowColor: kGreyColor2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                "images/userImage.png",
              ),
            ),
            accountName: Text(
              "User",
              style: TextStyle(
                color: kBlackColor,
              ),
            ),
            accountEmail: Text(
              "user@gmail.com",
              style: TextStyle(
                color: kBlackColor,
              ),
            ),
            decoration: BoxDecoration(
              color: Color(
                0xfff2f2f2,
              ),
            ),
          ),
          ListTile(
            selectedColor: drawerSelectedColor,
            selected: homeColor,
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
              setState(() {
                homeColor = true;
                aboutColor = false;
                cartColor = false;
                contactUsColor = false;
              });
            },
            leading: const Icon(
              Icons.home,
            ),
            title: const Text(
              "Home",
            ),
          ),
          ListTile(
            selectedColor: drawerSelectedColor,
            selected: cartColor,
            onTap: () {
              setState(() {
                cartColor = true;
                homeColor = false;
                aboutColor = false;
                contactUsColor = false;
              });
            },
            leading: const Icon(
              Icons.shopping_cart,
            ),
            title: const Text(
              "Checkout",
            ),
          ),
          ListTile(
            selectedColor: drawerSelectedColor,
            selected: aboutColor,
            onTap: () {
              setState(() {
                aboutColor = true;
                homeColor = false;
                cartColor = false;
                contactUsColor = false;
              });
            },
            leading: const Icon(
              Icons.info,
            ),
            title: const Text(
              "About",
            ),
          ),
          ListTile(
            selectedColor: drawerSelectedColor,
            selected: contactUsColor,
            onTap: () {
              setState(() {
                contactUsColor = true;
                homeColor = false;
                cartColor = false;
                aboutColor = false;
              });
            },
            leading: const Icon(
              Icons.phone,
            ),
            title: const Text(
              "Contact us",
            ),
          ),
          const Divider(
            thickness: 1,
            color: kGreyColor1,
          ),
          ListTile(
            onTap: () async {
              try {
                _auth.signOut().whenComplete(
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      ),
                    );
              } on FirebaseAuthException catch (error) {
                switch (error.code) {
                  default:
                    errorMessage =
                        "Encountered an error, please try again later.";
                }
                showSnackBar(
                  context,
                  errorMessage!,
                  kErrorColor,
                ); // D
                (error.code);
              }
            },
            leading: const Icon(
              Icons.exit_to_app,
            ),
            title: const Text(
              "Logout",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return SizedBox(
      height: 200,
      child: CarouselSlider(
        items: generateImagesTiles(),
        options: CarouselOptions(
          enlargeCenterPage: true,
          autoPlay: true,
          scrollDirection: Axis.horizontal,
          viewportFraction: 1,
          scrollPhysics: const BouncingScrollPhysics(),
          onPageChanged: ((index, reason) {
            setState(() {
              _currentImage = index;
            });
          }),
        ),
      ),
    );
  }

  Widget _buildCategory() {
    return Column(
      children: <Widget>[
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
            ],
          ),
        ),
        SizedBox(
          height: 60,
          child: Row(
            children: [
              _buildCategoryProduct(
                image: "shirt.png",
                color: 0xff4ff2af,
              ),
              _buildCategoryProduct(
                image: "dress.png",
                color: 0xff33dcfd,
              ),
              _buildCategoryProduct(
                image: "watch.png",
                color: 0xfff38cdd,
              ),
              _buildCategoryProduct(
                image: "shoe.png",
                color: 0xff74acf7,
              ),
              _buildCategoryProduct(
                image: "tie.png",
                color: 0xfffc6c8d,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatured() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "Featured",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ListProduct(
                      name: "Featured",
                    ),
                  ),
                );
              },
              child: const Text(
                "View more",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      name: menData.name!,
                      image: menData.image!,
                      price: menData.price!,
                    ),
                  ),
                );
              },
              child: SingleProduct(
                name: menData.name!,
                image: menData.image!,
                price: menData.price!,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      name: womenData.name!,
                      image: womenData.image!,
                      price: womenData.price!,
                    ),
                  ),
                );
              },
              child: SingleProduct(
                name: womenData.name!,
                image: womenData.image!,
                price: womenData.price!,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArchives() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "New Archives",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const ListProduct(
                            name: "New Archives",
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "View more",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const DetailScreen(
                              name: "Long black gown",
                              price: 200.0,
                              image: "long-black-gown.png",
                            ),
                          ),
                        );
                      },
                      child: const SingleProduct(
                        name: "Long black gown",
                        price: 120.0,
                        image: "long-black-gown.png",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const DetailScreen(
                              name: "Crystal gold watch",
                              price: 45.0,
                              image: "female-gold-watch.png",
                            ),
                          ),
                        );
                      },
                      child: const SingleProduct(
                        image: "female-gold-watch.png",
                        price: 45.0,
                        name: "Crystal gold watch",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: _buildMyDrawer(),
        appBar: _buildAppBar(),
        body: FutureBuilder(
          future: _firebaseFirestore
              .collection(
                "products",
              )
              .doc(
                "Xp7cKFEwpyeJ3h3LxZlG",
              )
              .collection(
                "featuredProducts",
              )
              .get(),
          builder: (context, snapshot) {
            menData = Product(
              image: snapshot.data?.docs[0]["image"].toString(),
              name: snapshot.data?.docs[0]["name"].toString(),
              price: snapshot.data?.docs[0]["price"].toDouble(),
            );
            womenData = Product(
              image: snapshot.data?.docs[1]["image"],
              name: snapshot.data?.docs[1]["name"].toString(),
              price: snapshot.data?.docs[1]["price"].toDouble(),
            );

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitFoldingCube(
                      color: kPrimaryColor,
                    ),
                    kSizedBox,
                    const Text(
                      "...wait a moment",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Container(
              height: double.infinity,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildCarouselSlider(),
                            _buildCategory(),
                            kSizedBox,
                            _buildFeatured(),
                            _buildArchives(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
