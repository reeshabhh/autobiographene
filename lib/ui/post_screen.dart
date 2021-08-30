import 'package:flutter/material.dart';

// TODO the thing is it is very easy to post something without going to post screen
// opening the postscreen is like a resistance. So I don't need it ideally

class PostScreen extends StatefulWidget {
  static const String id = 'post_screen';

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Screen'),),
    );
  }
}
