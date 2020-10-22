import 'package:catalog_chooser/controllers/suggestion_notifier.dart';
import 'package:catalog_chooser/widgets/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final refreshValueProvider = StateProvider((ref) => 10);

class RefreshDialog extends ConsumerWidget {
  RefreshDialog({Key key}) : super(key: key);
  
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final suggestion = watch(suggestionNotifierProvider.state);

    return AlertDialog(
      title: const Text('How many items? (2-100)'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          key: Key('refresh_dialog_text_field'),
          initialValue: '${suggestion.nthList.length}',
          keyboardType: TextInputType.numberWithOptions(
            signed: false,
            decimal: false,
          ),
          autofocus: true,
          validator: _validator,
          onSaved: (value) {
            context.read(refreshValueProvider).state = int.parse(value);
          },
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
      _formKey.currentState.save();
      context.read(suggestionControllerProvider).refresh(
        context.read(refreshValueProvider).state,
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