import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:globego/main.dart';
import 'package:globego/state/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> pumpApp(WidgetTester tester, Map<String, Object> prefsValues) async {
  // The design frame: 393 × 852 pt.
  tester.view.physicalSize = const Size(1179, 2556);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  SharedPreferences.setMockInitialValues(prefsValues);
  final prefs = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    ProviderScope(overrides: [prefsProvider.overrideWithValue(prefs)], child: const GlobeGoApp()),
  );
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  testWidgets('first launch shows the intro and the Continue button walks through it', (tester) async {
    await pumpApp(tester, {'locale': 'en'});
    expect(find.text('GlobeGo'), findsOneWidget);
    expect(find.text('Find Hidden\nGems'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Chase Every\nSunrise'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Journeys\nMade Simple'), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Hi, Christopher'), findsOneWidget);
  });

  testWidgets('region chips filter the home list', (tester) async {
    await pumpApp(tester, {'onboarded': true, 'locale': 'en'});
    expect(find.text('Manarola'), findsOneWidget);

    await tester.tap(find.text('Asia'));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Manarola'), findsNothing);
    expect(find.text('Kyoto'), findsOneWidget);
  });

  testWidgets('the interface switches to Turkish', (tester) async {
    await pumpApp(tester, {'onboarded': true, 'locale': 'tr'});
    expect(find.text('Merhaba, Christopher'), findsOneWidget);
    expect(find.text('Keşfet'), findsOneWidget);
    expect(find.text('Asya'), findsOneWidget);
  });
}
