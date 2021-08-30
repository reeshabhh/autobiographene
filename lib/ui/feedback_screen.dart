import 'package:flutter/material.dart';


// Custom imports

import 'package:autobiographene/ui/widgets/curved_bottom_nav_bar.dart';


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
