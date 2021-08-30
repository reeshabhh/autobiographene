import 'package:flutter/material.dart';

class PrivateScreen extends StatelessWidget {
  static const String id = 'private_screen';
  
  @override
  Widget build(BuildContext context) {
    return _PrivatePage();
  }
}

class _PrivatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Private Page'),
      ),
      body:
          // Container(
//        color: Colors.grey,
//        child: ListView(addAutomaticKeepAlives: true, children: <Widget>[
//          Row(
          // children: <Widget>[
          Center(
        child: Text('This is secret page'),
      ),
    );
  }
}
