import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:equatable/equatable.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
      primaryColor: CustomColors.purple,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat',
      // textTheme: ThemeData.light().textTheme,
      textTheme: ThemeData.dark().textTheme.copyWith(
            bodyText1: TextStyle(
                // color: Colors.brown,
                ),
            bodyText2: TextStyle(
              color: Colors.white,
            ),
            overline: TextStyle(
              color: Colors.red,
            ),
            headline6: TextStyle(
              color: Colors.red,
            ),
            headline5: TextStyle(
              color: Colors.red,
            ),
            headline4: TextStyle(
              color: Colors.red,
            ),
            headline3: TextStyle(
              color: Colors.red,
            ),
            headline2: TextStyle(
              color: Colors.red,
            ),
            headline1: TextStyle(
              color: Colors.red,
            ),
          ),
      textSelectionTheme: TextSelectionThemeData().copyWith(
        cursorColor: Colors.red,
        selectionColor: Colors.red,
      ),
      inputDecorationTheme: InputDecorationTheme(
        alignLabelWithHint: false,
        focusColor: Colors.red,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.yellow,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        hintStyle: TextStyle(
          color: Colors.purple,
          fontStyle: FontStyle.italic,
        ),
        fillColor: Colors.red,
      ),
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: CustomColors.lightPurple,
      ),
      shadowColor: Colors.brown,
      primaryTextTheme: TextTheme(),
    ),
    AppTheme.darkTheme: ThemeData(
      primaryColor: CustomColors.lightPurple,
      scaffoldBackgroundColor: Colors.black,
      fontFamily: 'Montserrat',
      // textTheme: ThemeData.dark().textTheme,
      textTheme: ThemeData.dark().textTheme.copyWith(
            bodyText1: TextStyle(
                // color: Colors.brown,
                ),
            bodyText2: TextStyle(
              color: Colors.white,
            ),
            overline: TextStyle(
              color: Colors.red,
            ),
            headline6: TextStyle(
              color: Colors.red,
            ),
            headline5: TextStyle(
              color: Colors.red,
            ),
            headline4: TextStyle(
              color: Colors.red,
            ),
            headline3: TextStyle(
              color: Colors.red,
            ),
            headline2: TextStyle(
              color: Colors.red,
            ),
            headline1: TextStyle(
              color: Colors.red,
            ),
          ),
      textSelectionTheme: TextSelectionThemeData().copyWith(
        cursorColor: Colors.red,
        selectionColor: Colors.red,
      ),
      inputDecorationTheme: InputDecorationTheme(
        alignLabelWithHint: false,
        focusColor: Colors.red,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.yellow,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        hintStyle: TextStyle(
          color: Colors.purple,
          fontStyle: FontStyle.italic,
        ),
        fillColor: Colors.red,
      ),
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: CustomColors.lightPurple,
      ),
      shadowColor: Colors.brown,
      primaryTextTheme: TextTheme(),
    ),
  };
}
