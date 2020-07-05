import 'package:catalog_chooser/controllers/suggestion_notifier.dart';
import 'package:catalog_chooser/widgets/refresh_dialog.dart';
import 'package:catalog_chooser/widgets/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.select((HomeScreenController c) => c.scaffoldKey),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeScreenController>().showRefreshDialog();
        },
        child: const Icon(Icons.refresh),
      ),
      body: const Suggestion(),
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