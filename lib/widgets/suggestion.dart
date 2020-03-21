import 'package:catalog_chooser/controllers/suggestion_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Suggestion extends StatelessWidget {
  const Suggestion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: context.read(),
      itemCount: context.select(
        (SuggestionController controller) => controller.items.length,
      ),
      itemBuilder: (context, i) => SuggestedItem(index: i),
    );
  }
}

class SuggestedItem extends StatelessWidget {
  const SuggestedItem({Key key, @required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final suggestionController = context.read<SuggestionController>();
    final itemModel = suggestionController.createModelOfItemAt(index);

    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            '${index + 1} of ${suggestionController.itemCount}',
            style: textTheme.subtitle1,
          ),
          Text('${itemModel.nth.nth}', style: textTheme.headline1),
          Text('${itemModel.nthFromEnd} from end', style: textTheme.bodyText1),
          if (itemModel.steps != null)
              Text('${itemModel.steps}', style: textTheme.bodyText1),
          if (itemModel.stepsCrossingSides != null)
              Text(
                '${itemModel.stepsCrossingSides} (if endlessly scrollable)',
                style: textTheme.bodyText1,
              ),
        ],
      ),
    );
  }
}
