import 'package:catalog_chooser/controllers/suggested_item_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SuggestedItemPosition to String', () {
    expect(SuggestedItemPosition(1).toString(), '1st');
    expect(SuggestedItemPosition(2).toString(), '2nd');
    expect(SuggestedItemPosition(3).toString(), '3rd');
    expect(SuggestedItemPosition(4).toString(), '4th');
    expect(SuggestedItemPosition(11).toString(), '11th');
    expect(SuggestedItemPosition(12).toString(), '12th');
    expect(SuggestedItemPosition(13).toString(), '13th');
    expect(SuggestedItemPosition(14).toString(), '14th');
    expect(SuggestedItemPosition(21).toString(), '21st');
    expect(SuggestedItemPosition(22).toString(), '22nd');
    expect(SuggestedItemPosition(23).toString(), '23rd');
    expect(SuggestedItemPosition(24).toString(), '24th');
  });

  test('ranks values of SuggestedItemModel in ascending order', () {
    var itemModel = SuggestedItemModel(
      nth: SuggestedItemPosition(10),
      nthFromEnd: SuggestedItemPosition(1),
      step: SuggestedItemStep.forward(6),
      stepOverEdge: SuggestedItemStep.backward(4),
    );

    expect(itemModel.nthRank, 3);
    expect(itemModel.nthFromEndRank, 0);
    expect(itemModel.stepRank, 2);
    expect(itemModel.stepOverEdgeRank, 1);

    itemModel = SuggestedItemModel(
      nth: SuggestedItemPosition(2),
      nthFromEnd: SuggestedItemPosition(9),
      step: SuggestedItemStep.backward(8),
      stepOverEdge: SuggestedItemStep.forward(2),
    );

    expect(itemModel.nthRank, 0);
    expect(itemModel.nthFromEndRank, 2);
    expect(itemModel.stepRank, 1);
    expect(itemModel.stepOverEdgeRank, 0);
  });
}