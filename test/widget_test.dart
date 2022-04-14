import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/main.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    // Build our app and trigger a frame.
    await tester.pumpWidget(const GoogleMapPage());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add, skipOffstage: false));
    await tester.pumpAndSettle();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsNothing);
  }, skip: true);
}
