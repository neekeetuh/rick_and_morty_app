import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/src/common/consts/string_consts.dart';
import 'package:rick_and_morty_app/src/common/consts/text_styles_consts.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/bloc/bloc/characters_bloc.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/widgets/character_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

enum SortCriteria { nameAsc, nameDesc, status }

const _favoritesPageStorageKey = 'favorites';

class _FavoritesScreenState extends State<FavoritesScreen> {
  SortCriteria _sortCriteria = SortCriteria.nameAsc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(StringConsts.appBarFavorites),
          actions: [
            PopupMenuButton<SortCriteria>(
              icon: const Icon(Icons.sort),
              onSelected: (SortCriteria value) {
                setState(() {
                  _sortCriteria = value;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SortCriteria>>[
                const PopupMenuItem<SortCriteria>(
                  value: SortCriteria.nameAsc,
                  child: Text(StringConsts.sortInAsc),
                ),
                const PopupMenuItem<SortCriteria>(
                  value: SortCriteria.nameDesc,
                  child: Text(StringConsts.sortInDesc),
                ),
                const PopupMenuItem<SortCriteria>(
                  value: SortCriteria.status,
                  child: Text(StringConsts.sortByStatus),
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            List<Character> favoriteCharacters = state.favorites ?? [];
            switch (_sortCriteria) {
              case SortCriteria.nameAsc:
                favoriteCharacters.sort((a, b) => a.name.compareTo(b.name));
              case SortCriteria.nameDesc:
                favoriteCharacters.sort((a, b) => b.name.compareTo(a.name));
              case SortCriteria.status:
                favoriteCharacters
                    .sort((a, b) => a.status.index.compareTo(b.status.index));
            }
            return favoriteCharacters.isEmpty
                ? const Center(
                    child: Text(
                      StringConsts.favoritesListIsEmpty,
                      textAlign: TextAlign.center,
                      style: TextStylesConsts.body2,
                    ),
                  )
                : ListView.builder(
                    key: const PageStorageKey(_favoritesPageStorageKey),
                    itemCount: favoriteCharacters.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child:
                          CharacterCard(character: favoriteCharacters[index]),
                    ),
                  );
          },
          buildWhen: (previous, current) => current is! IdleCharactersState,
        ));
  }
}
