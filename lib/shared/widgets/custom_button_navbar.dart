import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isShifting;

  CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    this.isShifting = true,
  }) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: widget.isShifting
          ? BottomNavigationBarType.shifting
          : BottomNavigationBarType.fixed,
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home, size: 24),
          label: 'Home',
          backgroundColor: widget.isShifting
              ? theme.primaryColor
              : Colors.white, // Uses theme primary color when shifting
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.history, size: 24),
          label: 'History',
          backgroundColor:
              widget.isShifting ? theme.primaryColor : Colors.white,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person, size: 24),
          label: 'Profile',
          backgroundColor:
              widget.isShifting ? theme.primaryColor : Colors.white,
        ),
      ],
      selectedItemColor: theme.colorScheme.secondary,
      unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
    );
  }
}
