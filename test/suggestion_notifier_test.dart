import 'package:catalog_chooser/controllers/suggested_item_model.dart';
import 'package:catalog_chooser/controllers/suggestion_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SuggestionNotifier notifier;

  setUp(() {
    notifier = SuggestionNotifier();
  });

  test('creates list of 10 items first', () {
    final list = notifier.debugState.nthList;
    expect(list.length, 10);
    expect(list.contains(1), true);
    expect(list.contains(2), true);
    expect(list.contains(3), true);
    expect(list.contains(4), true);
    expect(list.contains(5), true);
    expect(list.contains(6), true);
    expect(list.contains(7), true);
    expect(list.contains(8), true);
    expect(list.contains(9), true);
    expect(list.contains(10), true);
  });

  test('refresh with given number of items', () {
    notifier.refresh(5);
    final list = notifier.debugState.nthList;
    expect(list.length, 5);
    expect(list.contains(1), true);
    expect(list.contains(2), true);
    expect(list.contains(3), true);
    expect(list.contains(4), true);
    expect(list.contains(5), true);
  });

  test('creation of item models', () {
    final notifier = SuggestionNotifier(initialList: [3, 5, 1, 2, 4]);
    final state = notifier.debugState;

    expect(
      state.itemModel(0),
      SuggestedItemModel(
        nth: SuggestedItemPosition(3),
        nthFromEnd: SuggestedItemPosition(3),
      ),
    );

    expect(
      state.itemModel(1),
      SuggestedItemModel(
        nth: SuggestedItemPosition(5),
        nthFromEnd: SuggestedItemPosition(1),
        step: SuggestedItemStep.forward(2),
      )
    );

    expect(
      state.itemModel(2),
      SuggestedItemModel(
        nth: SuggestedItemPosition(1),
        nthFromEnd: SuggestedItemPosition(5),
        step: SuggestedItemStep.backward(4),
        stepOverEdge: SuggestedItemStep.forward(1),
      )
    );

    expect(
      state.itemModel(3),
      SuggestedItemModel(
        nth: SuggestedItemPosition(2),
        nthFromEnd: SuggestedItemPosition(4),
        step: SuggestedItemStep.forward(1),
      )
    );

    expect(
      state.itemModel(4),
      SuggestedItemModel(
        nth: SuggestedItemPosition(4),
        nthFromEnd: SuggestedItemPosition(2),
        step: SuggestedItemStep.forward(2),
      )
    );
  });
}