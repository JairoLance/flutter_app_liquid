// Dark Theme
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    appBarTheme: AppBarTheme(color: kBackgroundLightColorAppBar, elevation: 2),
    primaryColor: kPrimaryColor,
    buttonColor: kBackgroundLightColorAppBar,
    primaryColorLight: kBackgroundDarkColor,
    accentColor: kPrimaryDarkColor,
    errorColor: kErrorLightColor,
    hintColor: kSecondaryLightColor,
    cardColor: kCardLightColor,
    brightness: Brightness.light,
    textSelectionTheme: TextSelectionThemeData(cursorColor: kPrimaryColor),
    unselectedWidgetColor: kSecondaryLightColor,
    scaffoldBackgroundColor: kBackgroundLightColor,
    backgroundColor: kBackgroundLightColor,
    iconTheme: IconThemeData(color: kBackgroundDarkColor),
    primaryIconTheme: IconThemeData(color: kBackgroundDarkColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    indicatorColor: kPrimaryColor,
    buttonTheme: ButtonThemeData(
      minWidth: 120.0,
      height: 45.0,
      buttonColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
    ),
    /*/
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
      hintStyle: GoogleFonts.poppins(
        color: kSecondaryLightColor,
        fontSize: 11.0,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: kSecondaryLightColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: kPrimaryColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: kErrorLightColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: kErrorLightColor,
        ),
      ),
      errorStyle: GoogleFonts.poppins(
        color: kErrorDarkColor,
        fontSize: 12.0,
      ),
    ),*/
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headline1: GoogleFonts.poppins(
        color: kPrimaryLightColor,
        fontSize: 16.0.sp,
        fontWeight: FontWeight.bold,
      ),
      headline2: GoogleFonts.poppins(
        color: kPrimaryLightColor,
        fontSize: 14.0.sp,
        fontWeight: FontWeight.bold,
      ),
      headline3: GoogleFonts.poppins(
        color: kPrimaryLightColor,
        fontSize: 12.0.sp,
        fontWeight: FontWeight.bold,
      ),
      headline4: GoogleFonts.poppins(
        color: kPrimaryLightColor,
        fontSize: 10.0.sp,
        fontWeight: FontWeight.bold,
      ),
      headline5: GoogleFonts.poppins(
        color: kPrimaryLightColor,
        fontSize: 8.0.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: GoogleFonts.poppins(
        color: kPrimaryLightColor,
        fontSize: 12.0.sp,
      ),
      bodyText2: GoogleFonts.poppins(
        color: kPrimaryLightColor,
        fontSize: 10.0.sp,
      ),
      subtitle1: GoogleFonts.poppins(
        color: kSecondaryLightColor,
        fontSize: 10.0.sp,
      ),
      subtitle2: GoogleFonts.poppins(
        color: kSecondaryLightColor,
        fontSize: 8.0.sp,
      ),
      button: GoogleFonts.roboto(
        color: kPrimaryDarkColor,
        fontSize: 11.0.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(color: kBackgroundDarkColorAppBar, elevation: 2),
    primaryColor: kPrimaryColor,
    accentColor: kPrimaryLightColor,
    buttonColor: kBackgroundDarkColorAppBar,
    primaryColorLight: kBackgroundLightColor,
    hintColor: kSecondaryDarkColor,
    cardColor: kCardDarkColor,
    errorColor: kErrorDarkColor,
    textSelectionTheme: TextSelectionThemeData(cursorColor: kPrimaryColor),
    brightness: Brightness.dark,
    indicatorColor: kPrimaryColor,
    unselectedWidgetColor: kSecondaryDarkColor,
    scaffoldBackgroundColor: kBackgroundDarkColor,
    backgroundColor: kBackgroundDarkColor,
    iconTheme: IconThemeData(color: kPrimaryColor),
    primaryIconTheme: IconThemeData(color: kPrimaryColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonTheme: ButtonThemeData(
      minWidth: 120.0,
      height: 45.0,
      buttonColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
    ),
    /*
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      hintStyle: GoogleFonts.poppins(
        color: kSecondaryDarkColor,
        fontSize: 12.0,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: kSecondaryDarkColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: kPrimaryColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: kErrorDarkColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: kErrorDarkColor,
        ),
      ),
      errorMaxLines: 1,
      helperStyle: GoogleFonts.poppins(
        color: kSecondaryDarkColor,
        fontSize: 10.0,
      ),
      errorStyle: GoogleFonts.poppins(
        color: kErrorDarkColor,
        fontSize: 10.0,
      ),
    ),*/
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headline1: GoogleFonts.poppins(
        color: kPrimaryDarkColor,
        fontSize: 16.0.sp,
        fontWeight: FontWeight.bold,
      ),
      headline2: GoogleFonts.poppins(
        color: kPrimaryDarkColor,
        fontSize: 14.0.sp,
        fontWeight: FontWeight.bold,
      ),
      headline3: GoogleFonts.poppins(
        color: kPrimaryDarkColor,
        fontSize: 12.0.sp,
        fontWeight: FontWeight.bold,
      ),
      headline4: GoogleFonts.poppins(
        color: kPrimaryDarkColor,
        fontSize: 10.0.sp,
        fontWeight: FontWeight.bold,
      ),
      headline5: GoogleFonts.poppins(
        color: kPrimaryDarkColor,
        fontSize: 8.0.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: GoogleFonts.poppins(
        color: kPrimaryDarkColor,
        fontSize: 12.0.sp,
      ),
      bodyText2: GoogleFonts.poppins(
        color: kPrimaryDarkColor,
        fontSize: 10.0.sp,
      ),
      subtitle1: GoogleFonts.poppins(
        color: kSecondaryDarkColor,
        fontSize: 10.0.sp,
      ),
      subtitle2: GoogleFonts.poppins(
        color: kSecondaryDarkColor,
        fontSize: 8.0.sp,
      ),
      button: GoogleFonts.roboto(
        color: kPrimaryDarkColor,
        fontSize: 11.0.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

AppBarTheme appBarTheme = AppBarTheme(color: Colors.transparent, elevation: 0);
