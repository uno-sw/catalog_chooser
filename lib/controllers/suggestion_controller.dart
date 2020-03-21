import 'package:flutter/material.dart';

class SuggestionController with ChangeNotifier {
  SuggestionController({List<int> initialItems}) {
    if (initialItems == null) {
      _createList();
    } else {
      _itemCount = initialItems.length;
      _items = initialItems;
    }
  }

  int _itemCount = 10;
  List<int> _items;

  int get itemCount => _itemCount;
  List<int> get items => List.unmodifiable(_items);

  SuggestedItemModel createModelOfItemAt(int index) {
    final nth = _items[index];
    final nthFromEnd = _itemCount - nth + 1;
    SuggestedItemStep steps;
    SuggestedItemStep stepsCrossingSides;

    if (index >= 1) {
      final stepsValue = _items[index] - _items[index - 1];
      steps = SuggestedItemStep(
        steps: stepsValue.abs(),
        forward: !stepsValue.isNegative,
      );
      if (steps.steps > (_itemCount * 0.5)) {
        stepsCrossingSides = SuggestedItemStep(
          steps: _itemCount - steps.steps,
          forward: !steps.forward,
        );
      }
    }

    return SuggestedItemModel(
      nth: SuggestedItemPosition(nth),
      nthFromEnd: SuggestedItemPosition(nthFromEnd),
      steps: steps,
      stepsCrossingSides: stepsCrossingSides,
    );
  }

  void refresh(int itemCount) {
    _itemCount = itemCount;
    _createList();
    notifyListeners();
  }

  void _createList() {
    _items = _serialNumbers().toList()..shuffle();
  }

  Iterable<int> _serialNumbers() sync* {
    for (var i = 1; i <= _itemCount; i++) yield i;
  }
}

@immutable
class SuggestedItemModel {
  const SuggestedItemModel({
    @required this.nth,
    @required this.nthFromEnd,
    this.steps,
    this.stepsCrossingSides,
  });

  final SuggestedItemPosition nth;
  final SuggestedItemPosition nthFromEnd;
  final SuggestedItemStep steps;
  final SuggestedItemStep stepsCrossingSides;
}

@immutable
class SuggestedItemPosition {
  const SuggestedItemPosition(this.nth);

  final int nth;

  @override
  String toString() {
    var suffix;

    switch (nth - (nth * 0.1).floor()) {
      case 1:
        suffix = 'st';
        break;
      case 2:
        suffix = 'nd';
        break;
      case 3:
        suffix = 'rd';
        break;
      default:
        suffix = 'th';
    }

    return '$nth$suffix';
  }
}

@immutable
class SuggestedItemStep {
  const SuggestedItemStep({
    @required this.steps,
    @required this.forward,
  });

  final int steps;
  final bool forward;

  @override
  String toString() {
    return (
      '$steps ${steps <= 1 ? 'step' : 'steps'} '
      '${forward ? 'forward' : 'backward'}'
    );
  }
}
