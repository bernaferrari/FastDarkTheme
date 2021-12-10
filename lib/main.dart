import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'example/blocs/color_cubit.dart';
import 'example/blocs/simple_bloc_observer.dart';
import 'example/main_screen.dart';
import 'example/util/constants.dart';

Future<void> main() async {
  BlocOverrides.runZoned(() {}, blocObserver: SimpleBlocObserver());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        pages: [
          MaterialPage<dynamic>(
            key: const ValueKey('MainPage'),
            child: BlocProvider(
              create: (context) => ColorCubit(),
              child: const MainScreen(),
            ),
          ),
        ],
        onPopPage: (route, dynamic result) => route.didPop(result),
      ),
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
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
