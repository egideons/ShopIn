// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shopin_app/src/styles/colors.dart';

class MyButton extends StatelessWidget {
  Function onPressed;
  final String name;
  MyButton({
    Key? key,
    required this.onPressed,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed(),
        style: ElevatedButton.styleFrom(
          foregroundColor: kTextWhiteColor,
          backgroundColor: kPrimaryColor,
        ),
        child: Text(
          name,
        ),
      ),
    );
  }
}
