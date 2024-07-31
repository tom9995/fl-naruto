// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:naruto_app/modules/characters/character.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
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

  List<Character> _characters = [];

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    final response = await Dio().get(_apiUrl);
    final List<dynamic> data = response.data["characters"];
    setState(() {
      _characters = data.map((d) => Character.fromJson(d)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("NARUTO図鑑"),
          backgroundColor: Color(0xFFBCE2E8),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
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
