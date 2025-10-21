import 'package:flutter/material.dart';
import 'package:sparkle/screens/albums_screen.dart';
import 'package:sparkle/screens/home_screen.dart';
import 'package:sparkle/screens/swipe_screen.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({super.key});

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          AlbumsScreen(),
          HomeScreen(),
          SwipeScreen(),
        ],
      ),
    );
  }
}
