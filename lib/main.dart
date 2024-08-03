// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:naruto_app/compoennts/commonDrawer.dart';
import 'package:naruto_app/compoennts/commonbar.dart';
import 'package:naruto_app/modules/characters/character.dart';
import 'package:go_router/go_router.dart';
import 'package:naruto_app/pages/search.dart';

final _router = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => MyHomePage()),
  GoRoute(path: '/search', builder: (context, state) => Search())
]);

void main() {
  runApp(const MyApp());
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _apiUrl = "https://narutodb.xyz/api/character";
  final _limit = 15;
  List<Character> _characters = [];
  int _page = 1;
  final ScrollController _controller = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCharacters();
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent - 100 < _controller.offset) {
        fetchCharacters();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> fetchCharacters([String? word]) async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    final response = await Dio().get(_apiUrl, queryParameters: {
      "page": _page,
      "limit": _limit,
      "search": word ?? ""
    });
    final List<dynamic> data = response.data["characters"];
    setState(() {
      _characters = [..._characters, ...data.map((d) => Character.fromJson(d))];
      _page++;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
