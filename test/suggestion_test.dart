import 'package:catalog_chooser/controllers/suggestion_controller.dart';
import 'package:catalog_chooser/widgets/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('PageView has correct number of pages', (tester) async {
    final pageController = PageController();
    final suggestionController = SuggestionController();

    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => pageController),
            ChangeNotifierProvider(create: (_) => suggestionController),
          ],
          child: const Suggestion(),
        ),
      ),
    );

    pageController.jumpToPage(20);
    expect(pageController.page, 9.0);

    suggestionController.refresh(21);
    await tester.pump();

    pageController.jumpToPage(20);
    expect(pageController.page, 20.0);
  });
}
