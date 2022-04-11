import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:foodie_kyoto_post_app/main.dart';

void main() {
  testWidgets('Find title text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that our counter starts at 0.
    expect(find.text('Flutter Demo Home Page'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Flutter Demo Home Page'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });
}
