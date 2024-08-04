import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:naruto_app/items/characterListProvider.dart';

List<List<String>> drawerLists = [
  ["ホーム", "/"],
  ["検索", "/search"]
];

class DarawerCommon extends ConsumerWidget {
  const DarawerCommon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(drawerLists[index][0]),
              onTap: () => {
                    ref
                        .read(characterListProvider.notifier)
                        .updateCharacterList(),
                    context.go(drawerLists[index][1]),
                  });
        },
        itemCount: drawerLists.length,
      ),
    );
  }
}
