import 'package:catalog_chooser/app.dart';
import 'package:catalog_chooser/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('refreshes the state', (tester) async {
    final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          scaffoldMessengerKeyProvider.overrideWithValue(scaffoldMessengerKey),
        ],
        child: MaterialApp(
          scaffoldMessengerKey: scaffoldMessengerKey,
          home: const HomeScreen(),
        ),
      ),
    );

    expect(find.text('1 of 10'), findsOneWidget);
    expect(find.text('1 of 21'), findsNothing);

    final refreshFAB = find.byIcon(Icons.refresh);
    final refreshDialogTextField = find.byKey(Key('refresh_dialog_text_field'));
    final refreshDialogOKButton = find.text('OK');

    expect(refreshFAB, findsOneWidget);
    await tester.tap(refreshFAB);
    await tester.pump();

    expect(refreshDialogTextField, findsOneWidget);
    expect(refreshDialogOKButton, findsOneWidget);
    await tester.enterText(refreshDialogTextField, '21');
    await tester.pump();
    await tester.tap(refreshDialogOKButton);
    await tester.pump();

    expect(find.text('1 of 10'), findsNothing);
    expect(find.text('1 of 21'), findsOneWidget);
    expect(find.text('Refreshed with 21 items.'), findsOneWidget);
  });
}