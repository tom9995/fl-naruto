import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:naruto_app/items/characterListProvider.dart';
import 'package:naruto_app/items/searchWordProvider.dart';

class AppbarCommon extends ConsumerWidget implements PreferredSizeWidget {
  const AppbarCommon({required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: TextButton(
          child: Text(title),
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: 25),
          ),
          onPressed: () => {
                ref.read(characterListProvider.notifier).updateCharacterList(),
                ref.read(searchWordProvider.notifier).updateQuery(""),
                context.go("/"),
              }),
      backgroundColor: Color(0xFFBCE2E8),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
