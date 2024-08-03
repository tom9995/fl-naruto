import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

List<List<String>> drawerLists = [
  ["ホーム", "/"],
  ["検索", "/search"]
];

class DarawerCommon extends StatelessWidget {
  const DarawerCommon({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(drawerLists[index][0]),
            onTap: () => context.go(drawerLists[index][1]),
          );
        },
        itemCount: drawerLists.length,
      ),
    );
  }
}
