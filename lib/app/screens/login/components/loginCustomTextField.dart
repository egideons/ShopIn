// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shopin_app/styles/colors.dart';

class LoginCustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final dynamic keyboadType;
  final Icon prefixIcon;
  final dynamic textInputAction;
  final dynamic obscureText;
  final dynamic onSaved;
  final dynamic formValidator;

  const LoginCustomTextFormField({
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
      onSaved: onSaved,
      validator: formValidator,
      controller: controller,
      style: const TextStyle(
        color: kTextWhiteColor,
      ),
      keyboardType: keyboadType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      textAlign: TextAlign.start,
      cursorColor: kTextWhiteColor,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          color: kTextWhiteColor,
        ),
        prefixIcon: prefixIcon,
        labelText: labelText,
        hintText: hintText,
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

      // validator: (value) {
      //   RegExp regExp = RegExp(emailPattern);
      //   if (value == null || value.isEmpty) {
      //     return "Please enter your email!!";
      //   } else if (!regExp.hasMatch(value)) {
      //     return "Please enter a valid email address!!";
      //   }
      // },
// class EmailField extends StatelessWidget {
//   const EmailField({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       keyboardType: TextInputType.emailAddress,
//       textAlign: TextAlign.start,
//       style: const TextStyle(
//         color: kTextBlackColor,
//         fontSize: 18,
//         fontWeight: FontWeight.w300,
//       ),
//       decoration: InputDecoration(
//         labelText: "Email address",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         isDense: true,
//         labelStyle: const TextStyle(
//           fontSize: 17.0,
//           color: kTextLightColor,
//           height: 8.5,
//           fontWeight: FontWeight.w500,
//         ),
//         hintStyle: const TextStyle(
//           fontSize: 16.0,
//           color: kTextBlackColor,
//           height: 8.5,
//           fontWeight: FontWeight.w500,
//         ),
//         enabledBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: kBorderLightColor,
//             width: 0.7,
//           ),
//         ),
//         border: const UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: kBorderLightColor,
//           ),
//         ),
//         disabledBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: kBorderLightColor,
//           ),
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: kPrimaryColor,
//           ),
//         ),
//         errorBorder: const UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: kErrorBorderColor,
//             width: 1.2,
//           ),
//         ),
//         focusedErrorBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: kBorderLightColor, width: 1.2),
//         ),
//       ),
//     );
//   }
// }
