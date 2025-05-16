import 'package:flutter/material.dart';

enum CharacterStatus {
  alive(statusColor: Colors.green, statusText: 'Alive'),
  dead(statusColor: Colors.red, statusText: 'Dead'),
  unknown(statusColor: Colors.grey, statusText: 'Unknown');

  final Color statusColor;
  final String statusText;

  const CharacterStatus({required this.statusColor, required this.statusText});
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
}
