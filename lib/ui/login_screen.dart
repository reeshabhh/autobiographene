import 'package:autobiographene/main.dart';
import 'package:autobiographene/ui/home_screen_test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// Custom imports

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListView(
                  shrinkWrap: true,
                  reverse: true,
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Container(
                        height: mediaQueryHeightGlobal / 10,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                    SizedBox(
                      height: mediaQueryHeightGlobal / 17,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        //Do something with the user input.
                        email = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: mediaQueryHeightGlobal / 80,
                            horizontal: mediaQueryWidthGlobal / 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(mediaQueryWidthGlobal / 12.5),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(mediaQueryWidthGlobal / 12.5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(mediaQueryWidthGlobal / 12.5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaQueryHeightGlobal / 85,
                    ),
                    TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        //Do something with the user input.
                        password = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your password.',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: mediaQueryHeightGlobal / 80,
                            horizontal: mediaQueryWidthGlobal / 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(mediaQueryWidthGlobal / 12.5),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(mediaQueryWidthGlobal / 12.5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(mediaQueryWidthGlobal / 12.5),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mediaQueryHeightGlobal / 34,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: mediaQueryHeightGlobal / 50),
                      child: Material(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.all(
                          Radius.circular(mediaQueryWidthGlobal / 12.5),
                        ),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () async {
                            setState(
                              () {
                                showSpinner = true;
                              },
                            );
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email!, password: password!);
                              if (user != null) {
                                setState(
                                  () {
                                    showSpinner = false;
                                  },
                                );
                                Navigator.pushNamed(context, HomeScreenTest.id);
                                // print(email);
                                // print(password);
                              } else {
                                debugPrint('user does not exists');
                              }

                              // START
                              // if (email != null && password != null) {
                              //   var user = FirebaseAuthService()
                              //       .sighInWithEmailPass(email!, password!);
                              //   if (user != null) {
                              //     setState(
                              //       () {
                              //         showSpinner = false;
                              //       },
                              //     );
                              //     Navigator.pushNamed(context, HomeScreenTest.id);
                              //   }
                              // }
                              // print(email);
                              // print(password);
                              // END
                            } catch (e) {
                              print(e);
                              Navigator.pushNamed(context, LoginScreen.id);
                            }
                          },
                          minWidth: mediaQueryWidthGlobal / 2,
                          height: mediaQueryHeightGlobal / 19,
                          child: Text(
                            'Log In',
                          ),
                        ),
                      ),
                    ),
                  ].reversed.toList(),
                ),
              ]),
        ),
      ),
    );
  }
}
