import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:naruto_app/compoennts/commonDrawer.dart';
import 'package:naruto_app/compoennts/commonbar.dart';
import 'package:naruto_app/items/characterListProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../items/searchWordProvider.dart';

class Search extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    final searchWord = ref.watch(searchWordProvider);

    void changeWord(String word) {
      ref.read(searchWordProvider.notifier).updateQuery(word);
    }

    return Scaffold(
      appBar: const AppbarCommon(title: "検索"),
      drawer: const DarawerCommon(),
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
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                String query = prefs.getString('query') ?? "";
                ref
                    .read(characterListProvider.notifier)
                    .updateCharacterList(query);
                context.go("/");
              },
              child: const Text("検索"),
            )
          ],
        ),
      ),
    );
  }
}
