import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/destinations.dart';

/// Overridden in `main()` with the loaded instance.
final prefsProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError('prefsProvider'));

// ---------------------------------------------------------------- settings

class LocaleNotifier extends Notifier<Locale?> {
  static const _key = 'locale';

  @override
  Locale? build() {
    final code = ref.read(prefsProvider).getString(_key);
    return code == null ? null : Locale(code);
  }

  void set(Locale locale) {
    state = locale;
    ref.read(prefsProvider).setString(_key, locale.languageCode);
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(LocaleNotifier.new);

class OnboardingNotifier extends Notifier<bool> {
  static const _key = 'onboarded';

  @override
  bool build() => ref.read(prefsProvider).getBool(_key) ?? false;

  void complete() {
    state = true;
    ref.read(prefsProvider).setBool(_key, true);
  }

  void reset() {
    state = false;
    ref.read(prefsProvider).setBool(_key, false);
  }
}

final onboardedProvider = NotifierProvider<OnboardingNotifier, bool>(OnboardingNotifier.new);

class NameNotifier extends Notifier<String> {
  static const _key = 'name';

  @override
  String build() => ref.read(prefsProvider).getString(_key) ?? 'Christopher';

  void set(String name) {
    final clean = name.trim();
    if (clean.isEmpty) return;
    state = clean;
    ref.read(prefsProvider).setString(_key, clean);
  }
}

final nameProvider = NotifierProvider<NameNotifier, String>(NameNotifier.new);

// ---------------------------------------------------------------- browsing

class TabNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void go(int index) => state = index;
}

final tabProvider = NotifierProvider<TabNotifier, int>(TabNotifier.new);

/// Region filter on the home screen; `null` shows every destination.
class RegionNotifier extends Notifier<Region?> {
  @override
  Region? build() => null;

  void toggle(Region region) => state = state == region ? null : region;
}

final regionProvider = NotifierProvider<RegionNotifier, Region?>(RegionNotifier.new);

final homeDestinationsProvider = Provider<List<Destination>>((ref) {
  final region = ref.watch(regionProvider);
  return region == null ? destinations : destinations.where((d) => d.region == region).toList();
});

class FavoritesNotifier extends Notifier<Set<String>> {
  static const _key = 'favorites';

  @override
  Set<String> build() => (ref.read(prefsProvider).getStringList(_key) ?? const ['lake_como']).toSet();

  void toggle(String id) {
    state = state.contains(id) ? ({...state}..remove(id)) : {...state, id};
    ref.read(prefsProvider).setStringList(_key, state.toList());
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(FavoritesNotifier.new);

// ---------------------------------------------------------------- bookings

class Booking {
  const Booking({
    required this.id,
    required this.destinationId,
    required this.checkIn,
    required this.nights,
    required this.guests,
    required this.extras,
    required this.total,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json['id'] as String,
        destinationId: json['destinationId'] as String,
        checkIn: DateTime.parse(json['checkIn'] as String),
        nights: json['nights'] as int,
        guests: json['guests'] as int,
        extras: (json['extras'] as List<dynamic>).map((e) => Extra.values.byName(e as String)).toSet(),
        total: json['total'] as int,
      );

  final String id;
  final String destinationId;
  final DateTime checkIn;
  final int nights;
  final int guests;
  final Set<Extra> extras;
  final int total;

  Destination get destination => destinationById(destinationId);
  DateTime get checkOut => checkIn.add(Duration(days: nights));

  Map<String, dynamic> toJson() => {
        'id': id,
        'destinationId': destinationId,
        'checkIn': checkIn.toIso8601String(),
        'nights': nights,
        'guests': guests,
        'extras': extras.map((e) => e.name).toList(),
        'total': total,
      };
}

class BookingsNotifier extends Notifier<List<Booking>> {
  static const _key = 'bookings';

  @override
  List<Booking> build() {
    final raw = ref.read(prefsProvider).getString(_key);
    if (raw == null) return const [];
    return (jsonDecode(raw) as List<dynamic>).map((e) => Booking.fromJson(e as Map<String, dynamic>)).toList();
  }

  Booking add({
    required Destination destination,
    required DateTime checkIn,
    required int nights,
    required int guests,
    required Set<Extra> extras,
  }) {
    final booking = Booking(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      destinationId: destination.id,
      checkIn: checkIn,
      nights: nights,
      guests: guests,
      extras: extras,
      total: bookingTotal(destination, nights: nights, guests: guests, extras: extras),
    );
    state = [...state, booking]..sort((a, b) => a.checkIn.compareTo(b.checkIn));
    _save();
    return booking;
  }

  void cancel(String id) {
    state = state.where((b) => b.id != id).toList();
    _save();
  }

  void _save() => ref.read(prefsProvider).setString(_key, jsonEncode(state.map((b) => b.toJson()).toList()));
}

final bookingsProvider = NotifierProvider<BookingsNotifier, List<Booking>>(BookingsNotifier.new);
