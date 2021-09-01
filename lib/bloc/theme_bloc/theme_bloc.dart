// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'theme_event.dart';
// part 'theme_state.dart';

// class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
//   ThemeBloc() : super(ThemeInitial());

//   @override
//   Stream<ThemeState> mapEventToState(
//     ThemeEvent event,
//   ) async* {
//     // TODO: implement mapEventToState
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';

// Custom imports

import 'package:autobiographene/bloc/theme_bloc/theme_event.dart';
import 'package:autobiographene/bloc/theme_bloc/theme_state.dart';
import 'package:autobiographene/ui/visual/theme/themes_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  //
  ThemeBloc()
      : super(
          ThemeState(
            themeData: AppThemes.appThemeData[AppTheme.lightTheme],
          ),
        );

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeEvent) {
      yield ThemeState(
        themeData: AppThemes.appThemeData[event.appTheme],
      );
    }

    // throw UnimplementedError();
  }
}
