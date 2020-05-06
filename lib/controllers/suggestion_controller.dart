import 'package:flutter/material.dart';

import 'suggested_item_model.dart';

class SuggestionController with ChangeNotifier {
  SuggestionController({List<int> initialItems})
      : _items = initialItems ?? _createList(10);

  final List<int> _items;
  final _models = <int, SuggestedItemModel>{};

  List<int> get items => List.unmodifiable(_items);

  SuggestedItemModel model(int index) {
    if (_models[index] != null) return _models[index];
    else return _models[index] = _createModel(index);
  }

  void refresh(int itemCount) {
    _models.clear();
    _items
        ..clear()
        ..addAll(_createList(itemCount));
    notifyListeners();
  }

  SuggestedItemModel _createModel(int index) {
    final nth = _items[index];
    final nthFromEnd = _items.length - nth + 1;
    SuggestedItemStep steps;
    SuggestedItemStep stepsOverEdge;

    if (index >= 1) {
      final stepsValue = _items[index] - _items[index - 1];
      steps = SuggestedItemStep(
        stepsValue.abs(),
        forward: !stepsValue.isNegative,
      );
      if (steps.value > (_items.length * 0.5)) {
        stepsOverEdge = SuggestedItemStep(
          _items.length - steps.value,
          forward: !steps.forward,
        );
      }
    }

    return SuggestedItemModel(
      nth: SuggestedItemPosition(nth),
      nthFromEnd: SuggestedItemPosition(nthFromEnd),
      steps: steps,
      stepsOverEdge: stepsOverEdge,
    );
  }

  static List<int> _createList(int itemCount) {
    return List.generate(itemCount, (i) => i + 1)..shuffle();
  }
}
