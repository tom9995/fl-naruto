import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final searchWordProvider =
    StateNotifierProvider<SearchWordNotifier, SearchWord>((ref) {
  return SearchWordNotifier();
});

class SearchWord {
  String query;
  SearchWord({this.query = ""});
}

class SearchWordNotifier extends StateNotifier<SearchWord> {
  SearchWordNotifier() : super(SearchWord()) {
    _loadQuery();
  }

  Future<void> _loadQuery() async {
    final prefs = await SharedPreferences.getInstance();
    final query = prefs.getString("query") ?? "";
    state = SearchWord(query: query);
  }

  Future<void> updateQuery(String query) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("query", query);
    state = SearchWord(query: query);
  }
}
