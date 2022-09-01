import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey));
}

TextStyle get hintSubTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black));
}
