import 'package:catalog_chooser/controllers/suggestion_notifier.dart';
import 'package:catalog_chooser/widgets/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('PageView has correct number of pages', (tester) async {
    final pageController = PageController();
    final suggestionNotifier = SuggestionNotifier();

    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => pageController),
            StateNotifierProvider<SuggestionNotifier, SuggestionState>(
              create: (_) => suggestionNotifier,
            ),
          ],
          child: const Suggestion(),
        ),
      ),
    );

    pageController.jumpToPage(20);
    expect(pageController.page, 9.0);

    suggestionNotifier.refresh(21);
    await tester.pump();

    pageController.jumpToPage(20);
    expect(pageController.page, 20.0);
  });
}
