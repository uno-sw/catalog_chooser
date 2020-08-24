import 'package:catalog_chooser/controllers/suggestion_notifier.dart';
import 'package:catalog_chooser/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'suggested_item.dart';

class Suggestion extends StatelessWidget {
  const Suggestion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final suggestion = context.watch<SuggestionState>();

    return Stack(
      children: [
        GlowingOverscrollIndicator(
          axisDirection: AxisDirection.right,
          color: Theme.of(context).colorScheme.onPrimary,
          child: PageView.builder(
            controller: context.watch<SuggestionController>().pageController,
            itemCount: suggestion.nthList.length,
            itemBuilder: (context, i) => SuggestedItem(
              index: i,
              itemCount: suggestion.nthList.length,
              model: suggestion.itemModel(i),
            ),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 32.0),
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(32.0),
              ),
              child: Text(
                'Swipe left to see next suggestion',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
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