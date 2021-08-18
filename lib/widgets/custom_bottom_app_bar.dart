import 'package:autobiographene/screens/home_screen_test.dart';
import 'package:autobiographene/screens/paginated_infinite_scroll_screens/home_screen_paginated.dart';
import 'package:autobiographene/screens/paginated_infinite_scroll_screens/trending_screen_paginated.dart';
import 'package:autobiographene/screens/paginated_infinite_scroll_screens/trending_screen_paginated_discarded.dart';
import 'package:autobiographene/screens/paginated_infinite_scroll_screens/trending_screen_paginated_refresh.dart';
import 'package:autobiographene/screens/paginated_infinite_scroll_screens/trending_test_stream_buil.dart';
// import 'package:autobiographene/screens/home_screen_test.dart';
import 'package:flutter/material.dart';
import 'package:autobiographene/screens/screens.dart';

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
