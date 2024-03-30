import 'package:flutter/material.dart';

enum AppBarType { basic, search, action }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarType appBarType;
  final String title;
  final List<Widget>? actions;
  final ValueChanged<String>? onSearch;

  CustomAppBar({
    Key? key,
    required this.appBarType,
    required this.title,
    this.actions,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (appBarType) {
      case AppBarType.basic:
        return AppBar(
          title: Text(title),
        );
      case AppBarType.search:
        return AppBar(
          title: TextField(
            onChanged: onSearch,
            decoration: const InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        );
      case AppBarType.action:
        return AppBar(
          title: Text(title),
          actions: actions,
        );
      default:
        return AppBar(); // Fallback for an undefined AppBar type
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
