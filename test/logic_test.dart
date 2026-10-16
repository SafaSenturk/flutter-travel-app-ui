import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:globego/core/widgets.dart';
import 'package:globego/data/destinations.dart';
import 'package:globego/features/search/search_screen.dart';
import 'package:globego/state/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> makeContainer([Map<String, Object> values = const {}]) async {
  SharedPreferences.setMockInitialValues(values);
  final prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(overrides: [prefsProvider.overrideWithValue(prefs)]);
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('pricing', () {
    final como = destinationById('lake_como');

    test('a plain stay is price × nights', () {
      expect(bookingTotal(como, nights: 3, guests: 2, extras: {}), 899 * 3);
    });

    test('extras are priced per guest, per night or both', () {
      expect(extraPrice(Extra.ticket, nights: 3, guests: 2), 98);
      expect(extraPrice(Extra.hotel, nights: 3, guests: 2), 180);
      expect(extraPrice(Extra.meal, nights: 3, guests: 2), 210);
      expect(
        bookingTotal(como, nights: 3, guests: 2, extras: Extra.values.toSet()),
        899 * 3 + 98 + 180 + 210,
      );
    });

    test('money() groups thousands', () {
      expect(money(899), r'$899');
      expect(money(2228), r'$2,228');
      expect(money(1250000), r'$1,250,000');
    });
  });

  group('data', () {
    test('every destination has a unique id and both languages', () {
      final ids = destinations.map((d) => d.id).toSet();
      expect(ids.length, destinations.length);
      for (final d in destinations) {
        expect(d.name.en, isNotEmpty);
        expect(d.about.tr, isNotEmpty);
        expect(d.about.tr, isNot(d.about.en));
      }
    });

    test('every region has destinations', () {
      for (final r in Region.values) {
        expect(destinations.where((d) => d.region == r), isNotEmpty);
      }
    });
  });

  group('search', () {
    test('matches names and countries in English and Turkish', () {
      expect(searchDestinations('como').map((d) => d.id), ['lake_como']);
      expect(searchDestinations('Kapadokya').map((d) => d.id), ['cappadocia']);
      expect(searchDestinations('italy').map((d) => d.id), containsAll(['manarola', 'lake_como', 'venice']));
      expect(searchDestinations('İtalya').length, 3);
    });

    test('empty query returns everything, unknown returns nothing', () {
      expect(searchDestinations('  ').length, destinations.length);
      expect(searchDestinations('atlantis'), isEmpty);
    });
  });

  group('state', () {
    test('region filter toggles on and off', () async {
      final c = await makeContainer();
      expect(c.read(homeDestinationsProvider).length, destinations.length);
      c.read(regionProvider.notifier).toggle(Region.asia);
      expect(c.read(homeDestinationsProvider).every((d) => d.region == Region.asia), isTrue);
      c.read(regionProvider.notifier).toggle(Region.asia);
      expect(c.read(regionProvider), isNull);
    });

    test('favourites are toggled and saved', () async {
      final c = await makeContainer({'favorites': <String>[]});
      c.read(favoritesProvider.notifier).toggle('kyoto');
      expect(c.read(favoritesProvider), {'kyoto'});
      final prefs = c.read(prefsProvider);
      expect(prefs.getStringList('favorites'), ['kyoto']);
      c.read(favoritesProvider.notifier).toggle('kyoto');
      expect(c.read(favoritesProvider), isEmpty);
    });

    test('bookings are sorted by date, saved and can be cancelled', () async {
      final c = await makeContainer();
      final n = c.read(bookingsProvider.notifier);
      final late = n.add(
        destination: destinationById('bali'),
        checkIn: DateTime(2026, 12, 20),
        nights: 2,
        guests: 1,
        extras: {Extra.meal},
      );
      n.add(destination: destinationById('kyoto'), checkIn: DateTime(2026, 11, 2), nights: 4, guests: 2, extras: {});
      expect(c.read(bookingsProvider).map((b) => b.destinationId), ['kyoto', 'bali']);
      expect(late.total, 420 * 2 + 35 * 2);

      // A fresh container reads the same trips back from storage.
      final saved = c.read(prefsProvider).getString('bookings')!;
      final c2 = await makeContainer({'bookings': saved});
      final restored = c2.read(bookingsProvider);
      expect(restored.map((b) => b.destinationId), ['kyoto', 'bali']);
      expect(restored.last.extras, {Extra.meal});
      expect(restored.last.checkOut, DateTime(2026, 12, 22));

      n.cancel(late.id);
      expect(c.read(bookingsProvider).map((b) => b.destinationId), ['kyoto']);
    });

    test('name ignores blank input', () async {
      final c = await makeContainer();
      expect(c.read(nameProvider), 'Christopher');
      c.read(nameProvider.notifier).set('   ');
      expect(c.read(nameProvider), 'Christopher');
      c.read(nameProvider.notifier).set(' Safa ');
      expect(c.read(nameProvider), 'Safa');
    });
  });
}
