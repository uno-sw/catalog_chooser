import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';

import 'suggested_item_model.dart';

part 'suggestion_notifier.freezed.dart';

@freezed
abstract class SuggestionState implements _$SuggestionState {
  const SuggestionState._();
  const factory SuggestionState(BuiltList<int> nthList) = _SuggestionState;

  SuggestedItemModel itemModel(int index) {
    final nth = nthList[index];
    final nthFromEnd = nthList.length - nth + 1;
    SuggestedItemStep steps;
    SuggestedItemStep stepsOverEdge;

    if (index >= 1) {
      final stepsValue = nthList[index] - nthList[index - 1];
      steps = SuggestedItemStep(
        stepsValue.abs(),
        forward: !stepsValue.isNegative,
      );
      if (steps.value > (nthList.length * 0.5)) {
        stepsOverEdge = SuggestedItemStep(
          nthList.length - steps.value,
          forward: !steps.forward,
        );
      }
    }

    return SuggestedItemModel(
      nth: SuggestedItemPosition(nth),
      nthFromEnd: SuggestedItemPosition(nthFromEnd),
      step: steps,
      stepOverEdge: stepsOverEdge,
    );
  }
}

final suggestionNotifierProvider =
    StateNotifierProvider((ref) => SuggestionNotifier());

class SuggestionNotifier extends StateNotifier<SuggestionState> {
  SuggestionNotifier({List<int> initialList})
      : super(SuggestionState(BuiltList(initialList ?? _shuffledList(10))));

  void refresh(int itemCount) {
    state = SuggestionState(BuiltList(_shuffledList(itemCount)));
  }

  static List<int> _shuffledList(int itemCount) =>
      List.generate(itemCount, (i) => i + 1)..shuffle();
}