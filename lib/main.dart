// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:naruto_app/compoennts/commonDrawer.dart';
import 'package:naruto_app/compoennts/commonbar.dart';
import 'package:naruto_app/items/loadingProvider.dart';
import 'package:naruto_app/items/pageProvider.dart';
import 'package:naruto_app/modules/characters/character.dart';
import 'package:go_router/go_router.dart';
import 'package:naruto_app/pages/search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './items/characterListProvider.dart';

import 'items/searchWordProvider.dart';

final _router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => MyHomePage()),
  GoRoute(path: '/search', builder: (context, state) => Search())
]);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final ScrollController _controller = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() async {
      if (_controller.position.maxScrollExtent - 100 < _controller.offset &&
          !isLoading) {
        isLoading = true;
        print("called");
        // final prefs = await SharedPreferences.getInstance();
        // String query = prefs.getString('query') ?? "";
        // await ref
        //     .read(pageProvider.notifier)
        //     .setPage(ref.read(pageProvider.notifier).state++);
        // int _page = await ref.read(pageProvider.notifier).getPage();
        // int _page = prefs.getInt("page") ?? 1;
        // print(_page);
        ref.watch(characterListProvider.notifier).updateCharacterList("");
        isLoading = false;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _characters = ref.watch(characterListProvider);
    // final query = ref.watch(searchWordProvider);
    // final _isload = ref.watch(loadingProvider);
    // final page = ref.watch(pageProvider);
    // print(page);

    // void dispose() {
    //   _controller.dispose();
    // }

    return Scaffold(
        appBar: AppbarCommon(title: "ホーム"),
        drawer: DarawerCommon(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            controller: _controller,
            itemBuilder: (content, index) {
              final character = _characters[index];
              return Card(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Center(
                        child: character.images.isNotEmpty
                            ? Image.network(
                                character.images[0],
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset('../assets/dummy.png');
                                },
                              )
                            : Image.asset('../assets/dummy.png')),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        character.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Text(
                        character.debut?["appearsIn"] ?? "なし",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    )
                  ]));
            },
            itemCount: _characters.length,
          ),
        ));
  }
}
