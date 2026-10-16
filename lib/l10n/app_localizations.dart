import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'GlobeGo'**
  String get appName;

  /// No description provided for @onb1Title.
  ///
  /// In en, this message translates to:
  /// **'Find Hidden\nGems'**
  String get onb1Title;

  /// No description provided for @onb1Sub.
  ///
  /// In en, this message translates to:
  /// **'Hand-picked places beyond the guidebooks'**
  String get onb1Sub;

  /// No description provided for @onb2Title.
  ///
  /// In en, this message translates to:
  /// **'Chase Every\nSunrise'**
  String get onb2Title;

  /// No description provided for @onb2Sub.
  ///
  /// In en, this message translates to:
  /// **'Plan unforgettable moments in minutes'**
  String get onb2Sub;

  /// No description provided for @onb3Title.
  ///
  /// In en, this message translates to:
  /// **'Journeys\nMade Simple'**
  String get onb3Title;

  /// No description provided for @onb3Sub.
  ///
  /// In en, this message translates to:
  /// **'Travel smarter with GlobeGo'**
  String get onb3Sub;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @slide.
  ///
  /// In en, this message translates to:
  /// **'Slide'**
  String get slide;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name}'**
  String greeting(String name);

  /// No description provided for @regionAsia.
  ///
  /// In en, this message translates to:
  /// **'Asia'**
  String get regionAsia;

  /// No description provided for @regionEurope.
  ///
  /// In en, this message translates to:
  /// **'Europe'**
  String get regionEurope;

  /// No description provided for @regionAmerica.
  ///
  /// In en, this message translates to:
  /// **'America'**
  String get regionAmerica;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get navDiscover;

  /// No description provided for @navBooking.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get navBooking;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @perNight.
  ///
  /// In en, this message translates to:
  /// **'/night'**
  String get perNight;

  /// No description provided for @extraTicket.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get extraTicket;

  /// No description provided for @extraHotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get extraHotel;

  /// No description provided for @extraMeal.
  ///
  /// In en, this message translates to:
  /// **'Meal'**
  String get extraMeal;

  /// No description provided for @extraTicketLong.
  ///
  /// In en, this message translates to:
  /// **'City tour ticket'**
  String get extraTicketLong;

  /// No description provided for @extraHotelLong.
  ///
  /// In en, this message translates to:
  /// **'Room upgrade'**
  String get extraHotelLong;

  /// No description provided for @extraMealLong.
  ///
  /// In en, this message translates to:
  /// **'Half board'**
  String get extraMealLong;

  /// No description provided for @extraTicketHint.
  ///
  /// In en, this message translates to:
  /// **'\$49 per guest'**
  String get extraTicketHint;

  /// No description provided for @extraHotelHint.
  ///
  /// In en, this message translates to:
  /// **'\$60 per night'**
  String get extraHotelHint;

  /// No description provided for @extraMealHint.
  ///
  /// In en, this message translates to:
  /// **'\$35 per guest per night'**
  String get extraMealHint;

  /// No description provided for @scheduleOverview.
  ///
  /// In en, this message translates to:
  /// **'Schedule Overview'**
  String get scheduleOverview;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get readMore;

  /// No description provided for @readLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get readLess;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'{count} reviews'**
  String reviews(int count);

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search destinations or countries'**
  String get searchHint;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No destination matches \"{query}\"'**
  String noResults(String query);

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notif1Title.
  ///
  /// In en, this message translates to:
  /// **'Lake Como is 15% off'**
  String get notif1Title;

  /// No description provided for @notif1Body.
  ///
  /// In en, this message translates to:
  /// **'Book before Sunday to get the autumn price.'**
  String get notif1Body;

  /// No description provided for @notif2Title.
  ///
  /// In en, this message translates to:
  /// **'Balloon season in Cappadocia'**
  String get notif2Title;

  /// No description provided for @notif2Body.
  ///
  /// In en, this message translates to:
  /// **'Sunrise flights run from April to November.'**
  String get notif2Body;

  /// No description provided for @notif3Title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to GlobeGo'**
  String get notif3Title;

  /// No description provided for @notif3Body.
  ///
  /// In en, this message translates to:
  /// **'Save places with the heart and find them in Discover.'**
  String get notif3Body;

  /// No description provided for @discoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover the world'**
  String get discoverTitle;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @favoritesOnly.
  ///
  /// In en, this message translates to:
  /// **'Favorites only'**
  String get favoritesOnly;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart on a destination to save it here.'**
  String get noFavorites;

  /// No description provided for @bookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'My trips'**
  String get bookingsTitle;

  /// No description provided for @bookingsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No trips yet'**
  String get bookingsEmpty;

  /// No description provided for @bookingsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Find a place you love and book it in a few taps.'**
  String get bookingsEmptyBody;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore destinations'**
  String get explore;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get checkIn;

  /// No description provided for @nights.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 night} other{{count} nights}}'**
  String nights(int count);

  /// No description provided for @guests.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 guest} other{{count} guests}}'**
  String guests(int count);

  /// No description provided for @stay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get stay;

  /// No description provided for @travellers.
  ///
  /// In en, this message translates to:
  /// **'Travellers'**
  String get travellers;

  /// No description provided for @extras.
  ///
  /// In en, this message translates to:
  /// **'Extras'**
  String get extras;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm booking'**
  String get confirmBooking;

  /// No description provided for @bookedTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re all set!'**
  String get bookedTitle;

  /// No description provided for @bookedBody.
  ///
  /// In en, this message translates to:
  /// **'Your trip to {place} is saved in My trips.'**
  String bookedBody(String place);

  /// No description provided for @viewTrips.
  ///
  /// In en, this message translates to:
  /// **'View my trips'**
  String get viewTrips;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @cancelTrip.
  ///
  /// In en, this message translates to:
  /// **'Cancel trip'**
  String get cancelTrip;

  /// No description provided for @cancelTripQuestion.
  ///
  /// In en, this message translates to:
  /// **'Cancel your trip to {place}?'**
  String cancelTripQuestion(String place);

  /// No description provided for @keepTrip.
  ///
  /// In en, this message translates to:
  /// **'Keep it'**
  String get keepTrip;

  /// No description provided for @tripCancelled.
  ///
  /// In en, this message translates to:
  /// **'Trip cancelled'**
  String get tripCancelled;

  /// No description provided for @chatTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat with your host'**
  String get chatTitle;

  /// No description provided for @chatHost.
  ///
  /// In en, this message translates to:
  /// **'Host · replies in minutes'**
  String get chatHost;

  /// No description provided for @chatHello.
  ///
  /// In en, this message translates to:
  /// **'Hi! I\'m Giulia, your host in {place}. How can I help?'**
  String chatHello(String place);

  /// No description provided for @q1.
  ///
  /// In en, this message translates to:
  /// **'Is breakfast included?'**
  String get q1;

  /// No description provided for @a1.
  ///
  /// In en, this message translates to:
  /// **'Breakfast is served on the terrace from 7 to 10. Add \"Meal\" for half board.'**
  String get a1;

  /// No description provided for @q2.
  ///
  /// In en, this message translates to:
  /// **'Can I check in early?'**
  String get q2;

  /// No description provided for @a2.
  ///
  /// In en, this message translates to:
  /// **'Sure — if the room is ready you can check in from 11:00 at no extra cost.'**
  String get a2;

  /// No description provided for @q3.
  ///
  /// In en, this message translates to:
  /// **'Do you offer airport transfer?'**
  String get q3;

  /// No description provided for @a3.
  ///
  /// In en, this message translates to:
  /// **'Yes, a private transfer is €45 per car. Just send me your flight number.'**
  String get a3;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Write a message…'**
  String get typeMessage;

  /// No description provided for @autoReply.
  ///
  /// In en, this message translates to:
  /// **'Thanks! I\'ll get back to you shortly.'**
  String get autoReply;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @linkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied to clipboard'**
  String get linkCopied;

  /// No description provided for @addFavorite.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get addFavorite;

  /// No description provided for @removeFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get removeFavorite;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get trips;

  /// No description provided for @countries.
  ///
  /// In en, this message translates to:
  /// **'Countries'**
  String get countries;

  /// No description provided for @editName.
  ///
  /// In en, this message translates to:
  /// **'Edit name'**
  String get editName;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @replayIntro.
  ///
  /// In en, this message translates to:
  /// **'Show the intro again'**
  String get replayIntro;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About this app'**
  String get about;

  /// No description provided for @aboutBody.
  ///
  /// In en, this message translates to:
  /// **'A pixel-perfect Flutter recreation of the \"Travel Booking App\" shot by Koushik Sarkar on Dribbble, turned into a working app. Photos from Unsplash.'**
  String get aboutBody;

  /// No description provided for @designBy.
  ///
  /// In en, this message translates to:
  /// **'UI design by Koushik Sarkar'**
  String get designBy;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @explorer.
  ///
  /// In en, this message translates to:
  /// **'Explorer'**
  String get explorer;

  /// No description provided for @daysToGo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day to go} other{{count} days to go}}'**
  String daysToGo(int count);

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
