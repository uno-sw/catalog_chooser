import 'package:catalog_chooser/controllers/suggestion_notifier.dart';
import 'package:catalog_chooser/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'floating_panel.dart';
import 'page_indicator.dart';
import 'suggested_item.dart';

class Suggestion extends StatelessWidget {
  const Suggestion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final suggestion = context.watch<SuggestionState>();
    final pageController = context.watch<SuggestionController>().pageController;

    return Stack(
      children: [
        GlowingOverscrollIndicator(
          axisDirection: AxisDirection.right,
          color: Theme.of(context).colorScheme.onPrimary,
          child: PageView.builder(
            controller: pageController,
            itemCount: suggestion.nthList.length,
            itemBuilder: (context, i) {
              return SuggestedItem(model: suggestion.itemModel(i));
            },
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: const PageIndicator(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: FloatingPanel(
              child: Text(
                'Swipe left to see next suggestion',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SuggestionController with ChangeNotifier {
  SuggestionController(this.locator) : assert(locator != null);

  final Locator locator;
  final pageController = PageController();

  SuggestionNotifier get _suggestionNotifier => locator();
  HomeScreenController get _homeScreenController => locator();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void refresh(int itemCount) {
    _suggestionNotifier.refresh(itemCount);
    pageController.jumpToPage(0);
    _homeScreenController.showSnackBar(
      Text('Refreshed with $itemCount items.'),
    );
  }
}