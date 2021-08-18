import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
// import 'package:lifebook/ui/registration_screen.dart';
// import 'package:lifebook/ui/ui/login_screen.dart';

// Custom imports
import '../screens/screens.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                      // child: Image.asset('images/logo.png'),
                      // height: 60.0,
                      ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Auto Bio Graphene',
                      textStyle: const TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            // RoundedButton(
            //   title: 'Log In',
            //   colour: Colors.lightBlueAccent,
            //   onPressed: () {
            //     // Navigator.pushNamed(context, LoginScreen.id);
            //     print('====================================================');
            //     print('LoginScreen push before');
            //     Navigator.pushNamed(context, LoginScreen.id);
            //     print('LoginScreen push after');
            //     print('====================================================');
            //   },
            // ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    // print(
                    //     '====================================================');
                    // print('LoginScreen push before');
                    Navigator.pushNamed(context, LoginScreen.id);
                    // print('LoginScreen push after');
                    // print(
                    //     '====================================================');
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => RegistrationScreen(),
                    //     ),
                    //   );
                    // Instead of using Navigator.push I can also use Navigator.pushnamed. In this case I will have to pass few things and it will be fast because I will not have to create an object instead I will pass a static variable from that class
                    //
                    // Navigator.pushNamed(context, RegistrationScreen.id);
                    // print(
                    //     '====================================================');
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton({this.colour, this.title, @required this.onPressed});

  final Color? colour;
  final String? title;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          //FIXME changed here

          onPressed: () {},
          // onPressed: () {
          //Go to login screen.
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => LoginScreen(),
          //   ),
          // );
          // Instead of using Navigator.push I can also use Navigator.pushnamed. In this case I will have to pass few things and it will be fast because I will not have to create an object instead I will pass a static variable from that class
          //
          // Navigator.pushNamed(context, LoginScreen.id);
          // },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            'Log In',
          ),
        ),
      ),
    );
  }
}
