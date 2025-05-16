import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/src/common/consts/string_consts.dart';
import 'package:rick_and_morty_app/src/common/consts/text_styles_consts.dart';
import 'package:rick_and_morty_app/src/features/characters/data/providers/character_provider.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/widgets/character_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  String _sortCriteria = 'name_asc';

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterProvider>(
      builder: (context, characterProvider, child) {
        List<Character> favoriteCharacters =
            characterProvider.favoriteCharacters;

        if (_sortCriteria == 'name_asc') {
          favoriteCharacters.sort((a, b) => a.name.compareTo(b.name));
        } else if (_sortCriteria == 'name_desc') {
          favoriteCharacters.sort((a, b) => b.name.compareTo(a.name));
        } else if (_sortCriteria == 'status') {
          favoriteCharacters
              .sort((a, b) => a.status.index.compareTo(b.status.index));
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(StringConsts.appBarFavorites),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.sort),
                onSelected: (String value) {
                  setState(() {
                    _sortCriteria = value;
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'name_asc',
                    child: Text(StringConsts.sortInAsc),
                  ),
                  const PopupMenuItem<String>(
                    value: 'name_desc',
                    child: Text(StringConsts.sortInDesc),
                  ),
                  const PopupMenuItem<String>(
                    value: 'status',
                    child: Text(StringConsts.sortByStatus),
                  ),
                ],
              ),
            ],
          ),
          body: favoriteCharacters.isEmpty
              ? const Center(
                  child: Text(
                    StringConsts.favoritesListIsEmpty,
                    textAlign: TextAlign.center,
                    style: TextStylesConsts.body2,
                  ),
                )
              : ListView.builder(
                  itemCount: favoriteCharacters.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: CharacterCard(character: favoriteCharacters[index]),
                  ),
                ),
        );
      },
    );
  }
}
