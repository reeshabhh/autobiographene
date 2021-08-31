import 'package:auth_buttons/auth_buttons.dart';
import 'package:autobiographene/ui/paginated_infinite_scroll_screens/home_screen_paginated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Custom imports

import 'package:autobiographene/ui/home_screen_not_used.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String? email;
  String? password;
  String? userName;

  // bool _isLoggedIn = false;
  GoogleSignInAccount? _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

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
              Hero(
                tag: 'logo',
                child: Container(
                  height: 150.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 25.0,
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: false,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  userName = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              // TODO I'm giving you a general idea, replace Android icon with your Google image using Image.asset(google_image)
              // InkWell(
              //   onTap: () {},
              //   child: Ink(
              //     color: Color(0xFF397AF3),
              //     child: Padding(
              //       padding: EdgeInsets.all(6),
              //       child: Wrap(
              //         crossAxisAlignment: WrapCrossAlignment.center,
              //         children: [
              //           IconButton(
              //             onPressed: () {
              //               _googleSignIn.signIn().then(
              //                 (userData) {
              //                   setState(
              //                     () {
              //                       _isLoggedIn = true;
              //                       _userObj = userData;
              //                       Navigator.pushNamed(context, HomeScreen.id);
              //                       print(_userObj.displayName);
              //                     },
              //                   );
              //                 },
              //               ).catchError(
              //                 (e) {
              //                   print(e);
              //                 },
              //               );
              //             },
              //             icon: Icon(Icons.android),
              //           ),
              //           // Icon(Icons.android), // <-- Use 'Image.asset(...)' here
              //           SizedBox(width: 12),
              //           Text('Sign in with Google'),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // AppleAuthButton(
              //   onPressed: () {},
              // ),
              GoogleAuthButton(
                onPressed: () {
                  _googleSignIn.signIn().then(
                    (userData) {
                      setState(
                        () {
                          // _isLoggedIn = true;
                          _userObj = userData;
                          Navigator.pushNamed(context, HomeScreen.id);
                          print(_userObj!.displayName);
                        },
                      );
                    },
                  ).catchError(
                    (e) {
                      print(e);
                    },
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      setState(
                        () {
                          showSpinner = true;
                        },
                      );
                      print(email);
                      print(password);
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email!, password: password!);
                        if (newUser != null) {
                          setState(
                            () {
                              showSpinner = false;
                            },
                          );
                          Navigator.pushNamed(context, HomeScreenPaginated.id);
                          print('email : $email');
                          print('password : $password');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
