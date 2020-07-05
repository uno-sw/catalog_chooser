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
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                '${index + 1} of $itemCount',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              _SuggestedItemValueText(
                rank: model.nthRank,
                value: model.nth.value,
                suffix: model.nth.suffixLabel,
              ),
              _SuggestedItemValueText(
                rank: model.nthFromEndRank,
                value: model.nthFromEnd.value,
                suffix: model.nthFromEnd.suffixLabel,
                additional: 'from end',
              ),
              if (model.step != null)
                  _SuggestedItemValueText(
                    rank: model.stepRank,
                    value: model.step.value,
                    additional: model.step.suffixLabel,
                  ),
              if (model.stepOverEdge != null)
                  _SuggestedItemValueText(
                    rank: model.stepOverEdgeRank,
                    value: model.stepOverEdge.value,
                    additional: '${model.stepOverEdge.suffixLabel}\n'
                        '(crossing edge)',
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestedItemValueText extends StatelessWidget {
  const _SuggestedItemValueText({
    Key key,
    @required this.rank,
    this.value,
    this.suffix,
    this.additional,
  }) : super(key: key);

  final int rank;
  final int value;
  final String suffix;
  final String additional;

  static const fontSizes = [72.0, 48.0, 32.0, 24.0];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$value',
                  style: TextStyle(fontSize: fontSizes[rank]),
                ),
                if (suffix != null)
                    TextSpan(text: suffix),
              ],
            ),
          ),
          if (additional != null)
              Text(additional),
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