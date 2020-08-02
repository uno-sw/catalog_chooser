import 'package:catalog_chooser/controllers/suggestion_notifier.dart';
import 'package:catalog_chooser/widgets/refresh_dialog.dart';
import 'package:catalog_chooser/widgets/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: context.select((HomeScreenController c) => c.scaffoldKey),
      floatingActionButton: FloatingActionButton(
        foregroundColor: theme.primaryColor,
        backgroundColor: theme.colorScheme.onPrimary,
        onPressed: () {
          context.read<HomeScreenController>().showRefreshDialog();
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

class HomeScreenController {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void showRefreshDialog() async {
    await showDialog(
      context: scaffoldKey.currentContext,
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => TextEditingController(
            text: '${context.read<SuggestionState>().nthList.length}',
          ),
          child: RefreshDialog(),
      );
      },
    );
  }

  void showSnackBar(Widget content) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(content: content, behavior: SnackBarBehavior.floating),
    );
  }
}