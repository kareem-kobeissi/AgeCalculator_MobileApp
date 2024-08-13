import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_age_calculator/main.dart';

void main() {
  testWidgets('Age Calculator initial state test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MyHomePage(),
    ));

    // Verify that the app initially prompts the user to select a year.
    expect(find.text('Select your year of birth'), findsOneWidget);
    expect(find.text('Your Age is 0'), findsNothing);

    // Tap the year selection button and trigger a frame.
    await tester.tap(find.text('Select your year of birth'));
    await tester.pumpAndSettle();

    // Since there's no way to interact with the date picker directly in this test,
    // we can't select a specific date, but we can still verify that the initial state is correct.
  });
}
