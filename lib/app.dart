import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/home_screen.dart';

final scaffoldMessengerKeyProvider =
    Provider((ref) => GlobalKey<ScaffoldMessengerState>());

class App extends ConsumerWidget {
  const App({Key key}) : super(key: key);

  static const primaryColor = Color(0xFFFF5287);
  static const secondaryColor = Color(0xFFFFA44A);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp(
      title: 'Catalog Chooser',
      scaffoldMessengerKey: watch(scaffoldMessengerKeyProvider),
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
        )
      ),
      home: const HomeScreen(),
    );
  }
}