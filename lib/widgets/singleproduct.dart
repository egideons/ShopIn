import 'package:flutter/material.dart';
import 'package:shopin_app/styles/colors.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final double price;
  final String name;

  const SingleProduct({
    Key? key,
    required this.image,
    required this.price,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width / 2.35,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Container(
                  height: 190,
                  width: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        image,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                price.toString(),
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
          )),
    );
  }
}
