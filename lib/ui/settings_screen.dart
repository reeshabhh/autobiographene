import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:autobiographene/ui/visual/theme/kustom_theme_provider.dart';

// Custom imports
import 'package:autobiographene/main.dart';
import 'package:autobiographene/ui/login_screen.dart';
import 'package:autobiographene/ui/feedback_screen.dart';
import 'package:autobiographene/ui/home_screen_not_used.dart';
import 'package:autobiographene/ui/widgets/custom_bottom_app_bar.dart';
import 'package:autobiographene/ui/visual/theme/theme_bloc.dart';
import 'package:autobiographene/bloc/theme_bloc/theme_bloc.dart';
import 'package:autobiographene/bloc/theme_bloc/theme_event.dart';
// import 'package:autobiographene/ui/visual/theme/kustom_theme_provider.dart';

AppTheme? _currTheme;

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var email = loggedInUserGlobal!.email;

  _setTheme(bool darkTheme) {
    _currTheme = darkTheme ? AppTheme.lightTheme : AppTheme.darkTheme;
    BlocProvider.of<ThemeBloc>(context).add(
      ThemeEvent(appTheme: AppTheme.darkTheme),
    );

    // context.bloc<ThemeBloc>().add(ThemeEvent(appTheme: AppTheme.darkTheme),);

    // final _themeChanger = Provider.of<ThemeChanger>(context);
  }
  // final _kustomThemeChanger = Provider.of<KustomThemeProvider>(context);

  Widget build(BuildContext context) {
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
              _setTheme(false);
              // _kustomThemeChanger.setTheme(darkTheme);
              globalDarkThemeChecker = true;

              // _kustomThemeChanger(darkTheme);
            },
            icon: Icon(Icons.dark_mode),
          ),
          IconButton(
            onPressed: () => {
              _setTheme(true),
              // _kustomThemeChanger.setTheme(lightTheme),
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
          Switch(
              value: _currTheme == AppTheme.lightTheme,
              onChanged: (val) {
                _setTheme(val);
              }),
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
