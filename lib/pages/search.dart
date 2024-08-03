import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naruto_app/compoennts/commonDrawer.dart';
import 'package:naruto_app/compoennts/commonbar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? searchWord = "";

  void changeWord(String word) {
    setState(() {
      searchWord = word;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCommon(title: "検索"),
      drawer: DarawerCommon(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (String e) {
                  changeWord(e);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => context.go("/"),
              child: Text("検索"),
            )
          ],
        ),
      ),
    );
  }
}
