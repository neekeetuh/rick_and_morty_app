import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/src/common/consts/string_consts.dart';
import 'package:rick_and_morty_app/src/common/theme/theme_provider.dart';
import 'package:rick_and_morty_app/src/common/theme/themes.dart';
import 'package:rick_and_morty_app/src/features/characters/data/data_sources/characters_api_data_source.dart';
import 'package:rick_and_morty_app/src/features/characters/data/database/database.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/repositories/characters_repository.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/base_screen.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/bloc/bloc/characters_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Provider<RickAndMortyDatabase>(
    create: (BuildContext context) => RickAndMortyDatabase(),
    child: const MyApp(),
    dispose: (context, db) => db.close(),
  ));
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
          home: BlocProvider<CharactersBloc>(
            create: (context) => CharactersBloc(
                repository: CharactersRepository(
              charactersDataSource: CharactersApiDataSource(
                dio: Dio(),
              ),
              db: context.read<RickAndMortyDatabase>(),
            )),
            child: const BaseScreen(),
          ),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
