import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/src/common/consts/string_consts.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/bloc/bloc/characters_bloc.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/widgets/theme_toggle_button.dart';
import 'widgets/character_card.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConsts.appBarCharacters),
        actions: const [ThemeToggleButton()],
      ),
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          if (state is LoadingCharactersState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorCharactersState) {
            return const Center(
              child: Text(StringConsts.charactersLoadingErrorText),
            );
          }
          final characters = state.characters ?? [];
          return characters.isEmpty
              ? const Center(
                  child: Text(
                  StringConsts.noAvailableCharacters,
                ))
              : NotificationListener<ScrollNotification>(
                  onNotification: _onNotification,
                  child: ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (conext, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: CharacterCard(character: characters[index]),
                    ),
                  ),
                );
        },
        buildWhen: (previous, current) => current is! IdleCharactersState,
      ),
    );
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        notification.metrics.pixels == notification.metrics.minScrollExtent) {
      //TODO: implement refreshing
    }
    if (notification is ScrollEndNotification &&
        notification.metrics.pixels == notification.metrics.maxScrollExtent) {
      //TODO: implement paginated loading
    }
    return false;
  }
}
