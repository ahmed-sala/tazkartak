
class MetroStationModel {
  final String name;
  final double latitude;
  final double longitude;
  final String  exchangeWithFonts;
  final int  line;
  MetroStationModel({required this.line, this.exchangeWithFonts="", required this.name, required this.latitude, required this.longitude});
}
List<MetroStationModel> metroStationsOne = [
  MetroStationModel(name: "حلوان", latitude: 29.8440, longitude: 31.3008,line: 1),
  MetroStationModel(name: "عين حلوان", latitude: 29.8711, longitude: 31.3157,line: 1),
  MetroStationModel(name: "جامعة حلوان", latitude: 29.8994, longitude: 31.3199,line: 1),
  MetroStationModel(name: "وادي حوف", latitude: 29.9223, longitude: 31.3205,line: 1),
  MetroStationModel(name: "حدائق حلوان", latitude: 29.9384, longitude: 31.3200,line: 1),
  MetroStationModel(name: "المعصرة", latitude: 29.9574, longitude: 31.3176,line: 1),
  MetroStationModel(name: "طرة الأسمنت", latitude: 29.9721, longitude: 31.3055,line: 1),
  MetroStationModel(name: "كوتسيكا", latitude: 29.9828, longitude: 31.2969,line: 1),
  MetroStationModel(name: "طرة البلد", latitude: 29.9904, longitude: 31.2892,line: 1),
  MetroStationModel(name: "ثكنات المعادي", latitude: 30.0045, longitude: 31.2788,line: 1),
  MetroStationModel(name: "المعادي", latitude: 30.0131, longitude: 31.2721,line: 1),
  MetroStationModel(name: "حدائق المعادي", latitude: 30.0204, longitude: 31.2670,line: 1),
  MetroStationModel(name: "دار السلام", latitude: 30.0315, longitude: 31.2568,line: 1),
  MetroStationModel(name: "الزهراء", latitude: 30.0432, longitude: 31.2473,line: 1),
  MetroStationModel(name: "مار جرجس", latitude: 30.0471, longitude: 31.2445,line: 1),
  MetroStationModel(name: "الملك الصالح", latitude: 30.0519, longitude: 31.2359,line: 1),
  MetroStationModel(name: "السيدة زينب", latitude: 30.0535, longitude: 31.2314,line: 1),
  MetroStationModel(name: "سعد زغلول", latitude: 30.0562, longitude: 31.2282,line: 1),
  MetroStationModel(name: "أنور السادات", latitude: 30.0444, longitude: 31.2357, exchangeWithFonts: " line 2 ",line: 1),
  MetroStationModel(name: "جمال عبد الناصر", latitude: 30.0525, longitude: 31.2398,exchangeWithFonts: "line 3 ",line: 1),
  MetroStationModel(name: "أحمد عرابي", latitude: 30.0567, longitude: 31.2435,line: 1),
  MetroStationModel(name: "الشهداء", latitude: 30.0631, longitude: 31.2472,exchangeWithFonts: "line 2",line: 1),
  MetroStationModel(name: "غمرة", latitude: 30.0692, longitude: 31.2554,line: 1),
  MetroStationModel(name: "الدمرداش", latitude: 30.0753, longitude: 31.2619,line: 1),
  MetroStationModel(name: "منشية الصدر", latitude: 30.0815, longitude: 31.2682,line: 1),
  MetroStationModel(name: "كوبري القبة", latitude: 30.0867, longitude: 31.2739,line: 1),
  MetroStationModel(name: "حمامات القبة", latitude: 30.0919, longitude: 31.2796,line: 1),
  MetroStationModel(name: "سراي القبة", latitude: 30.0969, longitude: 31.2853,line: 1),
  MetroStationModel(name: "حدائق الزيتون", latitude: 30.1021, longitude: 31.2910,line: 1),
  MetroStationModel(name: "حلمية الزيتون", latitude: 30.1072, longitude: 31.2967,line: 1),
  MetroStationModel(name: "المطرية", latitude: 30.1124, longitude: 31.3024,line: 1),
  MetroStationModel(name: "عين شمس", latitude: 30.1176, longitude: 31.3081,line: 1),
  MetroStationModel(name: "عزبة النخل", latitude: 30.1245, longitude: 31.3148,line: 1),
  MetroStationModel(name: "المرج", latitude: 30.1335, longitude: 31.3221,line: 1),
  MetroStationModel(name: "المرج الجديدة", latitude: 30.1442, longitude: 31.3302,line: 1),
];
List<MetroStationModel> metroStationsTwo = [
  MetroStationModel(name: "المنيب", latitude: 29.9737, longitude: 31.2156, line:2),
  MetroStationModel(name: "ساقية مكي", latitude: 29.9892, longitude: 31.2060,line: 2),
  MetroStationModel(name: "أم المصريين", latitude: 29.9963, longitude: 31.2019,line: 2),
  MetroStationModel(name: "الجيزة", latitude: 30.0105, longitude: 31.1951,line: 2),
  MetroStationModel(name: "فيصل", latitude: 30.0165, longitude: 31.1900,line: 2),
  MetroStationModel(name: "جامعة القاهرة", latitude: 30.0285, longitude: 31.2116,line: 2),
  MetroStationModel(name: "البحوث", latitude: 30.0355, longitude: 31.2138,line: 2),
  MetroStationModel(name: "الدقي", latitude: 30.0427, longitude: 31.2243,line: 2),
  MetroStationModel(name: "الأوبرا", latitude: 30.0444, longitude: 31.2315,line: 2),
  MetroStationModel(name: "أنور السادات", latitude: 30.0444, longitude: 31.2357,exchangeWithFonts: "line 1",line: 2),
  MetroStationModel(name: "محمد نجيب", latitude: 30.0456, longitude: 31.2440,line: 2),
  MetroStationModel(name: "العتبة", latitude: 30.0485, longitude: 31.2480,exchangeWithFonts: "line 3",line: 2),
  MetroStationModel(name: "الشهداء", latitude: 30.0535, longitude: 31.2464,exchangeWithFonts: "line 1",line: 2),
  MetroStationModel(name: "مسرة", latitude: 30.0640, longitude: 31.2465,line: 2),
  MetroStationModel(name: "روض الفرج", latitude: 30.0721, longitude: 31.2458,line: 2),
  MetroStationModel(name: "سانتا تريزا", latitude: 30.0763, longitude: 31.2450,line: 2),
  MetroStationModel(name: "الخلفاوي", latitude: 30.0830, longitude: 31.2438,line: 2),
  MetroStationModel(name: "المظلات", latitude: 30.0902, longitude: 31.2421,line: 2),
  MetroStationModel(name: "كلية الزراعة", latitude: 30.0974, longitude: 31.2405,line: 2),
  MetroStationModel(name: "شبرا الخيمة", latitude: 30.1050, longitude: 31.2388,line: 2),
];
List<MetroStationModel> metroStationsThree = [
  MetroStationModel(name: "عدلي منصور", latitude: 30.1235, longitude: 31.4050,line: 3),
  MetroStationModel(name: "الهايكستب", latitude: 30.1275, longitude: 31.3921,line: 3),
  MetroStationModel(name: "عمر بن الخطاب", latitude: 30.1305, longitude: 31.3820,line: 3),
  MetroStationModel(name: "قباء", latitude: 30.1350, longitude: 31.3735,line: 3),
  MetroStationModel(name: "هشام بركات", latitude: 30.1385, longitude: 31.3640,line: 3),
  MetroStationModel(name: "النزهة", latitude: 30.1420, longitude: 31.3550,line: 3),
  MetroStationModel(name: "نادي الشمس", latitude: 30.1455, longitude: 31.3465,line: 3),
  MetroStationModel(name: "ألف مسكن", latitude: 30.1490, longitude: 31.3380,line: 3),
  MetroStationModel(name: "هليوبوليس", latitude: 30.1530, longitude: 31.3300,line: 3),
  MetroStationModel(name: "هارون", latitude: 30.1575, longitude: 31.3220,line: 3),
  MetroStationModel(name: "الأهرام", latitude: 30.1620, longitude: 31.3145,line: 3),
  MetroStationModel(name: "كلية البنات", latitude: 30.1665, longitude: 31.3070,line: 3),
  MetroStationModel(name: "الاستاد", latitude: 30.1705, longitude: 31.3000,line: 3),
  MetroStationModel(name: "أرض المعارض", latitude: 30.1750, longitude: 31.2930,line: 3),
  MetroStationModel(name: "العباسية", latitude: 30.1800, longitude: 31.2865,line: 3),
  MetroStationModel(name: "عبده باشا", latitude: 30.1845, longitude: 31.2800,line: 3),
  MetroStationModel(name: "الجيش", latitude: 30.1890, longitude: 31.2740,line: 3),
  MetroStationModel(name: "باب الشعرية", latitude: 30.1935, longitude: 31.2680,line: 3),
  MetroStationModel(name: "العتبة", latitude: 30.1980, longitude: 31.2620,exchangeWithFonts: "line 2 ",line: 3),
  MetroStationModel(name: "جمال عبد الناصر", latitude: 30.2030, longitude: 31.2560,exchangeWithFonts: "line 1",line: 3),
  MetroStationModel(name: "ماسبيرو", latitude: 30.2080, longitude: 31.2500,line: 3),
  MetroStationModel(name: "صفاء حجازي", latitude: 30.2130, longitude: 31.2445,line: 3),
  MetroStationModel(name: "الكيت كات", latitude: 30.2180, longitude: 31.2390,line: 3),
  MetroStationModel(name: "السودان", latitude: 30.2230, longitude: 31.2340,line: 3),
  MetroStationModel(name: "إمبابة", latitude: 30.2280, longitude: 31.2290,line: 3),
  MetroStationModel(name: "البوهي", latitude: 30.2330, longitude: 31.2245,line: 3),
  MetroStationModel(name: "القومية", latitude: 30.2380, longitude: 31.2200,line: 3),
  MetroStationModel(name: "الطريق الدائري", latitude: 30.2430, longitude: 31.2150,line: 3),
  MetroStationModel(name: "محور روض الفرج", latitude: 30.2480, longitude: 31.2100,line: 3),
  MetroStationModel(name: "التوفيقية", latitude: 30.2530, longitude: 31.2050,line: 3),
  MetroStationModel(name: "وادي النيل", latitude: 30.2580, longitude: 31.2005,line: 3),
  MetroStationModel(name: "جامعة الدول العربية", latitude: 30.2630, longitude: 31.1960,line: 3),
  MetroStationModel(name: "بولاق الدكرور", latitude: 30.2680, longitude: 31.1915,line: 3),
  MetroStationModel(name: "جامعة القاهرة", latitude: 30.2730, longitude: 31.1870,exchangeWithFonts: "line 2",line: 3),
];
List<MetroStationModel>metroSelection=[];
ResultRouteMetro findStationsBetween({
  required MetroStationModel startMetroStation,
  required MetroStationModel endMetroStation,
}) {
  List<MetroStationModel> getLineStations(int line) {
    switch (line) {
      case 1:
        return metroStationsOne;
      case 2:
        return metroStationsTwo;
      case 3:
        return metroStationsThree;
      default:
        return [];
    }
  }

  List<MetroStationModel> result = [];
  List<MetroStationModel> startLineStations = getLineStations(startMetroStation.line);
  List<MetroStationModel> endLineStations = getLineStations(endMetroStation.line);

  if (startMetroStation.line == endMetroStation.line) {
    int startIndex = startLineStations.indexWhere((s) => s.name == startMetroStation.name);
    int endIndex = startLineStations.indexWhere((s) => s.name == endMetroStation.name);
    if (startIndex == -1 || endIndex == -1) {
      return ResultRouteMetro(metro: [],
          price: "",
          message: "المحطات غير موجودة في الخط المحدد.");
    }
    return ResultRouteMetro(
      metro: startIndex <= endIndex
          ? startLineStations.sublist(startIndex, endIndex + 1)
          : startLineStations.sublist(endIndex, startIndex + 1).reversed.toList(),
      message: "لا يوجد تحويل، الرحلة مباشرة على الخط ${startMetroStation.line}.",
      price: priceMetro(length: result.length).toString(),

    );
  }

  Map<int, List<String>> interchangeStations = {
    1: ["الشهداء", "أنور السادات", "جمال عبد الناصر"],
    2: ["الشهداء", "العتبة", "أنور السادات"],
    3: ["العتبة", "جامعة القاهرة", "جمال عبد الناصر"],
  };

  List<String> commonStations = interchangeStations[startMetroStation.line]!
      .where((station) => interchangeStations[endMetroStation.line]!.contains(station))
      .toList();

  if (commonStations.isEmpty) {
    return const ResultRouteMetro(metro: [],
        price: "",
        message: "لا يوجد محطة تحويل مشتركة بين الخطين المحددين.");
  }

  String interchangeStation = commonStations.first;
  int startIndex = startLineStations.indexWhere((s) => s.name == startMetroStation.name);
  int interchangeStartIndex = startLineStations.indexWhere((s) => s.name == interchangeStation);
  int interchangeEndIndex = endLineStations.indexWhere((s) => s.name == interchangeStation);
  int endIndex = endLineStations.indexWhere((s) => s.name == endMetroStation.name);

  if ([startIndex, interchangeStartIndex, interchangeEndIndex, endIndex].contains(-1)) {
    return const ResultRouteMetro(metro: [], message: "خطأ في تحديد المحطات.",price: "");
  }

  result.addAll(startIndex <= interchangeStartIndex
      ? startLineStations.sublist(startIndex, interchangeStartIndex + 1)
      : startLineStations.sublist(interchangeStartIndex, startIndex + 1).reversed);

  result.addAll(interchangeEndIndex <= endIndex
      ? endLineStations.sublist(interchangeEndIndex, endIndex + 1)
      : endLineStations.sublist(endIndex, interchangeEndIndex + 1).reversed);

  return ResultRouteMetro(
    metro: result,
    price: priceMetro(length: result.length).toString(),
    message: "🚉 التحويل عند: $interchangeStation، ثم ركوب الخط ${endMetroStation.line}.",
  );
}

class ResultRouteMetro {
  final List<MetroStationModel> metro;
  final String message;
  final String price;

  const ResultRouteMetro({required this.price,required this.metro, required this.message});
}


int  priceMetro({required int length}){
   print("price :$length");
  if(length <= 9  ){
   return 8;
  }else if(length <= 16){
    return 10;
  }else if(length <= 23){
    return 15;
  }else{
    return 20;
  }
}
