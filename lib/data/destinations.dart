enum Region { asia, europe, america }

/// A string in both supported languages.
class Tr {
  const Tr(this.en, this.tr);

  final String en;
  final String tr;

  String of(String languageCode) => languageCode == 'tr' ? tr : en;
}

class Destination {
  const Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.region,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.about,
  });

  final String id;
  final Tr name;
  final Tr country;
  final Region region;
  final double rating;
  final int reviews;

  /// Price per night in USD.
  final int price;
  final Tr about;

  String get image => 'assets/images/$id.jpg';
}

const regionImages = {
  Region.asia: 'assets/images/region_asia.jpg',
  Region.europe: 'assets/images/region_europe.jpg',
  Region.america: 'assets/images/region_america.jpg',
};

const destinations = <Destination>[
  Destination(
    id: 'manarola',
    name: Tr('Manarola', 'Manarola'),
    country: Tr('Italy', 'İtalya'),
    region: Region.europe,
    rating: 5.0,
    reviews: 1284,
    price: 640,
    about: Tr(
      'Perched on a cliff above the Ligurian Sea, Manarola is the oldest of the five Cinque Terre villages. '
          'Pastel houses tumble down to a tiny harbour, and the coastal path to Corniglia offers the best sunset in Liguria.',
      'Ligurya Denizi\'ne bakan bir yamaca kurulan Manarola, Cinque Terre\'nin beş köyünün en eskisidir. '
          'Pastel renkli evler küçük bir limana doğru iner; Corniglia\'ya giden kıyı yolu bölgenin en güzel gün batımını sunar.',
    ),
  ),
  Destination(
    id: 'santorini',
    name: Tr('Santorini', 'Santorini'),
    country: Tr('Greece', 'Yunanistan'),
    region: Region.europe,
    rating: 5.0,
    reviews: 2310,
    price: 720,
    about: Tr(
      'Whitewashed villages, blue domes and a flooded volcanic caldera make Santorini one of the most photographed islands on Earth. '
          'Walk the rim from Fira to Oia and stay for the famous sunset.',
      'Beyaz badanalı köyleri, mavi kubbeleri ve sular altındaki volkanik kalderasıyla Santorini dünyanın en çok fotoğraflanan adalarından biri. '
          'Fira\'dan Oia\'ya kraterin kenarından yürü ve meşhur gün batımını izle.',
    ),
  ),
  Destination(
    id: 'lake_como',
    name: Tr('Lake Como', 'Como Gölü'),
    country: Tr('Italy', 'İtalya'),
    region: Region.europe,
    rating: 4.9,
    reviews: 986,
    price: 899,
    about: Tr(
      'Nestled in Northern Italy, Lake Como is a stunning glacial lake surrounded by dramatic mountains and elegant villas. '
          'Hop between Bellagio, Varenna and Menaggio by ferry and spend the evenings on a lakeside terrace.',
      'Kuzey İtalya\'da, sarp dağlar ve zarif villalarla çevrili Como Gölü buzullardan oluşmuş büyüleyici bir göldür. '
          'Bellagio, Varenna ve Menaggio arasında vapurla gez, akşamları göl kıyısındaki bir terasta geçir.',
    ),
  ),
  Destination(
    id: 'venice',
    name: Tr('Venice', 'Venedik'),
    country: Tr('Italy', 'İtalya'),
    region: Region.europe,
    rating: 4.8,
    reviews: 3120,
    price: 780,
    about: Tr(
      'A city built on 118 islands, Venice is best explored on foot and by vaporetto. '
          'Watch the light change over Santa Maria della Salute, then get lost in the quiet canals of Cannaregio.',
      '118 adanın üzerine kurulan Venedik en iyi yürüyerek ve vaporettoyla keşfedilir. '
          'Santa Maria della Salute üzerindeki ışığın değişimini izle, sonra Cannaregio\'nun sakin kanallarında kaybol.',
    ),
  ),
  Destination(
    id: 'dubrovnik',
    name: Tr('Dubrovnik', 'Dubrovnik'),
    country: Tr('Croatia', 'Hırvatistan'),
    region: Region.europe,
    rating: 4.8,
    reviews: 1540,
    price: 510,
    about: Tr(
      'The "Pearl of the Adriatic" is wrapped in 2 km of medieval walls. '
          'Walk them early in the morning, take the cable car up Mount Srđ and swim off the rocks below the old town.',
      '"Adriyatik\'in incisi" 2 km\'lik ortaçağ surlarıyla çevrili. '
          'Surlarda sabah erkenden yürü, teleferikle Srđ Dağı\'na çık ve eski şehrin altındaki kayalıklarda yüz.',
    ),
  ),
  Destination(
    id: 'kyoto',
    name: Tr('Kyoto', 'Kyoto'),
    country: Tr('Japan', 'Japonya'),
    region: Region.asia,
    rating: 4.9,
    reviews: 2875,
    price: 560,
    about: Tr(
      'Japan\'s former capital has more than 1,600 temples, wooden machiya houses and lantern-lit streets. '
          'Visit Fushimi Inari at dawn and stroll through Gion when the evening lights come on.',
      'Japonya\'nın eski başkentinde 1.600\'den fazla tapınak, ahşap machiya evleri ve fenerlerle aydınlanan sokaklar var. '
          'Fushimi Inari\'yi şafakta ziyaret et, akşam ışıkları yanınca Gion\'da yürü.',
    ),
  ),
  Destination(
    id: 'bali',
    name: Tr('Bali', 'Bali'),
    country: Tr('Indonesia', 'Endonezya'),
    region: Region.asia,
    rating: 4.8,
    reviews: 4012,
    price: 420,
    about: Tr(
      'Rice terraces, water temples and black-sand beaches: Bali mixes calm and adventure. '
          'Watch the mist lift over Ulun Danu Beratan and end the day with a Balinese massage in Ubud.',
      'Pirinç terasları, su tapınakları ve siyah kumlu plajlarıyla Bali huzur ile maceranın karışımı. '
          'Ulun Danu Beratan\'da sisin kalkışını izle, günü Ubud\'da bir Bali masajıyla bitir.',
    ),
  ),
  Destination(
    id: 'cappadocia',
    name: Tr('Cappadocia', 'Kapadokya'),
    country: Tr('Türkiye', 'Türkiye'),
    region: Region.asia,
    rating: 5.0,
    reviews: 3640,
    price: 380,
    about: Tr(
      'Fairy chimneys, cave hotels and hundreds of hot-air balloons at sunrise. '
          'Explore the underground cities, hike the Rose Valley and sleep in a room carved into the rock.',
      'Peri bacaları, mağara oteller ve gün doğarken yükselen yüzlerce sıcak hava balonu. '
          'Yeraltı şehirlerini keşfet, Güllüdere Vadisi\'nde yürü ve kayaya oyulmuş bir odada uyu.',
    ),
  ),
  Destination(
    id: 'maldives',
    name: Tr('Maldives', 'Maldivler'),
    country: Tr('Maldives', 'Maldivler'),
    region: Region.asia,
    rating: 4.9,
    reviews: 1890,
    price: 1250,
    about: Tr(
      'Twenty-six coral atolls with water so clear you can see the reef from your villa. '
          'Snorkel with manta rays, take a seaplane between islands and dine under the stars.',
      'Yirmi altı mercan atolünde su o kadar berrak ki resifi villandan görebilirsin. '
          'Vatoz balıklarıyla şnorkel yap, adalar arasında deniz uçağıyla uç ve yıldızların altında akşam yemeği ye.',
    ),
  ),
  Destination(
    id: 'new_york',
    name: Tr('New York', 'New York'),
    country: Tr('USA', 'ABD'),
    region: Region.america,
    rating: 4.7,
    reviews: 5230,
    price: 690,
    about: Tr(
      'Skyscrapers, Broadway shows and food from every corner of the world. '
          'Cross the Brooklyn Bridge at sunset, spend a morning in Central Park and see the city from the Top of the Rock.',
      'Gökdelenler, Broadway gösterileri ve dünyanın her köşesinden lezzetler. '
          'Gün batımında Brooklyn Köprüsü\'nü geç, bir sabahını Central Park\'ta geçir ve şehri Top of the Rock\'tan izle.',
    ),
  ),
  Destination(
    id: 'machu_picchu',
    name: Tr('Machu Picchu', 'Machu Picchu'),
    country: Tr('Peru', 'Peru'),
    region: Region.america,
    rating: 5.0,
    reviews: 2150,
    price: 470,
    about: Tr(
      'The 15th-century Inca citadel sits at 2,430 m in the Andes, often wrapped in clouds. '
          'Hike the Inca Trail or take the train from Cusco, then climb Huayna Picchu for the classic view.',
      '15. yüzyıldan kalma İnka kalesi And Dağları\'nda 2.430 metrede, çoğu zaman bulutların içinde. '
          'İnka Yolu\'nda yürü ya da Cusco\'dan trene bin, klasik manzara için Huayna Picchu\'ya tırman.',
    ),
  ),
  Destination(
    id: 'banff',
    name: Tr('Banff', 'Banff'),
    country: Tr('Canada', 'Kanada'),
    region: Region.america,
    rating: 4.9,
    reviews: 1720,
    price: 540,
    about: Tr(
      'Turquoise glacial lakes and the jagged peaks of the Canadian Rockies. '
          'Paddle a canoe on Moraine Lake, drive the Icefields Parkway and look out for elk in town.',
      'Turkuaz buzul gölleri ve Kanada Kayalık Dağları\'nın sivri zirveleri. '
          'Moraine Gölü\'nde kano çek, Icefields Parkway\'de araba sür ve kasabada geyiklere dikkat et.',
    ),
  ),
  Destination(
    id: 'rio',
    name: Tr('Rio de Janeiro', 'Rio de Janeiro'),
    country: Tr('Brazil', 'Brezilya'),
    region: Region.america,
    rating: 4.7,
    reviews: 2680,
    price: 450,
    about: Tr(
      'Mountains, beaches and samba in one city. '
          'Ride the cable car up Sugarloaf Mountain, watch the sunset from Arpoador and dance in Lapa at night.',
      'Dağlar, plajlar ve samba tek bir şehirde. '
          'Teleferikle Şeker Somunu Dağı\'na çık, gün batımını Arpoador\'dan izle ve gece Lapa\'da dans et.',
    ),
  ),
];

Destination destinationById(String id) => destinations.firstWhere((d) => d.id == id);

/// Optional extras that can be added to a stay (the three chips on the detail screen).
enum Extra { ticket, hotel, meal }

/// Extra prices in USD.
int extraPrice(Extra extra, {required int nights, required int guests}) => switch (extra) {
      Extra.ticket => 49 * guests,
      Extra.hotel => 60 * nights,
      Extra.meal => 35 * guests * nights,
    };

int bookingTotal(Destination d, {required int nights, required int guests, required Set<Extra> extras}) =>
    d.price * nights + extras.fold(0, (sum, e) => sum + extraPrice(e, nights: nights, guests: guests));
