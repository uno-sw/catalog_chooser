import 'package:catalog_chooser/screens/home_screen.dart';
import 'package:catalog_chooser/widgets/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefreshDialog extends StatelessWidget {
  RefreshDialog({Key key}) : super(key: key);
  
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('How many items? (2-100)'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          key: Key('refresh_dialog_text_field'),
          controller: context.watch(),
          keyboardType: TextInputType.numberWithOptions(
            signed: false,
            decimal: false,
          ),
          autofocus: true,
          validator: _validator,
        ),
      ),
      actions: [
        FlatButton(
          child: const Text('CANCEL'),
          textTheme: ButtonTextTheme.normal,
          onPressed: Navigator.of(context).pop,
        ),
        FlatButton(
          child: const Text('OK'),
          onPressed: () => _save(context),
        ),
      ],
    );
  }

  void _save(BuildContext context) {
    if (_formKey.currentState.validate()) {
      context.read<SuggestionController>().refresh(
        int.parse(context.read<TextEditingController>().text),
      );
      Navigator.pop(context);
    }
  }

  static String _validator(String value) {
    final intValue = int.tryParse(value);
    return (intValue == null || intValue <= 1 || intValue >= 101)
        ? 'Must be an integer in the range of 2-100'
        : null;
  }
}