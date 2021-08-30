import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// Custom imports
import 'package:autobiographene/main.dart';
import 'package:autobiographene/ui/login_screen.dart';
import 'package:autobiographene/ui/feedback_screen.dart';
import 'package:autobiographene/ui/home_screen_not_used.dart';
import 'package:autobiographene/ui/visual/theme/kustom_theme_provider.dart';
import 'package:autobiographene/ui/widgets/custom_bottom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  static const String id = 'settings_screen';
// NOTE: new note
// REVIEW:NOTE:
// FIXME:
// TODO:
  @override
  Widget build(BuildContext context) {
    return _Settings();
  }
}
// TODO this is todo

// NORmal comment

// FIXME this is fixme

class _Settings extends StatelessWidget {
  var email = loggedInUserGlobal!.email;
  @override
  Widget build(BuildContext context) {
    // final _themeChanger = Provider.of<ThemeChanger>(context);
    final _kustomThemeChanger = Provider.of<KustomThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.red),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.android,
                      ),
                      onPressed: () {},
                    ),
                    Container(
                      height: 30,
                      child: Text(
                        'App Settings',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('User Settings'),
                  ],
                ),
                Row(
                  children: <Widget>[Text('themes')],
                ),
                Row()
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            email!,
          ),
          SizedBox(
            height: 20.0,
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return LoginScreen();
                },
              ), (route) => false);
              // Navigator.pushNamed(context, LoginScreen.id);
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              _kustomThemeChanger.setTheme(darkTheme);
              globalDarkThemeChecker = true;

              // _kustomThemeChanger(darkTheme);
            },
            icon: Icon(Icons.dark_mode),
          ),
          IconButton(
            onPressed: () => {
              _kustomThemeChanger.setTheme(lightTheme),
              globalDarkThemeChecker = false,
            }
            //  _themeChanger.setTheme(ThemeData.light()),
            ,
            icon: Icon(Icons.light_mode),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Feedback'),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, FeedbackScreen.id);
                },
                icon: Icon(Icons.feedback_outlined),
              ),
            ],
          ),
          FlatButton(
            child: Row(
              children: <Widget>[
                Expanded(child: Text("Change theme")),
                Switch(value: true, onChanged: null),
              ],
            ),
            onPressed: () {
              // handle change value here
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}

// bool _switchValue = true;

//  CupertinoSwitch(
//               value: _switchValue,
//               onChanged: (value) {
//                 setState(() {
//                   _switchValue = value;
//                 });
//               },
//             ),
