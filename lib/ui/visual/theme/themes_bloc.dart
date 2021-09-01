import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AppTheme {
  lightTheme,
  darkTheme,
}

class AppThemes extends Equatable {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.blue,
      backgroundColor: Colors.white,
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    AppTheme.darkTheme: ThemeData(
      scaffoldBackgroundColor: Colors.green,
      primarySwatch: Colors.green,
      backgroundColor: Colors.green,
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  };

  @override
  List<Object?> get props => [];
  // =>throw UnimplementedError();
}
