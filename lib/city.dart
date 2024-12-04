import 'package:myapp/city_type.dart';

class City {
  final int prefCode;
  final String cityCode;
  final String cityName;
  final CityType cityType;
  
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      prefCode: json['prefCode'] as int,
      cityCode: json['cityCode'] as String,
      cityName: json['cityName'] as String,
      cityType:CityType.values[int.parse(json[ 'bigCityFlag'] as String)]);
  }

  City({
    required this.prefCode,
    required this.cityCode,
    required this.cityName,
    required this.cityType,
  });
}
