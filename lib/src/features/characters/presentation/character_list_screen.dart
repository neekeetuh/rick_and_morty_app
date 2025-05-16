import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/src/features/characters/data/providers/character_provider.dart';
import 'widgets/character_card.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterProvider>(
      builder: (context, characterProvider, child) {
        final characters = characterProvider.allCharacters;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Rick and Morty Characters"),
            backgroundColor: Colors.deepPurpleAccent,
          ),
          body: characters.isEmpty
              ? const Center(
                  child: Text(
                  "No available characters.",
                ))
              : ListView.builder(
                  itemCount: characters.length,
                  itemBuilder: (conext, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: CharacterCard(character: characters[index]),
                  ),
                ),
        );
      },
    );
  }
}
