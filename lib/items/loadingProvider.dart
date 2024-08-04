import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final loadingProvider =
    StateNotifierProvider<IsLoadingNotifier, IsLoading>((ref) {
  return IsLoadingNotifier();
});

class IsLoading {
  bool isloading;
  IsLoading({this.isloading = false});
}

class IsLoadingNotifier extends StateNotifier<IsLoading> {
  IsLoadingNotifier() : super(IsLoading()) {
    _isLoad();
  }

  Future<void> _isLoad() async {
    final prefs = await SharedPreferences.getInstance();
    bool isloading = prefs.getBool("load") ?? false;
    state = IsLoading(isloading: !isloading);
  }
}
