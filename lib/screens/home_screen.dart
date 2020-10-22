import 'package:catalog_chooser/app.dart';
import 'package:catalog_chooser/widgets/refresh_dialog.dart';
import 'package:catalog_chooser/widgets/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: theme.primaryColor,
        backgroundColor: theme.colorScheme.onPrimary,
        onPressed: () {
          return showDialog<void>(
            context: context,
            builder: (_) => RefreshDialog(),
          );
        },
        child: const Icon(Icons.refresh),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.primaryColor,
              theme.accentColor,
            ],
          ),
        ),
        child: DefaultTextStyle(
          style: TextStyle(color: theme.colorScheme.onPrimary),
          child: IconTheme(
            data: IconThemeData(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: const Suggestion(),
          ),
        ),
      ),
    );
  }
}

final homeScreenControllerProvider =
    Provider<HomeScreenController>((ref) => HomeScreenController(ref.read));

class HomeScreenController {
  const HomeScreenController(this.read);

  final Reader read;

  void showSnackBar(Widget content) {
    read(scaffoldMessengerKeyProvider).currentState.showSnackBar(
      SnackBar(content: content, behavior: SnackBarBehavior.floating),
    );
  }
}