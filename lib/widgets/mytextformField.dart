import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final textInputType;
  final textInputAction;

  const MyTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.textInputType,
    required this.textInputAction,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}
