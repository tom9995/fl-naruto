// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final scrollControllerProvider =
//     StateNotifierProvider<ScrollControllerNotifier, ScrollController>((ref) {
//   return ScrollControllerNotifier();
// });

// class ScrollControllerNotifier extends StateNotifier<ScrollController> {
//   final ScrollController controller = ScrollController();

//   ScrollControllerNotifier() : super(controller) {
//     _scrollController();
//   }

//   Future<void> _scrollController() async {
//     state = controller;
//   }
// }
