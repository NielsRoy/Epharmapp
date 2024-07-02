import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color.fromRGBO(4, 120, 87, 1);//Color(0xFF0D47A1);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    textTheme: Typography().black.apply(fontFamily: 'Poppins'),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: 70,
      titleSpacing: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
  );

  static final ThemeData searchLightTheme  = ThemeData(
    textTheme: Typography().black.apply(fontFamily: 'Poppins'),
    appBarTheme: const AppBarTheme(
      titleSpacing: 0,
      color: Colors.white,
      elevation: 0,
      toolbarHeight: 70,
      iconTheme: IconThemeData(
        color: Colors.black,
        //size: 22,
      ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins'
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.black,
        )
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.black,
        )
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.black,
        )
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
    )
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
  
  );
}