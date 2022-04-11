import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/main.dart';

void main() {
  testWidgets('MyHomePage has a text FlutterAT', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('FlutterAT'), findsNothing);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsNothing);
  });
}
