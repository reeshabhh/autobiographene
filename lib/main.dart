// Debug is working as of 18 Aug 2021 at 11:13 AM

//import 'dart:js';

import 'package:autobiographene/screens/paginated_infinite_scroll_screens/home_screen_paginated.dart';
import 'package:autobiographene/screens/home_screen_test.dart';
import 'package:autobiographene/screens/paginated_infinite_scroll_screens/trending_screen_paginated.dart';
import 'package:autobiographene/screens/paginated_infinite_scroll_screens/trending_screen_paginated_discarded.dart';
import 'package:autobiographene/screens/paginated_infinite_scroll_screens/trending_screen_paginated_refresh.dart';
import 'package:autobiographene/screens/paginated_infinite_scroll_screens/trending_test_stream_buil.dart';
import 'package:autobiographene/visual/theme/kustom_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:autobiographene/screens/after_submit_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart'; //? is it required
//FIXME could not find the provider //ERROR

// Custom imports
// import 'package:knight_and_day/home/home_page.dart';
import './screens/screens.dart';
// FIXME fix theming - 25-Jul-21
// import './theme/custom_theme.dart';
// import './theme/config.dart';

// FIXME USe themes to define size of icons in different sections                                  size: 20.0,

bool globalDarkThemeChecker = true;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  // const MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  // FIXME check if it is required 25-Jul-21
  // @override
  // void initState() {
  //   super.initState();
  //   currentTheme.addListener(
  //     () {
  //       setState(() {});
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<KustomThemeProvider>(
      create: (_) => KustomThemeProvider(lightTheme),
      child: MaterialAppWithTheme(),

// return ChangeNotifierProvider<ThemeChanger>(
      //   create: (_) => ThemeChanger(ThemeData.dark()),
      //   child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<KustomThemeProvider>(context);
    globalDarkThemeChecker = theme.getKustomTheme() == darkTheme ? true : false;
    return MaterialApp(
      theme: theme.getKustomTheme(),
      // theme: ThemeData(
      //     // primarySwatch: Colors.green,
      //     ),
      debugShowCheckedModeBanner: false,
      title: 'AutoBioGraphene',
      // initialRoute: HomeScreen.id,
      // initialRoute: SplashScreen.id,
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? WelcomeScreen.id
          : HomeScreenPaginated.id,
      // TrendingTestStreamBuilder.id
      routes: {
        // Paginated Routes
        HomeScreenPaginated.id: (context) => HomeScreenPaginated(),

        TrendingScreenPaginatedDiscarded.id: (context) =>
            TrendingScreenPaginatedDiscarded(),
        TrendingTestStreamBuilder.id: (context) => TrendingTestStreamBuilder(),
        TrendingScreenPaginatedRefresh.id: (context) =>
            TrendingScreenPaginatedRefresh(),
        TrendingScreenPaginated.id: (context) => TrendingScreenPaginated(),

        // Other Routes
        AfterSubmitScreen.id: (context) => AfterSubmitScreen(),
        CalendarScreen.id: (context) => CalendarScreen(),
        CommentsScreen.id: (context) => CommentsScreen(),
        FeedbackScreen.id: (context) => FeedbackScreen(),
        // HomeScreen.id: (context) => HomeScreen(),
        HomeScreenTest.id: (context) => HomeScreenTest(),
        LoginScreen.id: (context) => LoginScreen(),
        PostScreen.id: (context) => PostScreen(),
        PrivateScreen.id: (context) => PrivateScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        TrendingScreen.id: (context) => TrendingScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
      },
    );
  }
}



/*Copyright (c) 2020 Razeware LLC

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom
the Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

Notwithstanding the foregoing, you may not use, copy, modify,
merge, publish, distribute, sublicense, create a derivative work,
and/or sell copies of the Software in any work that is designed,
information technology. Permission for such use, copying,
modification, merger, publication, distribution, sublicensing,
creation of derivative works, or sale is expressly withheld.

This project and source code may use libraries or frameworks
that are released under various Open-Source licenses. Use of
those libraries and frameworks are governed by their own
individual licenses.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.*/
