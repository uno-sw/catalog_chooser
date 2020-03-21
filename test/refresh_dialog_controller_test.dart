import 'package:catalog_chooser/widgets/refresh_dialog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('accepts only a text which can be parsed to int greater than 1', () {
    expect(RefreshDialogController.validate(''), isNotNull);
    expect(RefreshDialogController.validate('test123'), isNotNull);
    expect(RefreshDialogController.validate('3.14'), isNotNull);
    expect(RefreshDialogController.validate('0'), isNotNull);
    expect(RefreshDialogController.validate('1'), isNotNull);
    expect(RefreshDialogController.validate('-29'), isNotNull);
    expect(RefreshDialogController.validate('101'), isNotNull);
    expect(RefreshDialogController.validate('2'), null);
    expect(RefreshDialogController.validate('100'), null);
  });
}
