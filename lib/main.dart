import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart'; //? is it required
//FIXME could not find the provider //ERROR

// Custom imports

import 'package:autobiographene/ui/after_submit_screen.dart';
import 'package:autobiographene/ui/calendar_screen.dart';
import 'package:autobiographene/ui/comments_screen.dart';
import 'package:autobiographene/ui/feedback_screen.dart';
import 'package:autobiographene/ui/home_screen_test.dart';
import 'package:autobiographene/ui/login_screen.dart';
import 'package:autobiographene/ui/paginated_infinite_scroll_screens/home_screen_paginated.dart';
import 'package:autobiographene/ui/paginated_infinite_scroll_screens/trending_screen_paginated.dart';
import 'package:autobiographene/ui/paginated_infinite_scroll_screens/trending_screen_paginated_discarded.dart';
import 'package:autobiographene/ui/paginated_infinite_scroll_screens/trending_screen_paginated_refresh.dart';
import 'package:autobiographene/ui/paginated_infinite_scroll_screens/trending_test_stream_buil.dart';
import 'package:autobiographene/ui/post_screen.dart';
import 'package:autobiographene/ui/private_screen.dart';
import 'package:autobiographene/ui/profile_screen.dart';
import 'package:autobiographene/ui/registration_screen.dart';
import 'package:autobiographene/ui/settings_screen.dart';
import 'package:autobiographene/ui/splash_screen.dart';
import 'package:autobiographene/ui/trending_screen.dart';
import 'package:autobiographene/ui/welcome_screen.dart';
import 'package:autobiographene/bloc/theme/theme_bloc.dart';
import 'package:autobiographene/bloc/theme/theme_state.dart';

// bool globalDarkThemeChecker = true;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialAppWithTheme();
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
          return MaterialApp(
            theme: state.themeData,
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
              TrendingTestStreamBuilder.id: (context) =>
                  TrendingTestStreamBuilder(),
              TrendingScreenPaginatedRefresh.id: (context) =>
                  TrendingScreenPaginatedRefresh(),
              TrendingScreenPaginated.id: (context) =>
                  TrendingScreenPaginated(),

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
        },
      ),
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
