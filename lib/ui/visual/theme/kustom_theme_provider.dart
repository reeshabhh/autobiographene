// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:flutter/foundation.dart';

// // Custom imports
// import 'package:autobiographene/ui/visual/theme/colors.dart';

// class KustomThemeProvider with ChangeNotifier {
//   late ThemeData _themeData;

//   KustomThemeProvider(this._themeData);
//   getKustomTheme() => _themeData;
//   setTheme(ThemeData themeData) {
//     _themeData = themeData;
//     notifyListeners();
//   }

//   SharedPreferences? prefs;

//   _initPrefs() async {
//     if (prefs == null) prefs = await SharedPreferences.getInstance();
//   }

//   _loadFromPrfs() async {
//     await _initPrefs();

//     // String key;
//     // globalDarkThemeChecker = prefs!.getBool(key) ?? true; // FIXME getting error undefined name key on uncommenting
//   }

//   _setToPrefs() async {
//     await _initPrefs();
//     // prefs.setBool(key, globalDarkThemeChecker); // FIXME getting the error on uncommenting
//   }

//   // get getKustomTheme => _themeData;
//   // set setKustomTheme(ThemeData themeToSet) {
//   //   _themeData = themeToSet;
//   //   notifyListeners();
//   // }

// // late ThemeData _kustomLightTheme;
//   // late ThemeData _kustomDarkTheme;

//   // static bool _isDarkTheme = true;
//   // ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

//   // KustomTheme(this._kustomDarkTheme, this._kustomLightTheme);

// // void toggleTheme() {
// //     _isDarkTheme = !_isDarkTheme;
// //     notifyListeners();
// //     print('Toggle Theme has been called');
// //   }

//   // static ThemeData get lightTheme {
//   //   //1
//   //   return ThemeData(
//   //       //2
//   //       primaryColor: CustomColors.purple,
//   //       scaffoldBackgroundColor: Colors.white,
//   //       // fontFamily: 'Montserrat', //3
//   //       buttonTheme: ButtonThemeData(
//   //         // 4
//   //         shape:
//   //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
//   //         buttonColor: CustomColors.lightPurple,
//   //       ));
//   // }

//   // static ThemeData get darkTheme {
//   //   return ThemeData(
//   //     primaryColor: CustomColors.lightPurple,
//   //     scaffoldBackgroundColor: Colors.black,
//   //     // fontFamily: 'Montserrat',
//   //     textTheme: ThemeData.dark().textTheme,
//   //     inputDecorationTheme: InputDecorationTheme(
//   //       alignLabelWithHint: false,
//   //       focusColor: Colors.red,
//   //       border: OutlineInputBorder(
//   //         borderSide: BorderSide(
//   //           color: Colors.yellow,
//   //         ),
//   //         borderRadius: BorderRadius.circular(30.0),
//   //       ),
//   //       hintStyle: TextStyle(
//   //         color: Colors.purple,
//   //         fontStyle: FontStyle.italic,
//   //       ),
//   //       fillColor: Colors.red,
//   //     ),
//   //     buttonTheme: ButtonThemeData(
//   //       shape:
//   //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
//   //       buttonColor: CustomColors.lightPurple,
//   //     ),
//   //   );
//   // }
// }

// final lightTheme
//     //1
//     = ThemeData(
//         //2
//         primaryColor: CustomColors.purple,
//         scaffoldBackgroundColor: Colors.white,
//         shadowColor: Colors.white,

//         // fontFamily: 'Montserrat', //3
//         buttonTheme: ButtonThemeData(
//           // 4
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
//           buttonColor: CustomColors.lightPurple,
//         ));

// final darkTheme = ThemeData(
//   primaryColor: CustomColors.lightPurple,
//   scaffoldBackgroundColor: Colors.black,
//   textSelectionTheme: TextSelectionThemeData().copyWith(
//     cursorColor: Colors.red,
//     selectionColor: Colors.red,
//   ),

//   // fontFamily: 'Montserrat',
//   textTheme: ThemeData.dark().textTheme.copyWith(
//         bodyText1: TextStyle(
//             // color: Colors.brown,
//             ),
//         bodyText2: TextStyle(
//           color: Colors.white,
//         ),
//         overline: TextStyle(
//           color: Colors.red,
//         ),
//         headline6: TextStyle(
//           color: Colors.red,
//         ),
//         headline5: TextStyle(
//           color: Colors.red,
//         ),
//         headline4: TextStyle(
//           color: Colors.red,
//         ),
//         headline3: TextStyle(
//           color: Colors.red,
//         ),
//         headline2: TextStyle(
//           color: Colors.red,
//         ),
//         headline1: TextStyle(
//           color: Colors.red,
//         ),
//       ),

//   shadowColor: Colors.brown,
//   primaryTextTheme: TextTheme(),
//   inputDecorationTheme: InputDecorationTheme(
//     alignLabelWithHint: false,
//     focusColor: Colors.red,
//     border: OutlineInputBorder(
//       borderSide: BorderSide(
//         color: Colors.yellow,
//       ),
//       borderRadius: BorderRadius.circular(30.0),
//     ),
//     hintStyle: TextStyle(
//       color: Colors.purple,
//       fontStyle: FontStyle.italic,
//     ),
//     fillColor: Colors.red,
//   ),
//   buttonTheme: ButtonThemeData(
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
//     buttonColor: CustomColors.lightPurple,
//   ),
//   iconTheme: IconThemeData(
//     color: Colors.white,
//   ),
// );
