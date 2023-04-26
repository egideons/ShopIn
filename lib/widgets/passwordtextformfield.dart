import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  final bool obscureText;
  final TextEditingController controller;
  final String hintText;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String labelText;
  final ValueChanged<String> onChanged;

  final Function onTap;
  const PasswordTextFormField({
    super.key,
    required this.controller,
    required this.onTap,
    required this.hintText,
    required this.obscureText,
    required this.textInputAction,
    required this.textInputType,
    required this.labelText,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType: textInputType,
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        labelText: labelText,
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
