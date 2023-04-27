// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopin_app/styles/colors.dart';

void showSnackBar(BuildContext context, String text, Color bgcolor) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: bgcolor,
      width: MediaQuery.of(context).size.width / 2,
      duration: const Duration(
        seconds: 3,
      ),
      elevation: 10,
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
