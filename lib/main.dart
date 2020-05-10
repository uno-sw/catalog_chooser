import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'controllers/suggestion_notifier.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      Provider(create: (_) => GlobalKey<NavigatorState>()),
      ChangeNotifierProvider(create: (_) => PageController()),
      StateNotifierProvider<SuggestionNotifier, SuggestionState>(
        create: (_) => SuggestionNotifier(),
      ),
    ],
    child: const App(),
  ),
);
