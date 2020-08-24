import 'package:catalog_chooser/controllers/suggested_item_model.dart';
import 'package:flutter/material.dart';

import 'suggested_item_value.dart';

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
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: Theme.of(context).colorScheme.onPrimary,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  '${index + 1} of $itemCount',
                  style: Theme.of(context).textTheme.subtitle1.apply(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                SuggestedItemValue(
                  icon: const RotatedBox(
                    quarterTurns: 2,
                    child: Icon(Icons.file_upload),
                  ),
                  rank: model.nthRank,
                  value: model.nth.value,
                  suffix: model.nth.suffixLabel,
                ),
                SuggestedItemValue(
                  icon: const Icon(Icons.file_upload),
                  rank: model.nthFromEndRank,
                  value: model.nthFromEnd.value,
                  suffix: model.nthFromEnd.suffixLabel,
                  additional: 'from end',
                ),
                if (model.step != null)
                    SuggestedItemValue(
                      icon: Icon(model.step.forward
                          ? Icons.arrow_downward
                          : Icons.arrow_upward
                      ),
                      rank: model.stepRank,
                      value: model.step.value,
                      additional: model.step.suffixLabel,
                    ),
                if (model.stepOverEdge != null)
                    SuggestedItemValue(
                      icon: Icon(model.stepOverEdge.forward
                          ? Icons.arrow_downward
                          : Icons.arrow_upward
                      ),
                      rank: model.stepOverEdgeRank,
                      value: model.stepOverEdge.value,
                      additional: '${model.stepOverEdge.suffixLabel}\n'
                          '(crossing edge)',
                    ),
                const SizedBox(height: 64.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}