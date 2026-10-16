// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'GlobeGo';

  @override
  String get onb1Title => 'Saklı Köşeleri\nKeşfet';

  @override
  String get onb1Sub => 'Rehberlerde olmayan, özenle seçilmiş yerler';

  @override
  String get onb2Title => 'Gün Doğumunu\nYakala';

  @override
  String get onb2Sub => 'Unutulmaz anları dakikalar içinde planla';

  @override
  String get onb3Title => 'Yolculuklar\nArtık Kolay';

  @override
  String get onb3Sub => 'GlobeGo ile daha akıllı seyahat et';

  @override
  String get continueLabel => 'Devam';

  @override
  String get slide => 'Kaydır';

  @override
  String greeting(String name) {
    return 'Merhaba, $name';
  }

  @override
  String get regionAsia => 'Asya';

  @override
  String get regionEurope => 'Avrupa';

  @override
  String get regionAmerica => 'Amerika';

  @override
  String get all => 'Tümü';

  @override
  String get navHome => 'Ana sayfa';

  @override
  String get navDiscover => 'Keşfet';

  @override
  String get navBooking => 'Seyahatler';

  @override
  String get navProfile => 'Profil';

  @override
  String get perNight => '/gece';

  @override
  String get extraTicket => 'Bilet';

  @override
  String get extraHotel => 'Otel';

  @override
  String get extraMeal => 'Yemek';

  @override
  String get extraTicketLong => 'Şehir turu bileti';

  @override
  String get extraHotelLong => 'Oda yükseltme';

  @override
  String get extraMealLong => 'Yarım pansiyon';

  @override
  String get extraTicketHint => 'Kişi başı \$49';

  @override
  String get extraHotelHint => 'Gecelik \$60';

  @override
  String get extraMealHint => 'Kişi başı gecelik \$35';

  @override
  String get scheduleOverview => 'Program Özeti';

  @override
  String get readMore => 'Devamını oku';

  @override
  String get readLess => 'Daha az göster';

  @override
  String get message => 'Mesaj';

  @override
  String get bookNow => 'Rezerve Et';

  @override
  String reviews(int count) {
    return '$count yorum';
  }

  @override
  String get searchHint => 'Destinasyon ya da ülke ara';

  @override
  String noResults(String query) {
    return '\"$query\" ile eşleşen destinasyon yok';
  }

  @override
  String get notifications => 'Bildirimler';

  @override
  String get notif1Title => 'Como Gölü\'nde %15 indirim';

  @override
  String get notif1Body =>
      'Sonbahar fiyatı için pazar gününden önce rezervasyon yap.';

  @override
  String get notif2Title => 'Kapadokya\'da balon sezonu';

  @override
  String get notif2Body => 'Gün doğumu uçuşları nisandan kasıma kadar sürüyor.';

  @override
  String get notif3Title => 'GlobeGo\'ya hoş geldin';

  @override
  String get notif3Body => 'Beğendiğin yerleri kalple kaydet, Keşfet\'te bul.';

  @override
  String get discoverTitle => 'Dünyayı keşfet';

  @override
  String get favorites => 'Favoriler';

  @override
  String get favoritesOnly => 'Sadece favoriler';

  @override
  String get noFavorites => 'Kaydetmek için bir destinasyondaki kalbe dokun.';

  @override
  String get bookingsTitle => 'Seyahatlerim';

  @override
  String get bookingsEmpty => 'Henüz seyahat yok';

  @override
  String get bookingsEmptyBody =>
      'Sevdiğin bir yeri bul, birkaç dokunuşla rezerve et.';

  @override
  String get explore => 'Destinasyonları keşfet';

  @override
  String get checkIn => 'Giriş';

  @override
  String nights(int count) {
    return '$count gece';
  }

  @override
  String guests(int count) {
    return '$count kişi';
  }

  @override
  String get stay => 'Konaklama';

  @override
  String get travellers => 'Yolcular';

  @override
  String get extras => 'Ekstralar';

  @override
  String get total => 'Toplam';

  @override
  String get confirmBooking => 'Rezervasyonu onayla';

  @override
  String get bookedTitle => 'Her şey hazır!';

  @override
  String bookedBody(String place) {
    return '$place seyahatin Seyahatlerim\'e kaydedildi.';
  }

  @override
  String get viewTrips => 'Seyahatlerimi gör';

  @override
  String get done => 'Tamam';

  @override
  String get cancelTrip => 'Seyahati iptal et';

  @override
  String cancelTripQuestion(String place) {
    return '$place seyahatini iptal etmek istiyor musun?';
  }

  @override
  String get keepTrip => 'Vazgeç';

  @override
  String get tripCancelled => 'Seyahat iptal edildi';

  @override
  String get chatTitle => 'Ev sahibiyle konuş';

  @override
  String get chatHost => 'Ev sahibi · dakikalar içinde yanıtlar';

  @override
  String chatHello(String place) {
    return 'Merhaba! Ben Giulia, $place için ev sahibinim. Nasıl yardımcı olabilirim?';
  }

  @override
  String get q1 => 'Kahvaltı dahil mi?';

  @override
  String get a1 =>
      'Kahvaltı 7–10 arası terasta servis ediliyor. Yarım pansiyon için \"Yemek\"i ekleyebilirsin.';

  @override
  String get q2 => 'Erken giriş yapabilir miyim?';

  @override
  String get a2 =>
      'Elbette — oda hazırsa 11:00\'den itibaren ücretsiz giriş yapabilirsin.';

  @override
  String get q3 => 'Havalimanı transferi var mı?';

  @override
  String get a3 =>
      'Evet, özel transfer araç başı 45 €. Uçuş numaranı göndermen yeterli.';

  @override
  String get typeMessage => 'Bir mesaj yaz…';

  @override
  String get autoReply => 'Teşekkürler! En kısa sürede dönüş yapacağım.';

  @override
  String get share => 'Paylaş';

  @override
  String get linkCopied => 'Bağlantı panoya kopyalandı';

  @override
  String get addFavorite => 'Favorilere ekle';

  @override
  String get removeFavorite => 'Favorilerden çıkar';

  @override
  String get profileTitle => 'Profil';

  @override
  String get trips => 'Seyahat';

  @override
  String get countries => 'Ülke';

  @override
  String get editName => 'Adını düzenle';

  @override
  String get name => 'Ad';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'İptal';

  @override
  String get language => 'Dil';

  @override
  String get replayIntro => 'Tanıtımı yeniden göster';

  @override
  String get about => 'Bu uygulama hakkında';

  @override
  String get aboutBody =>
      'Koushik Sarkar\'ın Dribbble\'daki \"Travel Booking App\" tasarımının Flutter ile piksel piksel yeniden yapılıp çalışan bir uygulamaya dönüştürülmüş hali. Fotoğraflar Unsplash\'ten.';

  @override
  String get designBy => 'Arayüz tasarımı: Koushik Sarkar';

  @override
  String get menu => 'Menü';

  @override
  String get explorer => 'Gezgin';

  @override
  String daysToGo(int count) {
    return '$count gün kaldı';
  }

  @override
  String get today => 'Bugün';
}
