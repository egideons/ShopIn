import 'package:flutter/material.dart';
import 'package:shopin_app/screens/home/homepage.dart';
import 'package:shopin_app/styles/colors.dart';
import 'package:shopin_app/styles/constants.dart';

class DetailScreen extends StatefulWidget {
  final String? image;
  final String? name;
  final double? price;

  const DetailScreen({
    super.key,
    @required this.image,
    @required this.name,
    @required this.price,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  //================== VARIABLES SECTION ======================//

  int count = 1;

//================== STYLE SECTION ======================//

  final TextStyle myFontStyle = const TextStyle(
    fontSize: 18,
  );

//================== WIDGET SECTION ======================//

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Product Detail",
        style: TextStyle(
          color: kTextBlackColor,
        ),
      ),
      backgroundColor: kTransparentColor,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        },
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
    );
  }

  Widget _buildSizeProduct(
    String size,
  ) {
    return Container(
      color: const Color(
        0xfff2f2f2,
      ),
      height: 50,
      width: 50,
      child: Center(
        child: Text(
          size,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Widget _buildColorProduct(
    Color color,
  ) {
    return Container(
      color: color,
      height: 50,
      width: 50,
    );
  }

  Widget _buildImage() {
    return Center(
      child: SizedBox(
        width: 350,
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(
              13,
            ),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/featured/${widget.image}",
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameToDescription() {
    return SizedBox(
      height: 90,
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.name!,
                style: myFontStyle,
              ),
              kHalfSizedBox,
              Text(
                "\$ ${widget.price.toString()}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(
                    0xff9b96d6,
                  ),
                ),
              ),
              kHalfSizedBox,
              Text(
                "Description",
                style: myFontStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      color: kTransparentColor,
      height: 180,
      child: Wrap(
        children: const <Widget>[
          Text(
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Amet soluta repellendus earum velit harum cumque nesciunt corporis. Doloremque earum accusamus hic voluptatem quibusdam sit fugiat unde distinctio placeat. Earum, placeat! Lorem ipsum dolor sit amet consectetur adipisicing elit. Amet soluta repellendus earum velit harum cumque nesciunt corporis.",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizePart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Size",
          style: myFontStyle,
        ),
        kHalfSizedBox,
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildSizeProduct(
                "S",
              ),
              _buildSizeProduct(
                "M",
              ),
              _buildSizeProduct(
                "L",
              ),
              _buildSizeProduct(
                "XL",
              ),
              _buildSizeProduct(
                "XXL",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColorPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Color",
          style: myFontStyle,
        ),
        kHalfSizedBox,
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildColorProduct(
                Colors.blue.shade200,
              ),
              _buildColorProduct(
                Colors.green.shade200,
              ),
              _buildColorProduct(
                Colors.yellow.shade200,
              ),
              _buildColorProduct(
                Colors.cyan.shade300,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuantityPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Quantity",
          style: myFontStyle,
        ),
        kHalfSizedBox,
        Container(
          height: 40,
          width: 130,
          decoration: BoxDecoration(
            color: Colors.cyan.shade200,
            borderRadius: BorderRadius.circular(
              20,
            ),
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
    );
  }

  Widget _buildCheckoutButton() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
            ),
            child: Text(
              "Checkout",
              style: myFontStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildNameToDescription(),
          _buildDescription(),
          _buildSizePart(),
          kHalfSizedBox,
          _buildColorPart(),
          kHalfSizedBox,
          _buildQuantityPart(),
          kSizedBox,
          _buildCheckoutButton(),
        ],
      ),
    );
  }

//================== BUILD CONTEXT SECTION ======================//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            _buildImage(),
            _buildContent(),
          ],
        ),
      ),
    );
  }
}
