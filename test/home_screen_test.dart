import 'package:catalog_chooser/controllers/suggestion_controller.dart';
import 'package:catalog_chooser/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('refresh the state', (tester) async {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PageController()),
          ChangeNotifierProvider(create: (_) => SuggestionController()),
        ],
        child: Provider<HomeModel>(
          create: (context) => HomeModel(context.read),
          child: MaterialApp(
            home: Scaffold(
              key: scaffoldKey,
              body: const HomeScreen(),
            ),
          ),
        ),
      ),
    );

    expect(find.text('1 of 10'), findsOneWidget);

    scaffoldKey.currentContext.read<HomeModel>().refresh(12);
    await tester.pump();

    expect(find.text('1 of 12'), findsOneWidget);
  });
}
