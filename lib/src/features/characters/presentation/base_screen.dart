import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/src/common/consts/string_consts.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/bloc/bloc/characters_bloc.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/character_list_screen.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/favorites_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CharacterListScreen(),
    FavoritesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    context.read<CharactersBloc>().add(const LoadCharactersEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: StringConsts.charactersTabTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: StringConsts.favoritesTabTitle,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
