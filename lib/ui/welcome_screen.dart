import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:autobiographene/main.dart';
import 'package:flutter/material.dart';

// Custom imports
import 'package:autobiographene/ui/login_screen.dart';
import 'package:autobiographene/ui/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    mediaQueryGlobal = MediaQuery.of(context);
    mediaQueryOrientationGlobal = mediaQueryGlobal.orientation;
    mediaQuerySizeGlobal = MediaQuery.of(context).size;
    if (mediaQueryOrientationGlobal == Orientation.portrait) {
      mediaQueryHeightGlobal = mediaQuerySizeGlobal.height;
      mediaQueryWidthGlobal = mediaQuerySizeGlobal.width;
      // mediaQueryHeightGlobal = mediaQueryHeightGlobal - 100;
      // mediaQueryWidthGlobal = mediaQueryWidthGlobal - 50;
      print(mediaQuerySizeGlobal); // I/flutter ( 6545): Size(411.4, 820.6)
    } else {
      mediaQueryWidthGlobal = mediaQuerySizeGlobal.height;
      mediaQueryHeightGlobal = mediaQuerySizeGlobal.width;
      //    mediaQueryHeightGlobal = mediaQueryHeightGlobal - 100;
      // mediaQueryWidthGlobal = mediaQueryWidthGlobal - 50;
      print(mediaQuerySizeGlobal);
    }
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
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
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => RegistrationScreen(),
                    //     ),
                    //   );
                    // Instead of using Navigator.push I can also use Navigator.pushnamed. In this case I will have to pass few things and it will be fast because I will not have to create an object instead I will pass a static variable from that class
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
            RoundedButton(
              text: 'Register',
              idOfRoute: RegistrationScreen.id,
            )
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final Color? colour;
  final String? title;
  final String? text;
  final String? idOfRoute;
  // final Function? onPressed;

  RoundedButton(
      {this.colour, this.title, @required this.text, @required this.idOfRoute});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            Navigator.pushNamed(context, idOfRoute!);
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text!,
          ),
        ),
      ),
    );
  }
}
