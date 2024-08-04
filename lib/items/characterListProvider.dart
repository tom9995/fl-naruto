import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:naruto_app/items/searchWordProvider.dart';
import 'package:naruto_app/modules/characters/character.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'searchWordProvider.dart';

final characterListProvider =
    StateNotifierProvider<CharacterlistNotifier, List<Character>>((ref) {
  return CharacterlistNotifier();
});

class CharacterlistNotifier extends StateNotifier<List<Character>> {
  // String query;

  CharacterlistNotifier() : super([]) {
    updateCharacterList();
  }

  Future<void> updateCharacterList([String? query = ""]) async {
    print("update");
    final _limit = 15;
    List<Character> _characters = [];
    int _page = 1;

    var response;
    if (query == "") {
      String _apiUrl = "https://narutodb.xyz/api/character";
      response = await Dio().get(_apiUrl, queryParameters: {
        "page": _page,
        "limit": _limit,
      });
    } else {
      String _apiUrl = "https://narutodb.xyz/api/character/search";
      response = await Dio().get(_apiUrl,
          queryParameters: {"page": _page, "limit": _limit, "name": query});
    }

    final List<dynamic> data = response.data["characters"];
    _characters = [..._characters, ...data.map((d) => Character.fromJson(d))];
    state = _characters;
    print(_characters);
  }
}
