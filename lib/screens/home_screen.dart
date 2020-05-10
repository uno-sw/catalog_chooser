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
      key: context.select((HomeModel model) => model.scaffoldKey),
      appBar: AppBar(title: const Text('Catalog Chooser')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<HomeModel>().showRefreshDialog(),
        child: const Icon(Icons.refresh),
      ),
      body: const Suggestion(),
    );
  }
}

class HomeModel {
  HomeModel(this.locator) : assert(locator != null);

  final Locator locator;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  SuggestionNotifier get _suggestionNotifier => locator();
  PageController get _pageController => locator();

  void showRefreshDialog() async {
    final result = await showDialog<int>(
      context: scaffoldKey.currentContext,
      builder: (context) => MultiProvider(
        providers: [
          Provider(create: (_) => GlobalKey<FormState>()),
          ChangeNotifierProvider(
            create: (_) => TextEditingController(
              text: '${context.watch<SuggestionState>().nthList.length}',
            ),
          ),
        ],
        child: ChangeNotifierProvider(
          create: (context) => RefreshDialogController(locator: context.read),
          child: const RefreshDialog(),
        ),
      ),
    );

    if (result != null) refresh(result);
  }

  void showSnackBar(Widget content) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(content: content, behavior: SnackBarBehavior.floating),
    );
  }

  void refresh(int itemCount) {
    _suggestionNotifier.refresh(itemCount);
    _pageController.jumpToPage(0);
    showSnackBar(Text('Refreshed with $itemCount items.'));
  }
}
