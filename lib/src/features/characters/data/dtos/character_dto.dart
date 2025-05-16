class LocationDto {
  final String name;
  final String url;

  LocationDto({
    required this.name,
    required this.url,
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
}

class CharacterDto {
  final int id;
  final String name;
  final String status;
  final String species;
  final LocationDto location;
  final String image;

  CharacterDto({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.location,
    required this.image,
  });

  factory CharacterDto.fromJson(Map<String, dynamic> json) {
    return CharacterDto(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Unnamed',
      status: json['status'] as String? ?? 'unknown',
      species: json['species'] as String? ?? 'Unknown Species',
      location:
          LocationDto.fromJson(json['location'] as Map<String, dynamic>? ?? {}),
      image: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'location': location.toJson(),
      'image': image,
    };
  }
}
