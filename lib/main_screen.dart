import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart';
import 'features/features.dart';
import 'features/home/presentation/screens/order_history_screen.dart';
import 'shared/shared.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    OrderHistoryScreen(),
    ProfileScreen(),
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileBloc(sharedPreferencesHelper: SharedPreferencesHelper())
            ..add(LoadProfileEvent()),
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onNavBarTap,
          isShifting: false, // Set to true if you want shifting behavior
        ),
      ),
    );
  }
}
