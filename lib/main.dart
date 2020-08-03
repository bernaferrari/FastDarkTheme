import 'package:bloc/bloc.dart';
import 'package:fastdarktheme/example/blocs/color/color.dart';
import 'package:fastdarktheme/example/main_screen.dart';
import 'package:fastdarktheme/example/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'example/blocs/blocs.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) {
          return BlocProvider(
            create: (context) => ColorBloc()..add(ColorLoadInitial()),
            child: MainScreen(),
          );
        },
      },
      theme: ThemeData(
        typography: Typography.material2018(
          black: Typography.dense2018,
          tall: Typography.tall2018,
          englishLike: Typography.englishLike2018,
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
        buttonTheme: ButtonThemeData(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius / 2),
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
      ),
    );
  }
}
