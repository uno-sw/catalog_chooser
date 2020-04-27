import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefreshDialog extends StatelessWidget {
  const RefreshDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RefreshDialogController>();
    final value = context.select(
      (RefreshDialogController controller) => controller.value,
    );

    return AlertDialog(
      title: const Text('How many items? (2-100)'),
      content: Form(
        key: context.watch<GlobalKey<FormState>>(),
        child: TextFormField(
          controller: context.watch(),
          keyboardType: TextInputType.numberWithOptions(
            signed: false,
            decimal: false,
          ),
          autofocus: true,
          validator: RefreshDialogController.validate,
        ),
      ),
      actions: [
        FlatButton(
          child: const Text('CANCEL'),
          textTheme: ButtonTextTheme.normal,
          onPressed: controller.cancel,
        ),
        FlatButton(
          child: const Text('OK'),
          onPressed: controller.save,
        ),
      ],
    );
  }
}

class RefreshDialogController with ChangeNotifier {
  RefreshDialogController({
    @required this.locator,
  }) : assert(locator != null);

  final Locator locator;

  TextEditingController get _textEditingController => locator();
  GlobalKey<FormState> get _formKey => locator();
  GlobalKey<NavigatorState> get _navigatorKey => locator();

  double _value = 10;

  double get value => _value;

  void setValue(double value) {
    _value = value;
    notifyListeners();
  }

  void cancel() => _navigatorKey.currentState.pop<int>();

  void save() {
    if (_formKey.currentState.validate()) {
      _navigatorKey.currentState.pop<int>(
        int.parse(_textEditingController.text),
      );
    }
  }

  static String validate(String value) {
    final intValue = int.tryParse(value);
    return (intValue == null || intValue <= 1 || intValue >= 101)
        ? 'Must be an integer in the range of 2-100'
        : null;
  }
}
