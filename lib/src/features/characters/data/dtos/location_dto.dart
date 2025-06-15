import 'package:drift/drift.dart';

class LocationDto {
  final String name;
  final String url;

  LocationDto({
    required this.name,
    this.url = '',
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
      name: json['name'] as String? ?? 'Unknown Location',
      url: json['url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

  static JsonTypeConverter<LocationDto, String> converter = TypeConverter.json(
    fromJson: (json) => LocationDto.fromJson(json as Map<String, Object?>),
    toJson: (pref) => pref.toJson(),
  );
}
