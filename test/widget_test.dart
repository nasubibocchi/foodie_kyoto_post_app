import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_model.dart';
import 'package:foodie_kyoto_post_app/ui/pages/google_map_page/google_map_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testing Google Map View', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        googleMapProvider.overrideWithProvider(
            StateNotifierProvider<GoogleMapPageController, GoogleMapState>(
                (ref) => GoogleMapPageController())),
      ],
      child: MaterialApp(
          title: 'Foodie kyoto post app',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const FakeGoogleMapPage()),
    ));

    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  // testGoldens('app', (WidgetTester tester) async {
  //   final container = ProviderContainer(overrides: [
  //     googleMapProvider.overrideWithProvider(
  //         StateNotifierProvider<GoogleMapPageController, GoogleMapState>(
  //             (ref) => GoogleMapPageController())),
  //     // googleMapProvider.overrideWithValue(GoogleMapPageController()),
  //   ]);
  //
  //   final model = container.read(googleMapProvider);
  //   const size = Size(2400, 1800);
  //
  //   model.when((googleMapController) async {
  //     await tester.pumpWidgetBuilder(const ProviderScope(child: MyApp()),
  //         surfaceSize: size);
  //
  //     // //マスターのスクリーンショットと同じかテストする
  //     // await screenMatchesGolden(tester, 'myApp');
  //   }, creating: () async {});
  //   await screenMatchesGolden(tester, 'myApp');
  // });
}

class FakeGoogleMapPage extends StatelessWidget {
  const FakeGoogleMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('mock')),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 64),
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
