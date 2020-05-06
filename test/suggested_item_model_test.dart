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
}