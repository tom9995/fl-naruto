import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final pageProvider = StateNotifierProvider<PageNotifier, int>((ref) {
  return PageNotifier();
});

class PageNotifier extends StateNotifier<int> {
  // String query;

  PageNotifier() : super(1) {
    getPage();
  }

  Future<int> getPage() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getInt("page") ?? 1;
    if (state == 1) setPage(state);
    return state;
  }

  Future<void> setPage(int page) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("page", page);
  }
}
