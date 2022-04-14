import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/main.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_model.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_provider.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  final addButton = find.byKey(const Key('Add-a-shop'));

  TestWidgetsFlutterBinding.ensureInitialized();

  testGoldens('app', (WidgetTester tester) async {
    final container = ProviderContainer(overrides: [
      googleMapProvider.overrideWithProvider(
          StateNotifierProvider<GoogleMapPageController, GoogleMapState>(
              (ref) => GoogleMapPageController())),
      // googleMapProvider.overrideWithValue(GoogleMapPageController()),
    ]);

    final model = container.read(googleMapProvider);

    model.when((googleMapController) async {
      const size = Size(415, 896);

      await tester.pumpWidgetBuilder(const ProviderScope(child: MyApp()),
          surfaceSize: size);

      //マスターのスクリーンショットと同じかテストする
      await screenMatchesGolden(tester, 'myApp');
    }, creating: () {});
  }, skip: true);

  testWidgets('Testing Google Map View', (WidgetTester tester) async {
    final container = ProviderContainer(overrides: [
      googleMapProvider.overrideWithProvider(
          StateNotifierProvider<GoogleMapPageController, GoogleMapState>(
              (ref) => GoogleMapPageController())),
      // googleMapProvider.overrideWithValue(GoogleMapPageController()),
    ]);

    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    final model = container.read(googleMapProvider);

    model.when((googleMapController) async {
      expect(addButton, findsOneWidget);
      expect(find.text('1'), findsNothing);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(addButton, findsOneWidget);
      expect(find.text('1'), findsNothing);
    }, creating: () {
      expect(addButton, findsNothing);
    });
  }, skip: true);
}
