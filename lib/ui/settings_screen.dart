import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:autobiographene/ui/visual/theme/kustom_theme_provider.dart';

// Custom imports
import 'package:autobiographene/ui/login_screen.dart';
import 'package:autobiographene/ui/feedback_screen.dart';
import 'package:autobiographene/ui/home_screen_not_used.dart';
import 'package:autobiographene/ui/widgets/custom_bottom_app_bar.dart';
import 'package:autobiographene/ui/visual/theme/themes_bloc.dart';
import 'package:autobiographene/bloc/theme_bloc/theme_bloc.dart';
import 'package:autobiographene/bloc/theme_bloc/theme_event.dart';
// import 'package:autobiographene/ui/visual/theme/kustom_theme_provider.dart';

// AppTheme? _currTheme;
// bool boolTrue = true;

bool _currThemeBoolean = true;

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var email = loggedInUserGlobal!.email;
  AppTheme? _currTheme = AppTheme.lightTheme;

  _toggleTheme(bool val) {
    // _currThemeBoolean = val;
    val == true
        ? BlocProvider.of<ThemeBloc>(context)
            .add(ThemeEvent(appTheme: AppTheme.lightTheme))
        : BlocProvider.of<ThemeBloc>(context)
            .add(ThemeEvent(appTheme: AppTheme.darkTheme));
  }

  _setTheme(bool darkTheme) {
    _currTheme = darkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;
    BlocProvider.of<ThemeBloc>(context).add(
      ThemeEvent(appTheme: AppTheme.darkTheme),
    );
    // _currTheme = AppTheme.lightTheme;

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
              BlocProvider.of<ThemeBloc>(context).add(
                ThemeEvent(appTheme: AppTheme.darkTheme),
              );
              // _setTheme(false);
              // _kustomThemeChanger.setTheme(darkTheme);
              // globalDarkThemeChecker = true;

              // _kustomThemeChanger(darkTheme);
            },
            icon: Icon(Icons.dark_mode),
          ),
          IconButton(
            onPressed: () => {
              BlocProvider.of<ThemeBloc>(context)
                  .add(ThemeEvent(appTheme: AppTheme.lightTheme)),
              // _setTheme(true),
              // _kustomThemeChanger.setTheme(lightTheme),
              // globalDarkThemeChecker = false,
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
              // _currTheme != _currTheme;
              _setTheme(val);
            },
          ),
          Switch(
            value: _currThemeBoolean,
            onChanged: (isOn) => setState(() => _currThemeBoolean = isOn),

            // {
            //   _toggleTheme(val);
            // }
          ),
          Switch(
            value: _currThemeBoolean,
            onChanged: (isChanged) => setState(
              () {
                _toggleTheme(isChanged);
                _currThemeBoolean = isChanged;
              },
            ),
          ),
          Icon(
            _currThemeBoolean ? Icons.light_mode : Icons.dark_mode,
          ),
          IconButton(
            onPressed: () => setState(
              () {
                // debugPrint(
                // BlocProvider.of<ThemeBloc>(context).state.toString());
                print(BlocProvider.of<ThemeBloc>(context)
                    .state
                    .themeData!
                    .scaffoldBackgroundColor
                    .toString());
                print(BlocProvider.of<ThemeBloc>(context)
                    .state
                    .themeData
                    .toString());
                print(BlocProvider.of<ThemeBloc>(context)
                    .state.themeData
                     == AppTheme.darkTheme);
                _currThemeBoolean = !_currThemeBoolean;
                _toggleTheme(_currThemeBoolean);
              },
            ),
            icon: _currThemeBoolean
                ? Icon(Icons.light_mode)
                : Icon(Icons.dark_mode),
          )
          // _currThemeBoolean
          //     ? IconButton(
          //         onPressed: () {
          //           setState(
          //             () => _currThemeBoolean = !_currThemeBoolean,
          //           );
          //         },
          //         icon: Icon(Icons.light_mode))
          //     : IconButton(
          //         onPressed: () {
          //           setState(
          //             () => _currThemeBoolean = !_currThemeBoolean,
          //           );
          //         },
          //         icon: Icon(Icons.dark_mode),
          //       ),
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
