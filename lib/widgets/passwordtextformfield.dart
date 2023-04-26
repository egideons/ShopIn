import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;
  final String name;

  final Function onTap;
  const PasswordTextFormField({
    super.key,
    required this.controller,
    required this.onTap,
    required this.name,
    required this.obscureText,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: name,
        suffixIcon: GestureDetector(
          onTap: onTap(),
          child: Icon(
            obscureText == true ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
        ),
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
