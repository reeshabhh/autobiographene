import 'package:flutter/material.dart';


// Custom imports
import 'package:autobiographene/ui/calendar_screen.dart';
import 'package:autobiographene/ui/paginated_infinite_scroll_screens/home_screen_paginated.dart';
import 'package:autobiographene/ui/paginated_infinite_scroll_screens/trending_screen_paginated.dart';
import 'package:autobiographene/ui/profile_screen.dart';
import 'package:autobiographene/ui/settings_screen.dart';




class CustomBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.grey[300],
      shape: const CircularNotchedRectangle(),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: IconButton(
              icon: Icon(Icons.home),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, HomeScreenPaginated.id);
              },
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: IconButton(
              icon: Icon(Icons.trending_up),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, TrendingScreenPaginated.id);
              },
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: IconButton(
              icon: Icon(Icons.settings),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, SettingsScreen.id);
              },
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: IconButton(
              icon: Icon(Icons.calendar_today),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, CalendarScreen.id);
              },
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: IconButton(
              icon: Icon(Icons.account_circle_outlined),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, ProfileScreen.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
