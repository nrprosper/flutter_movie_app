import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class MThemes {

  MThemes._();

  static NavigationBarThemeData navigationBarThemeData = NavigationBarThemeData(
    indicatorColor: Colors.transparent,
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
              color: Color(0xFFFF8F71),
              size: 32
          ); // Active icon color
        }
        return const IconThemeData(
            color: Colors.grey,
            size: 32
        ); // Inactive icon color
      },
    ),
  );

  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(),
    displayMedium: GoogleFonts.poppins(),
    displaySmall: GoogleFonts.poppins(),
    headlineLarge: GoogleFonts.poppins(),
    headlineMedium: GoogleFonts.poppins(),
    headlineSmall: GoogleFonts.poppins(),
    titleLarge: GoogleFonts.poppins(),
    titleMedium: GoogleFonts.poppins(),
    titleSmall: GoogleFonts.poppins(),
    bodyLarge: GoogleFonts.poppins(),
    bodyMedium: GoogleFonts.poppins(),
    bodySmall: GoogleFonts.poppins(),
    labelLarge: GoogleFonts.poppins(),
    labelMedium: GoogleFonts.poppins(),
    labelSmall: GoogleFonts.poppins(),
  );

  static SearchBarThemeData searchBarThemeData = SearchBarThemeData(
    backgroundColor: WidgetStatePropertyAll(MColors.searchColor),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    hintStyle: WidgetStatePropertyAll(
      TextStyle(
        color: MColors.searchTextColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w600
      ),
    ),
    padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16.0)),
  );

}