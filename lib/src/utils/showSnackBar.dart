// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopin_app/src/styles/colors.dart';

void showSnackBar(BuildContext context, String text, Color bgColor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(
        seconds: 3,
      ),
      elevation: 10,
      backgroundColor: bgColor,
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: GoogleFonts.acme(
          color: kSecondaryColor,
        ),
      ),
    ),
  );
}
