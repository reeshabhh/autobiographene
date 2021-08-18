import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  // const CustomDrawer({
  //   Key key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text('Drawer Header'),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Private Page'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/private');
            },
          ),
        ],
      ),
    );
  }
}
