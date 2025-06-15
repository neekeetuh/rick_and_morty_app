import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/src/common/consts/string_consts.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/bloc/bloc/characters_bloc.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/widgets/theme_toggle_button.dart';
import 'widgets/character_card.dart';

const _charactersPageStorageKey = 'characters';

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
          if (state is ErrorCharactersState) {
            return const Center(
              child: Text(StringConsts.charactersLoadingErrorText),
            );
          }
          final characters = state.characters ?? [];
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) =>
                _onNotification(notification, context),
            child: CustomScrollView(
              key: const PageStorageKey(_charactersPageStorageKey),
              slivers: [
                if (state is LoadingCharactersState) ...[
                  const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                ],
                SliverList.builder(
                  itemCount: characters.length,
                  itemBuilder: (conext, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: CharacterCard(character: characters[index]),
                  ),
                ),
              ],
            ),
          );
        },
        buildWhen: (previous, current) => current is! IdleCharactersState,
      ),
    );
  }

  bool _onNotification(ScrollNotification notification, BuildContext context) {
    if (notification is ScrollEndNotification &&
        notification.metrics.pixels == notification.metrics.minScrollExtent) {
      context.read<CharactersBloc>().add(const RefreshCharactersEvent());
    }
    if (notification is ScrollEndNotification &&
        notification.metrics.pixels == notification.metrics.maxScrollExtent) {
      context.read<CharactersBloc>().add(const LoadCharactersEvent());
    }
    return false;
  }
}
