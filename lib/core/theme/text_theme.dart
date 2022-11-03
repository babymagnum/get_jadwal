import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_jadwal/core/theme/colors_theme.dart';

class ThemeText {
  static TextStyle poppinsRegular = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    color: ThemeColor.textPrimary,
  );

  static TextStyle poppinsMedium = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    color: ThemeColor.textPrimary,
  );

  static TextStyle poppinsSemiBold = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    color: ThemeColor.textPrimary,
  );

  static TextStyle poppinsBold = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    color: ThemeColor.textPrimary,
  );

  static TextStyle poppinsExtraBold = GoogleFonts.poppins(
    fontWeight: FontWeight.w800,
    color: ThemeColor.textPrimary,
  );
}