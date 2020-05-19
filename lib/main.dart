import 'package:catalog_chooser/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'controllers/suggestion_notifier.dart';
import 'widgets/suggestion.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      Provider(create: (_) => GlobalKey<NavigatorState>()),
      Provider(create: (_) => HomeScreenController()),
      StateNotifierProvider<SuggestionNotifier, SuggestionState>(
        create: (_) => SuggestionNotifier(),
      ),
    ],
    child: ChangeNotifierProvider(
      create: (context) => SuggestionController(context.read),
      child: const App(),
    ),
  ),
);