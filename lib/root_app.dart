import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:spotify/favorite.dart';
import 'package:spotify/search.dart';
import 'package:spotify/settings.dart';

import 'homepage.dart';

enum NavIcon { home, favorite, search, settings }

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  NavIcon selectedIcon = NavIcon.home;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    alignment: Alignment.bottomCenter,
                    child: const HomePage(),
                    type: PageTransitionType.scale,
                  ),
                );

                setState(() {
                  selectedIcon = NavIcon.home;
                });
              },
              child: Icon(
                Icons.home,
                size: 30,
                color:
                    selectedIcon == NavIcon.home ? Colors.green : Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    alignment: Alignment.bottomCenter,
                    child: Favorite(),
                    type: PageTransitionType.scale,
                  ),
                );

                setState(() {
                  selectedIcon = NavIcon.favorite;
                });
              },
              child: Icon(
                Icons.favorite,
                size: 30,
                color: selectedIcon == NavIcon.favorite
                    ? Colors.green
                    : Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    alignment: Alignment.bottomCenter,
                    child: Search(),
                    type: PageTransitionType.scale,
                  ),
                );

                setState(() {
                  selectedIcon = NavIcon.search;
                });
              },
              child: Icon(
                Icons.search,
                size: 30,
                color: selectedIcon == NavIcon.search
                    ? Colors.green
                    : Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    alignment: Alignment.bottomCenter,
                    child: Settings(),
                    type: PageTransitionType.scale,
                  ),
                );

                setState(() {
                  selectedIcon = NavIcon.settings;
                });
              },
              child: Icon(
                Icons.settings,
                size: 30,
                color: selectedIcon == NavIcon.settings
                    ? Colors.green
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
