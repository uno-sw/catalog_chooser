import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFFF5287);
    const secondaryColor = Color(0xFFFFA44A);

    return MaterialApp(
      title: 'Catalog Chooser',
      navigatorKey: context.watch(),
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