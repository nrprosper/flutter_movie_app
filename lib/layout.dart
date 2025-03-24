import 'package:flutter/material.dart';
import 'package:movie_app/colors.dart';
import 'package:movie_app/screens/explore_screen.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/profile_screen.dart';

class MLayout extends StatefulWidget {
  const MLayout({super.key});

  @override
  State<MLayout> createState() => _MLayoutState();
}

class _MLayoutState extends State<MLayout> {

  int currentPageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          height: 60,
          backgroundColor: MColors.themeBlack,
          selectedIndex: currentPageIdx,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onDestinationSelected: (int idx) {
            setState(() {
              currentPageIdx = idx;
            });
          },
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          elevation: 0,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home_filled), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.play_circle), label: 'Explore'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile')
          ],
      ),
      body: <Widget> [
        HomeScreen(),
        ExploreScreen(),
        ProfileScreen()
      ][currentPageIdx],
    );
  }
}

