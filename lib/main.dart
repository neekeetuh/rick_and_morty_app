import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/firebase_options.dart';
import 'package:rick_and_morty_app/src/common/consts/string_consts.dart';
import 'package:rick_and_morty_app/src/common/theme/theme_provider.dart';
import 'package:rick_and_morty_app/src/common/theme/themes.dart';
import 'package:rick_and_morty_app/src/features/auth/data/auth_repository.dart';
import 'package:rick_and_morty_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rick_and_morty_app/src/features/characters/data/data_sources/local/characters_local_data_source.dart';
import 'package:rick_and_morty_app/src/features/characters/data/data_sources/local/firestore_characters_data_source.dart';
import 'package:rick_and_morty_app/src/features/characters/data/data_sources/remote/characters_remote_data_source.dart';
import 'package:rick_and_morty_app/src/features/characters/data/database/database.dart';
import 'package:rick_and_morty_app/src/features/characters/data/repositories/characters_repository.dart';
import 'package:rick_and_morty_app/base_screen.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/bloc/bloc/characters_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Provider<RickAndMortyDatabase>(
    create: (BuildContext context) => RickAndMortyDatabase(),
    child: const MyApp(),
    dispose: (context, db) => db.close(),
  ));
}

//for test purposes only
const bool isFirestore = true;

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
          home: MultiBlocProvider(
            providers: [
              BlocProvider<CharactersBloc>(
                create: (context) => CharactersBloc(
                    repository: CharactersRepository(
                  charactersDataSource: CharactersRemoteDataSource(
                    dio: Dio(),
                  ),
                  localDataSource: isFirestore
                      ? FirestoreCharactersDataSource()
                      : CharactersLocalDataSource(
                          db: context.read<RickAndMortyDatabase>()),
                )),
              ),
              BlocProvider(
                create: (context) => AuthBloc(repository: AuthRepository()),
              ),
            ],
            child: const BaseScreen(),
          ),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
