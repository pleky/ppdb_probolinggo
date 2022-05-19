import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeText {
  ThemeText._();

  static final heading1 = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );

  static final heading2 = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static final bodyText1 = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 16,
  );
  static final button = GoogleFonts.poppins(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
}
