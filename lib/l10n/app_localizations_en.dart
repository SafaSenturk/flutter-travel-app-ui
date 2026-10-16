// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'GlobeGo';

  @override
  String get onb1Title => 'Find Hidden\nGems';

  @override
  String get onb1Sub => 'Hand-picked places beyond the guidebooks';

  @override
  String get onb2Title => 'Chase Every\nSunrise';

  @override
  String get onb2Sub => 'Plan unforgettable moments in minutes';

  @override
  String get onb3Title => 'Journeys\nMade Simple';

  @override
  String get onb3Sub => 'Travel smarter with GlobeGo';

  @override
  String get continueLabel => 'Continue';

  @override
  String get slide => 'Slide';

  @override
  String greeting(String name) {
    return 'Hi, $name';
  }

  @override
  String get regionAsia => 'Asia';

  @override
  String get regionEurope => 'Europe';

  @override
  String get regionAmerica => 'America';

  @override
  String get all => 'All';

  @override
  String get navHome => 'Home';

  @override
  String get navDiscover => 'Discover';

  @override
  String get navBooking => 'Booking';

  @override
  String get navProfile => 'Profile';

  @override
  String get perNight => '/night';

  @override
  String get extraTicket => 'Ticket';

  @override
  String get extraHotel => 'Hotel';

  @override
  String get extraMeal => 'Meal';

  @override
  String get extraTicketLong => 'City tour ticket';

  @override
  String get extraHotelLong => 'Room upgrade';

  @override
  String get extraMealLong => 'Half board';

  @override
  String get extraTicketHint => '\$49 per guest';

  @override
  String get extraHotelHint => '\$60 per night';

  @override
  String get extraMealHint => '\$35 per guest per night';

  @override
  String get scheduleOverview => 'Schedule Overview';

  @override
  String get readMore => 'Read more';

  @override
  String get readLess => 'Show less';

  @override
  String get message => 'Message';

  @override
  String get bookNow => 'Book Now';

  @override
  String reviews(int count) {
    return '$count reviews';
  }

  @override
  String get searchHint => 'Search destinations or countries';

  @override
  String noResults(String query) {
    return 'No destination matches \"$query\"';
  }

  @override
  String get notifications => 'Notifications';

  @override
  String get notif1Title => 'Lake Como is 15% off';

  @override
  String get notif1Body => 'Book before Sunday to get the autumn price.';

  @override
  String get notif2Title => 'Balloon season in Cappadocia';

  @override
  String get notif2Body => 'Sunrise flights run from April to November.';

  @override
  String get notif3Title => 'Welcome to GlobeGo';

  @override
  String get notif3Body =>
      'Save places with the heart and find them in Discover.';

  @override
  String get discoverTitle => 'Discover the world';

  @override
  String get favorites => 'Favorites';

  @override
  String get favoritesOnly => 'Favorites only';

  @override
  String get noFavorites => 'Tap the heart on a destination to save it here.';

  @override
  String get bookingsTitle => 'My trips';

  @override
  String get bookingsEmpty => 'No trips yet';

  @override
  String get bookingsEmptyBody =>
      'Find a place you love and book it in a few taps.';

  @override
  String get explore => 'Explore destinations';

  @override
  String get checkIn => 'Check-in';

  @override
  String nights(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nights',
      one: '1 night',
    );
    return '$_temp0';
  }

  @override
  String guests(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count guests',
      one: '1 guest',
    );
    return '$_temp0';
  }

  @override
  String get stay => 'Stay';

  @override
  String get travellers => 'Travellers';

  @override
  String get extras => 'Extras';

  @override
  String get total => 'Total';

  @override
  String get confirmBooking => 'Confirm booking';

  @override
  String get bookedTitle => 'You\'re all set!';

  @override
  String bookedBody(String place) {
    return 'Your trip to $place is saved in My trips.';
  }

  @override
  String get viewTrips => 'View my trips';

  @override
  String get done => 'Done';

  @override
  String get cancelTrip => 'Cancel trip';

  @override
  String cancelTripQuestion(String place) {
    return 'Cancel your trip to $place?';
  }

  @override
  String get keepTrip => 'Keep it';

  @override
  String get tripCancelled => 'Trip cancelled';

  @override
  String get chatTitle => 'Chat with your host';

  @override
  String get chatHost => 'Host · replies in minutes';

  @override
  String chatHello(String place) {
    return 'Hi! I\'m Giulia, your host in $place. How can I help?';
  }

  @override
  String get q1 => 'Is breakfast included?';

  @override
  String get a1 =>
      'Breakfast is served on the terrace from 7 to 10. Add \"Meal\" for half board.';

  @override
  String get q2 => 'Can I check in early?';

  @override
  String get a2 =>
      'Sure — if the room is ready you can check in from 11:00 at no extra cost.';

  @override
  String get q3 => 'Do you offer airport transfer?';

  @override
  String get a3 =>
      'Yes, a private transfer is €45 per car. Just send me your flight number.';

  @override
  String get typeMessage => 'Write a message…';

  @override
  String get autoReply => 'Thanks! I\'ll get back to you shortly.';

  @override
  String get share => 'Share';

  @override
  String get linkCopied => 'Link copied to clipboard';

  @override
  String get addFavorite => 'Add to favorites';

  @override
  String get removeFavorite => 'Remove from favorites';

  @override
  String get profileTitle => 'Profile';

  @override
  String get trips => 'Trips';

  @override
  String get countries => 'Countries';

  @override
  String get editName => 'Edit name';

  @override
  String get name => 'Name';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get language => 'Language';

  @override
  String get replayIntro => 'Show the intro again';

  @override
  String get about => 'About this app';

  @override
  String get aboutBody =>
      'A pixel-perfect Flutter recreation of the \"Travel Booking App\" shot by Koushik Sarkar on Dribbble, turned into a working app. Photos from Unsplash.';

  @override
  String get designBy => 'UI design by Koushik Sarkar';

  @override
  String get menu => 'Menu';

  @override
  String get explorer => 'Explorer';

  @override
  String daysToGo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days to go',
      one: '1 day to go',
    );
    return '$_temp0';
  }

  @override
  String get today => 'Today';
}
