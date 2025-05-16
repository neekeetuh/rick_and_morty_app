import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/src/common/consts/string_consts.dart';
import 'package:rick_and_morty_app/src/common/theme/theme_provider.dart';
import 'package:rick_and_morty_app/src/common/theme/themes.dart';
import 'package:rick_and_morty_app/src/features/characters/data/data_sources/characters_api_data_source.dart';
import 'package:rick_and_morty_app/src/features/characters/data/providers/character_provider.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/base_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Builder(builder: (context) {
        return MaterialApp(
          title: StringConsts.appName,
          theme: Provider.of<ThemeProvider>(context).isDarkMode
              ? darkTheme
              : lightTheme,
          home: ChangeNotifierProvider(
            create: (context) => CharacterProvider(
                repository: CharactersRepository(
              charactersDataSource: CharactersApiDataSource(
                dio: Dio(),
              ),
            )),
            child: const BaseScreen(),
          ),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
