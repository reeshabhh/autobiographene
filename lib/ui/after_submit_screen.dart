import 'package:flutter/material.dart';

// Custom imports

import 'package:autobiographene/ui/home_screen_not_used.dart';

class AfterSubmitScreen extends StatelessWidget {
  static const String id = 'after_submit_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submitted!'),
      ),
      body: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, HomeScreen.id);
        },
        icon: Icon(Icons.check_box_outline_blank),
      ),
    );
  }
}
