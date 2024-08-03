import 'package:flutter/material.dart';

class AppbarCommon extends StatelessWidget implements PreferredSizeWidget {
  const AppbarCommon({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
      backgroundColor: Color(0xFFBCE2E8),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
