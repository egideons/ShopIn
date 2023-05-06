// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shopin_app/styles/colors.dart';

class SignupCustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final dynamic keyboadType;
  final Icon prefixIcon;
  final dynamic textInputAction;
  final dynamic obscureText;
  final dynamic onSaved;
  final dynamic formValidator;

  const SignupCustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.keyboadType,
    required this.prefixIcon,
    required this.textInputAction,
    required this.obscureText,
    required this.onSaved,
    required this.formValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: formValidator,
      onSaved: onSaved,
      controller: controller,
      keyboardType: keyboadType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      textAlign: TextAlign.start,
      cursorColor: kSecondaryColor,
      style: const TextStyle(
        color: kTextWhiteColor,
      ),
      decoration: InputDecoration(
        prefixIcon: Container(
          child: prefixIcon,
        ),
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: kTextWhiteColor,
        ),
        labelStyle: const TextStyle(
          color: kTextWhiteColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
          borderSide: const BorderSide(
            color: kSecondaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
          borderSide: const BorderSide(
            color: kSecondaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
          borderSide: const BorderSide(
            color: kSecondaryColor,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
          borderSide: const BorderSide(
            color: kErrorBorderColor,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
          borderSide: const BorderSide(
            color: kErrorBorderColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
