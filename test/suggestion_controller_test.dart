import 'package:catalog_chooser/controllers/suggestion_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('creates list of 10 items first', () {
    final controller = SuggestionController();
    final list = controller.items;
    expect(controller.itemCount, 10);
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
    final controller = SuggestionController();
    controller.refresh(5);
    final list = controller.items;
    expect(controller.itemCount, 5);
    expect(list.contains(1), true);
    expect(list.contains(2), true);
    expect(list.contains(3), true);
    expect(list.contains(4), true);
    expect(list.contains(5), true);
  });

  test('creation of item models', () {
    final controller = SuggestionController(initialItems: [3, 5, 1, 2, 4]);

    var itemModel = controller.createModelOfItemAt(0);
    expect(itemModel.nth.toString(), '3rd');
    expect(itemModel.nthFromEnd.toString(), '3rd');
    expect(itemModel.steps, null);
    expect(itemModel.stepsCrossingSides, null);

    itemModel = controller.createModelOfItemAt(1);
    expect(itemModel.nth.toString(), '5th');
    expect(itemModel.nthFromEnd.toString(), '1st');
    expect(itemModel.steps.toString(), '2 steps forward');
    expect(itemModel.stepsCrossingSides, null);

    itemModel = controller.createModelOfItemAt(2);
    expect(itemModel.nth.toString(), '1st');
    expect(itemModel.nthFromEnd.toString(), '5th');
    expect(itemModel.steps.toString(), '4 steps backward');
    expect(itemModel.stepsCrossingSides.toString(), '1 step forward');

    itemModel = controller.createModelOfItemAt(3);
    expect(itemModel.nth.toString(), '2nd');
    expect(itemModel.nthFromEnd.toString(), '4th');
    expect(itemModel.steps.toString(), '1 step forward');
    expect(itemModel.stepsCrossingSides, null);

    itemModel = controller.createModelOfItemAt(4);
    expect(itemModel.nth.toString(), '4th');
    expect(itemModel.nthFromEnd.toString(), '2nd');
    expect(itemModel.steps.toString(), '2 steps forward');
    expect(itemModel.stepsCrossingSides, null);
  });
}
