import 'package:flutter/material.dart';

import 'colors.dart';

// final ThemeData myAppTheme = buildTheme();



class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
    print('Toggle Theme has been called');
  }

  // ThemeData _themedata (ThemeData base) {
  //   return base.copyWith(
  //     accentColor: base.accentColor.copyWith(
  //       fontWeight: FontWeight.w900,
  //     )
  //   )
  // }


  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        primaryColor: CustomColors.purple,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat', //3
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: CustomColors.lightPurple,
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: CustomColors.lightPurple,
      scaffoldBackgroundColor: Colors.black,
      fontFamily: 'Montserrat',
      textTheme: ThemeData.dark().textTheme,
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
    );
  }
}

// CustomTheme copyWith({
  
// })

// const kTextFieldDecoration = InputDecoration(
//   hintText: 'example@email.com',
//   icon: Icon(Icons.email),
//   labelText: 'Email',
//   labelStyle: TextStyle(color: Colors.green),
// );
