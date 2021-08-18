import 'package:autobiographene/screens/calendar_screen.dart';
import 'package:autobiographene/screens/paginated_infinite_scroll_screens/home_screen_paginated.dart';
import 'package:autobiographene/screens/paginated_infinite_scroll_screens/trending_test_stream_buil.dart';
import 'package:autobiographene/screens/profile_screen.dart';
import 'package:autobiographene/screens/settings_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CurvedBottomNavBar extends StatefulWidget {
  // const CurvedBottomNavBar({
  //   Key? key,
  // }) : super(key: key);
  final int indexGlobal;
  CurvedBottomNavBar(this.indexGlobal);

  @override
  _CurvedBottomNavBarState createState() => _CurvedBottomNavBarState();
}

class _CurvedBottomNavBarState extends State<CurvedBottomNavBar> {
  final List screens = [
    HomeScreenPaginated.id,
    TrendingTestStreamBuilder.id,
    SettingsScreen.id,
    CalendarScreen.id,
    ProfileScreen.id,
  ];

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: [
        Icon(Icons.home),
        Icon(Icons.trending_up),
        Icon(Icons.settings),
        Icon(Icons.calendar_today),
        Icon(Icons.account_circle_outlined),
        // IconButton(
        //   icon: Icon(Icons.home),
        //   color: Colors.blue,
        //   onPressed: () {
        //     Navigator.pop(context);
        //     Navigator.pushNamed(context, HomeScreenPaginated.id);
        //   },
        // ),
        // IconButton(
        //   icon: Icon(Icons.trending_up),
        //   color: Colors.blue,
        //   onPressed: () {
        //     Navigator.pop(context);
        //     Navigator.pushNamed(context, TrendingTestStreamBuilder.id);
        //   },
        // ),
        // IconButton(
        //   icon: Icon(Icons.settings),
        //   color: Colors.blue,
        //   onPressed: () {
        //     Navigator.pop(context);
        //     Navigator.pushNamed(context, SettingsScreen.id);
        //   },
        // ),
        // IconButton(
        //   icon: Icon(Icons.calendar_today),
        //   color: Colors.blue,
        //   onPressed: () {
        //     Navigator.pop(context);
        //     Navigator.pushNamed(context, CalendarScreen.id);
        //   },
        // ),
        // IconButton(
        //   icon: Icon(Icons.account_circle_outlined),
        //   color: Colors.blue,
        //   onPressed: () {
        //     Navigator.pop(context);
        //     Navigator.pushNamed(context, ProfileScreen.id);
        //   },
        // ),
      ],
      onTap: (indexGlobal) {
        debugPrint('Current indexGlobal in $indexGlobal');
        // Navigator.pop(context);
        Navigator.pushNamed(context, screens[indexGlobal]);
        // indexGlobal = indexGlobal;
      },
    );
  }
}
