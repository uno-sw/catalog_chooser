import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catalog Chooser',
      navigatorKey: context.watch(),
      theme: ThemeData(
        primaryColor: Color(0xFFFF5287),
        accentColor: Color(0xFFFFA44A),
      ),
      home: const HomeScreen(),
    );
  }
}