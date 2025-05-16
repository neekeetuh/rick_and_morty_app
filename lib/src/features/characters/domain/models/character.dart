import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/features/characters/data/dtos/character_dto.dart';

enum CharacterStatus {
  alive(statusColor: Colors.green, statusText: 'Alive', statusCode: 'Alive'),
  dead(statusColor: Colors.red, statusText: 'Dead', statusCode: 'Dead'),
  unknown(
      statusColor: Colors.grey, statusText: 'Unknown', statusCode: 'unknown');

  final Color statusColor;
  final String statusText;
  final String statusCode;

  const CharacterStatus(
      {required this.statusColor,
      required this.statusText,
      required this.statusCode});
}

class Character {
  final int id;
  final String name;
  final String imageUrl;
  final CharacterStatus status;
  final String species;
  final String lastKnownLocation;
  bool isFavorite;

  Character({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.status,
    required this.species,
    required this.lastKnownLocation,
    this.isFavorite = false,
  });

  factory Character.fromDto(CharacterDto dto) {
    return Character(
      id: dto.id,
      name: dto.name,
      imageUrl: dto.image,
      status: CharacterStatus.values
          .firstWhere((el) => el.statusCode == dto.status),
      species: dto.species,
      lastKnownLocation: dto.location.name,
    );
  }

  CharacterDto toDto() {
    return CharacterDto(
      id: id,
      name: name,
      status: status.statusText,
      species: species,
      location: LocationDto(name: lastKnownLocation, url: ''),
      image: imageUrl,
    );
  }
}
