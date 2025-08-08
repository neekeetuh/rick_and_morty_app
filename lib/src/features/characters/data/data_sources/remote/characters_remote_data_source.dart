import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/src/config/api_config.dart';
import 'package:rick_and_morty_app/src/features/characters/data/data_sources/remote/characters_remote_data_source_interface.dart';
import 'package:rick_and_morty_app/src/features/characters/data/dtos/character_dto.dart';

class CharactersRemoteDataSource implements ICharactersRemoteDataSource {
  final Dio _dio;

  CharactersRemoteDataSource({required Dio dio}) : _dio = dio;
  @override
  Future<List<CharacterDto>> fetchCharacters({int page = 1}) async {
    try {
      final response = await _dio.get(
        '${ApiConfig.baseUrl}/${ApiConfig.charactersEndpoint}',
        queryParameters: {'page': page},
      );
      final data = response.data as Map<String, dynamic>;
      final charactersDtosListData = data['results'] as List<dynamic>;
      final charactersDtosList = charactersDtosListData
          .map((json) => CharacterDto.fromJson(json))
          .toList();
      return charactersDtosList;
    } on DioException catch (e) {
      throw SocketException('${e.message}');
    }
  }
}
