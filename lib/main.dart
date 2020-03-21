import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'controllers/suggestion_controller.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      Provider(create: (_) => GlobalKey<NavigatorState>()),
      ChangeNotifierProvider(create: (_) => PageController()),
      ChangeNotifierProvider(create: (_) => SuggestionController()),
    ],
    child: const App(),
  ),
);
