import 'package:flutter/material.dart';
import 'package:reader_tracker/pages/favorites_screen.dart';
import 'package:reader_tracker/pages/home_screen.dart';
import 'package:reader_tracker/pages/saved_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentScreenIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    SavedScreen(),
    FavoritesScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("A.Reader"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: _screens[_currentScreenIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Theme.of(context).colorScheme.inversePrimary,

          backgroundColor: Theme.of(context).colorScheme.inverseSurface,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.save), label: "Saved"),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorites",
            ),
          ],
          currentIndex: _currentScreenIndex,
          onTap: (screenIndex) {
            setState(() {
              _currentScreenIndex = screenIndex;
            });
          },
        ),
      ),
    );
  }
}
