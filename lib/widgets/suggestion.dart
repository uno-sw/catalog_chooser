import 'package:catalog_chooser/controllers/suggested_item_model.dart';
import 'package:catalog_chooser/controllers/suggestion_notifier.dart';
import 'package:catalog_chooser/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Suggestion extends StatelessWidget {
  const Suggestion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final suggestion = context.watch<SuggestionState>();

    return PageView.builder(
      controller: context.watch<SuggestionController>().pageController,
      itemCount: suggestion.nthList.length,
      itemBuilder: (context, i) => SuggestedItem(
        index: i,
        itemCount: suggestion.nthList.length,
        model: suggestion.itemModel(i),
      ),
    );
  }
}

class SuggestedItem extends StatelessWidget {
  SuggestedItem({
    Key key,
    @required this.index,
    @required this.itemCount,
    @required this.model,
  });

  final int index;
  final int itemCount;
  final SuggestedItemModel model;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            '${index + 1} of $itemCount',
            style: textTheme.subtitle1,
          ),
          Text('${model.nth.value}', style: textTheme.headline1),
          Text('${model.nthFromEnd} from end', style: textTheme.bodyText1),
          if (model.steps != null)
              Text('${model.steps}', style: textTheme.bodyText1),
          if (model.stepsOverEdge != null)
              Text(
                '${model.stepsOverEdge} (if endlessly scrollable)',
                style: textTheme.bodyText1,
              ),
        ],
      ),
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