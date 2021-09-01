import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appName = 'Custom Themes';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: MyHomePage(
        title: appName,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          color: Theme.of(context).accentColor,
          child: Text(
            'Text with a background color',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          colorScheme:
          Theme.of(context).colorScheme.copyWith(secondary: Colors.yellow),
        ),
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}








// import 'package:flutter/material.dart';

// class MyAppTheme {
//   Color bg1;
//   Color accent1;
//   bool isDark;
 
//   /// Default constructor
//   MyAppTheme({@required this.isDark});
 
//   ThemeData get themeData {
//     /// Create a TextTheme and ColorScheme, that we can use to generate ThemeData
//     TextTheme txtTheme = (isDark ? ThemeData.dark() : ThemeData.light()).textTheme;
//     Color txtColor = txtTheme.bodyText1.color;
//     ColorScheme colorScheme = ColorScheme(
//         // Decide how you want to apply your own custom them, to the MaterialApp
//         brightness: isDark ? Brightness.dark : Brightness.light,
//         primary: accent1,
//         primaryVariant: accent1,
//         secondary: accent1,
//         secondaryVariant: accent1,
//         background: bg1,
//         surface: bg1,
//         onBackground: txtColor,
//         onSurface: txtColor,
//         onError: Colors.white,
//         onPrimary: Colors.white,
//         onSecondary: Colors.white,
//         error: Colors.red.shade400);
 
//     /// Now that we have ColorScheme and TextTheme, we can create the ThemeData
//     var t = ThemeData.from(textTheme: txtTheme, colorScheme: colorScheme)
//         // We can also add on some extra properties that ColorScheme seems to miss
//         .copyWith(buttonColor: accent1, cursorColor: accent1, highlightColor: accent1, toggleableActiveColor: accent1);
 
//     /// Return the themeData which MaterialApp can now use
//     return t;
//   }
// }