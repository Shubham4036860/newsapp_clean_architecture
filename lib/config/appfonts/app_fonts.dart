import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyles {
  static TextStyle mediumText({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }

  static TextStyle largeText({
    double fontSize = 20.0,
    Color color = Colors.black,
  }) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        color: color,
      ),
    );
  }

  static TextStyle boldText({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  static TextStyle textSemiBold({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
  static TextStyle textExtraBold({
    double fontSize = 16.0,
    Color color = Colors.black,
  }) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        color: color,
      ),
    );
  }
}
