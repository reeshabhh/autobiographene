import 'package:autobiographene/widgets/curved_bottom_nav_bar.dart';
import 'package:autobiographene/widgets/custom_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  static const String id = 'feedback_screen';

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Screen'),
      ),
      bottomNavigationBar: CurvedBottomNavBar(7),
    );
  }
}
